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


/**
 Quickly create moving animations, moving center to the value
 CGPoint value : target center
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickPointBlock MoveTo;

/**
 Quickly create moving animations, moving center.x to the value
 CGFloat value : target center.x
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickFloatBlock MoveXTo;

/**
 Quickly create moving animations, moving center.y to the value
 CGFloat value : target center.y
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickFloatBlock MoveYTo;

/**
 Quickly create moving animations, move offset from the current center
 CGPoint value : offset
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickPointBlock MoveBy;
/**
 Quickly create moving animations, move x offset from the current center
 CGFloat value : x offset
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickFloatBlock MoveXBy;
/**
 Quickly create moving animations, move y offset from the current center
 CGFloat value : y offset
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickFloatBlock MoveYBy;

/**
 Quickly create a alpha change animation
 CGFloat alpha : target alpha
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickFadeBlock FadeTo;

/**
 Quickly create a backgroundColor change animation
 UIColor color : target backgroundColor color
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickColorBlock ColorTo;

/**
 Quickly create zoom animations
 CGPoint scale : width and height zoom multiple
 CGPoint anchorPoint 
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickScaleBlock ScaleTo;
/**
 Quickly create zoom animations
 CGFloat scale : x zoom multiple
 CGFloat anchor : X anchor point
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickScaleWHBlock ScaleWidthTo;
/**
 Quickly create zoom animations
 CGFloat scale : height zoom multiple
 CGFloat anchor : height anchor point
 CGFloat duration : the duration of animation
 */
@property (readonly,nonatomic) QuickScaleWHBlock ScaleHeightTo;

/**
 Quickly create animations，rotate around z axis
 CGFloat rotation : angle
 CGFloat duration
 */
@property (readonly,nonatomic) QuickRotationBlock RotationTo;

/**
 Quickly create rotation animations
 CGFloat xRotation : rotation angle around x axis
 CGFloat yRotation : rotation angle around y axis
 CGFloat zRotation : rotation angle around z axis
 CGFloat duration
 */
@property (readonly,nonatomic) QuickRotationAroundXYZBlock RotationAllAxisTo;

/**
 Quickly create shake animation
 */
@property (readonly,nonatomic) QuickShakeRotationBlock ShakeRotation;
@property (readonly,nonatomic) QuickShakePositionBlock ShakePosition;



@end
