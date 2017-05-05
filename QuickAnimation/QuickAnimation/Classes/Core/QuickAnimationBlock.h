//
//  QuickAnimationBlock.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#ifndef QuickAnimationBlock_h
#define QuickAnimationBlock_h

#import "QuickAnimationEnum.h"

@class QuickAnimationTween;
@protocol QuickAnimation;

typedef id<QuickAnimation> (^SetLoopBlock)(NSInteger count,QuickAnimationLoopType type);

typedef id<QuickAnimation> (^SetDelayBlock)(CGFloat delay);

typedef id<QuickAnimation> (^SetEaseBlock)(QuickAnimationEaseType ease);

typedef id<QuickAnimation> (^FromBlock)();

typedef void (^QuickAnimationCallBack)(id<QuickAnimation> anim);

typedef void (^QuickAnimationValueProgress)(float current, float duration,float valueProgress);

typedef QuickAnimationTween* (^QuickPointBlock)(CGPoint value,CGFloat duration);

typedef QuickAnimationTween* (^QuickFloatBlock)(CGFloat value,CGFloat duration);

typedef QuickAnimationTween* (^QuickFadeBlock)(CGFloat alpha,CGFloat duration);

typedef QuickAnimationTween* (^QuickColorBlock)(UIColor* color,CGFloat duration);

typedef QuickAnimationTween* (^QuickScaleBlock)(CGPoint scale,CGPoint anchorPoint,CGFloat duration);

typedef QuickAnimationTween* (^QuickScaleWHBlock)(CGFloat scale,CGFloat anchor,CGFloat duration);

typedef QuickAnimationTween* (^QuickRotationBlock)(CGFloat rotation,CGFloat duration);

typedef QuickAnimationTween* (^QuickRotationAroundXYZBlock)(CGFloat xRotation,CGFloat yRotation,CGFloat zRotation,CGFloat duration);

typedef QuickAnimationTween* (^QuickTypeWriteTextBlock)(NSString* text,CGFloat duration);

typedef QuickAnimationTween* (^QuickShakeRotationBlock)(CGFloat rotationStrength, NSInteger shakeCount ,CGFloat duration);

typedef QuickAnimationTween* (^QuickShakePositionBlock)(CGPoint posStrength, NSInteger shakeCount ,CGFloat duration);

typedef QuickAnimationTween* (^QuickShakeScaleBlock)(CGPoint scaleStrength, NSInteger shakeCount ,CGFloat duration);

#endif /* QuickAnimationBlock_h */