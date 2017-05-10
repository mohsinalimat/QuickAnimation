//
//  CAShapeLayer+Animation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "CAShapeLayer+Animation.h"
#import "QuickAnimationTween.h"
#import "NSValue+Interpolation.h"

@implementation CAShapeLayer (Animation)

- (QuickStrokeRangeBlock)StrokeRangeTo{
    return ^QuickAnimationTween* (CGFloat start,CGFloat end,CGFloat duration){
        
        NSAssert(start <= end, @"error value");
        
        CGFloat oldStart = self.strokeStart;
        CGFloat oldEnd = self.strokeEnd;
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat sValue = [NSValue floatWithFrom:oldStart to:start progress:valueProgress];
            CGFloat eValue = [NSValue floatWithFrom:oldEnd to:end progress:valueProgress];
            self.strokeStart = sValue;
            self.strokeEnd = eValue;
        
        }];
        tween.duration = duration;
        return tween;
        
    };
}

- (QuickColorBlock)StrokeColorTo{
    
    return ^QuickAnimationTween* (UIColor* color,CGFloat duration){
        UIColor* fromValue = [UIColor colorWithCGColor:self.strokeColor];
        UIColor* toValue =  color;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            UIColor* currentValue = [NSValue colorWithFrom:fromValue to:toValue progress:valueProgress];
            self.strokeColor = currentValue.CGColor;
        }];
        tween.duration = duration;
        return tween;
    };
    
}

- (QuickColorBlock)FillColorTo{
    
    return ^QuickAnimationTween* (UIColor* color,CGFloat duration){
        
        UIColor* fromValue = [UIColor colorWithCGColor:self.fillColor];
        UIColor* toValue =  color;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            UIColor* currentValue = [NSValue colorWithFrom:fromValue to:toValue progress:valueProgress];
            self.fillColor = currentValue.CGColor;
        }];
        tween.duration = duration;
        return tween;
    };
    
}

- (QuickFloatBlock)LineWidthTo{
    return ^QuickAnimationTween* (CGFloat des,CGFloat duration){
        CGFloat fromValue = self.lineWidth;
        CGFloat toValue = des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat value = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.lineWidth = value;
        }];
        tween.duration = duration;
        return tween;
    };
}

@end
