//
//  QuickAnimationBezierUtil.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimationBezierUtil.h"
#import <math.h>
#import <CoreText/CoreText.h>



/**
 Point data in bezier path
 */
@interface BezierPoint:NSObject

@property (assign,nonatomic) CGPathElementType type;
@property (assign,nonatomic) CGFloat normalDistance;
@property (assign,nonatomic) CGPoint startPoint;
@property (assign,nonatomic) CGPoint endPoint;
@property (assign,nonatomic) CGPoint controlPoint1;
@property (assign,nonatomic) CGPoint controlPoint2;

@end

@implementation BezierPoint

@end


/**
 bezier calculate formula
 
 */
NS_INLINE CGFloat _linearFormula(CGFloat p0,CGFloat p1,CGFloat t){
    //P0 + (P1-P0)*t
    return p0 + (p1-p0)*t;
}

NS_INLINE CGFloat _squareFormula(CGFloat p0,CGFloat p1,CGFloat p2,CGFloat t){
    // (1-t)^2*P0 + 2*t*(1-t)*P1 + t^2*P2
    return (1-t)*(1-t)*p0 + 2*t*(1-t)*p1 + t*t*p2;
}

NS_INLINE CGFloat _cubedFormula(CGFloat p0,CGFloat p1,CGFloat p2,CGFloat p3,CGFloat t){
    //P0*(1-t)^3 + 3*P1*t*(1-t)^2 + 3*P2*t^2*(1-t) +P3*t^3
    return p0*(1-t)*(1-t)*(1-t) + 3*p1*t*(1-t)*(1-t) + 3*p2*t*t*(1-t) +p3*t*t*t;
}

/**
 Using 'CGPathAppy' to convert a path to a point array
 */
NS_INLINE void PathToPointArray(void *info, const CGPathElement *element) {
    
    NSMutableArray<BezierPoint*> *bezierPoints = (__bridge NSMutableArray *)info;
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    BezierPoint* point = [[BezierPoint alloc]init];
    point.type = type;
    
    switch(type) {
            
        case kCGPathElementMoveToPoint: // contains 1 point
            
            point.startPoint = points[0];
            point.endPoint = points[0];
            [bezierPoints addObject:point];
            
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            
            if (bezierPoints.count > 0)
                point.startPoint = bezierPoints.lastObject.endPoint;
            point.endPoint = points[0];
            
            [bezierPoints addObject:point];
            
            break;
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            
            if (bezierPoints.count > 0)
                point.startPoint = bezierPoints.lastObject.endPoint;
            point.controlPoint1 = points[0];
            point.endPoint = points[1];
            [bezierPoints addObject:point];
            

            break;
        case kCGPathElementAddCurveToPoint: // contains 3 points
            
            if (bezierPoints.count > 0)
                point.startPoint = bezierPoints.lastObject.endPoint;
            point.controlPoint1 = points[0];
            point.controlPoint2 = points[1];
            point.endPoint = points[2];
            [bezierPoints addObject:point];
            
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
    
    point.normalDistance = sqrtf(
                                 powf(point.endPoint.x - point.startPoint.x, 2)+
                                 powf(point.endPoint.y - point.startPoint.y, 2)
                                 );
    
}



@interface QuickAnimationBezierUtil(){
    CGFloat distance;
    NSMutableArray<BezierPoint*>* points;
}

@end

@implementation QuickAnimationBezierUtil

+ (UIBezierPath*)createBezierPathFrom:(NSAttributedString *)string size:(CGSize)size{
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [string length]), path, NULL);
    
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
    CFRelease(frame);
    CFRelease(frameSetter);
    
    return bpath;

}

-(instancetype)initWithBezierPath:(UIBezierPath*)path{
    if (self = [super init]){
        points = [NSMutableArray array];
        distance = 0;
        [self parseUIBezierPath:path];
        [points enumerateObjectsUsingBlock:^(BezierPoint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            distance += obj.normalDistance;
        }];
    }
    return self;
}

- (instancetype)init{
    return nil;
}

- (CGPoint)pointAt:(CGFloat)valueProgress{
    CGFloat currentDistance = 0;
    CGFloat desDistance = valueProgress * distance;
    for (BezierPoint* p in points){
        if (desDistance >=currentDistance && desDistance <= currentDistance + p.normalDistance){
            
            CGFloat x = p.endPoint.x;
            CGFloat y = p.endPoint.y;
            
            CGFloat div = p.normalDistance;
            CGFloat innerValueProgress = 0;
            if (div != 0){
                innerValueProgress =  (desDistance - currentDistance) / div;
            }
            switch (p.type) {
                case kCGPathElementAddLineToPoint:
                    //P0 + (P1-P0)*t
                    x = _linearFormula(p.startPoint.x, p.endPoint.x, innerValueProgress);
                    y = _linearFormula(p.startPoint.y, p.endPoint.y, innerValueProgress);
                    break;
                case kCGPathElementAddQuadCurveToPoint:
                    // (1-t)^2*P0 + 2*t*(1-t)*P1 + t^2*P2
                   
                    x = _squareFormula(p.startPoint.x,p.controlPoint1.x,p.endPoint.x, innerValueProgress);
                    y = _squareFormula(p.startPoint.y,p.controlPoint1.y,p.endPoint.y, innerValueProgress);
                    break;
                case kCGPathElementAddCurveToPoint:
                    // P0*(1-t)^3 + 3*P1*t*(1-t)^2 + 3*P2*t^2*(1-t) +P3*t^3
                    x = _cubedFormula(p.startPoint.x,p.controlPoint1.x,p.controlPoint2.x,p.endPoint.x, innerValueProgress);
                    y = _cubedFormula(p.startPoint.y,p.controlPoint1.y,p.controlPoint2.y,p.endPoint.y, innerValueProgress);
                    break;
                default:
                    break;
            }
            
            return CGPointMake(x, y);
        }
        currentDistance += p.normalDistance;
    }
    return CGPointZero;
}

- (void)parseUIBezierPath:(UIBezierPath*)path{
    CGPathApply(path.CGPath, (__bridge void * _Nullable)(points), PathToPointArray);
}






@end



