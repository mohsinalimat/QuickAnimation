//
//  UIView+Animation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickAnimationBlock.h"

@class QuickAnimationTween;



@interface UIView(Animation)

@property (readonly,nonatomic) QuickPointBlock MoveTo;
@property (readonly,nonatomic) QuickFloatBlock MoveXTo;
@property (readonly,nonatomic) QuickFloatBlock MoveYTo;

@property (readonly,nonatomic) QuickPointBlock MoveBy;
@property (readonly,nonatomic) QuickFloatBlock MoveXBy;
@property (readonly,nonatomic) QuickFloatBlock MoveYBy;

@property (readonly,nonatomic) QuickFadeBlock FadeTo;
@property (readonly,nonatomic) QuickColorBlock ColorTo;

@property (readonly,nonatomic) QuickScaleBlock ScaleTo;
@property (readonly,nonatomic) QuickScaleWHBlock ScaleWidthTo;
@property (readonly,nonatomic) QuickScaleWHBlock ScaleHeightTo;

@property (readonly,nonatomic) QuickRotationBlock RotationTo;
@property (readonly,nonatomic) QuickRotationAroundXYZBlock RotationAllAxisTo;

@property (readonly,nonatomic) QuickShakeRotationBlock ShakeRotation;
@property (readonly,nonatomic) QuickShakePositionBlock ShakePosition;
@property (readonly,nonatomic) QuickShakeScaleBlock ShakeScale;


@end
