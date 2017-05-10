//
//  CALayer+Animation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "CALayer+Animation.h"
#import "QuickAnimationTween.h"
#import "NSValue+Interpolation.h"

@implementation CALayer (Animation)


- (QuickLayerCornerBlock)CornerRadiusTo{
    return ^QuickAnimationTween* (CGFloat toCornerRadius,CGFloat duration){
        
        CGFloat oldRadius = self.cornerRadius;
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat value = [NSValue floatWithFrom:oldRadius to:toCornerRadius progress:valueProgress];
            self.cornerRadius = value;
            
        }];
        tween.duration = duration;
        return tween;
        
    };
}

- (QuickShadowOpacityBlock)ShadowOpacityTo{
    return ^QuickAnimationTween* (CGFloat toOpacity,CGFloat duration){
        
        CGFloat oldOpacity = self.shadowOpacity;
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat value = [NSValue floatWithFrom:oldOpacity to:toOpacity progress:valueProgress];
            self.shadowOpacity = value;
            
        }];
        tween.duration = duration;
        return tween;
        
    };
}

- (QuickShadowOffsetBlock)ShadowOffsetTo{
    return ^QuickAnimationTween* (CGPoint toOffset,CGFloat duration){
        
        CGPoint oldOffset = CGPointMake(self.shadowOffset.width, self.shadowOffset.height);
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGPoint value = [NSValue pointWithFrom:oldOffset to:toOffset progress:valueProgress];
            self.shadowOffset = CGSizeMake(value.x, value.y);
            
        }];
        tween.duration = duration;
        return tween;
        
    };
}

- (QuickShadowRadiusBlock)ShadowRadiusTo{
    return ^QuickAnimationTween* (CGFloat toShadowRadius,CGFloat duration){
        
        CGFloat oldShadowRadius = self.shadowRadius;
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat value = [NSValue floatWithFrom:oldShadowRadius to:toShadowRadius progress:valueProgress];
            self.shadowRadius = value;
            
        }];
        tween.duration = duration;
        return tween;
        
    };

}

- (QuickColorBlock)ShadowColorTo{
    
    return ^QuickAnimationTween* (UIColor* color,CGFloat duration){
        UIColor* fromValue = [UIColor colorWithCGColor:self.shadowColor];
        UIColor* toValue =  color;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            UIColor* currentValue = [NSValue colorWithFrom:fromValue to:toValue progress:valueProgress];
            self.shadowColor = currentValue.CGColor;
        }];
        tween.duration = duration;
        return tween;
    };

}

- (QuickFloatBlock)BorderWidthTo{
    return ^QuickAnimationTween* (CGFloat des,CGFloat duration){
        CGFloat fromValue = self.borderWidth;
        CGFloat toValue = des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat value = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.borderWidth = value;
        }];
        tween.duration = duration;
        return tween;
    };
}

- (QuickColorBlock)BorderColorTo{
    
    return ^QuickAnimationTween* (UIColor* color,CGFloat duration){
        UIColor* fromValue = [UIColor colorWithCGColor:self.borderColor];
        UIColor* toValue =  color;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            UIColor* currentValue = [NSValue colorWithFrom:fromValue to:toValue progress:valueProgress];
            self.borderColor = currentValue.CGColor;
        }];
        tween.duration = duration;
        return tween;
    };
}

@end
