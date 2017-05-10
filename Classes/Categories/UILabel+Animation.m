//
//  UILabel+Animation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "UILabel+Animation.h"
#import "QuickAnimationTween.h"
#import "NSValue+Interpolation.h"
#import "QuickAnimationBezierUtil.h"
#import <CoreText/CoreText.h>

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
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
        [attString addAttribute:(id)kCTForegroundColorAttributeName value:self.textColor range:NSMakeRange(0 , text.length)];
        CGFloat fontSize = self.font.pointSize;
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font.fontName, fontSize, NULL);
        [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, text.length)];
        CFRelease(fontRef);
        
        CAShapeLayer* shape = [CAShapeLayer layer];
        [self.layer addSublayer:shape];
        UIBezierPath* path = [QuickAnimationBezierUtil createBezierPathFrom:attString size:self.frame.size];
        shape.path = path.CGPath;
        shape.frame = self.bounds;
        shape.fillColor = nil;
        shape.geometryFlipped = YES;
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


@end
