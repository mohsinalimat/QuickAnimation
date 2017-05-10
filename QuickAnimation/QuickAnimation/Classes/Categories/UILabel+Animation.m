//
//  UILabel+Animation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "UILabel+Animation.h"
#import "QuickAnimationTween.h"
#import <CoreText/CoreText.h>
#import "NSValue+Interpolation.h"

@implementation UILabel (Animation)

- (QuickTypeWriteTextBlock)WriteTextTo{
    return ^QuickAnimationTween* (NSString* text,CGFloat duration){
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat subToIndex = [NSValue integerWithFrom:0 to:text.length progress:valueProgress];
            if (subToIndex < text.length){
                self.text = [text substringToIndex:subToIndex];
            }else{
                self.text = text;
            }
        }];
        tween.duration = duration;
        return tween;
        
    };
}

- (QuickColorBlock)TextColorTo{
    
    return ^QuickAnimationTween* (UIColor* color,CGFloat duration){
        UIColor* fromValue = self.textColor;
        UIColor* toValue =  color;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            UIColor* currentValue = [NSValue colorWithFrom:fromValue to:toValue progress:valueProgress];
            self.textColor = currentValue;
        }];
        tween.duration = duration;
        return tween;
    };
}

- (QuickHandWriteTextBlock)HandWriteTo{
    
    return ^QuickAnimationTween* (NSString* text,CGFloat duration){
        
        CAShapeLayer* shape = [CAShapeLayer layer];
        [self.layer addSublayer:shape];
        UIBezierPath* path = [self _bezierPathFrom:text size:self.frame.size];
        shape.path = path.CGPath;
        shape.frame = self.bounds;
        shape.geometryFlipped = YES;
        shape.fillColor = nil;
        shape.strokeColor = self.textColor.CGColor;
        shape.strokeStart = 0;
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat value = [NSValue floatWithFrom:0 to:1 progress:valueProgress];
            shape.strokeEnd = value;
        }];
        tween.duration = duration;
        return tween;
        
    };
    
}

- (UIBezierPath *)_bezierPathFrom:(NSString *)string size:(CGSize)size{
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:self.textColor range:NSMakeRange(0 , string.length)];
    CGFloat fontSize = self.font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font.fontName, fontSize, NULL);
    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, string.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger lineCount = CFArrayGetCount(lines);
    
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);


    for (CFIndex lineIndex = 0 ;lineIndex < lineCount;lineIndex++){
        CFArrayRef runArray = CTLineGetGlyphRuns(
                                                 (CTLineRef)CFArrayGetValueAtIndex(lines,lineIndex)
                                                 );
        // for each run
        for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
            // Get Font for this run
            CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
            CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
            // for each GLyph in run
            for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
                // get Glyph & Glyph-data
                CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                CGGlyph glyph;
                CGPoint position;
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                position = CGPointMake(position.x+lineOrigins[lineIndex].x, position.y+lineOrigins[lineIndex].y);
                // Get path of outline
                {
                    CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                    CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                    CGPathAddPath(letters, &t, letter);
                    CGPathRelease(letter);
                }
            }
        }
    }
    
    
    
    UIBezierPath *bpath = [UIBezierPath bezierPath];
    [bpath moveToPoint:CGPointZero];
    [bpath appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CFRelease(path);
    CFRelease(letters);
    CFRelease(fontRef);
    CFRelease(frame);
    CFRelease(frameSetter);
    
    return bpath;
}


@end
