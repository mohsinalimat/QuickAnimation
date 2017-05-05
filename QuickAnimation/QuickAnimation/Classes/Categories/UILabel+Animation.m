//
//  UILabel+Animation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "UILabel+Animation.h"
#import "QuickAnimationTween.h"
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

@end
