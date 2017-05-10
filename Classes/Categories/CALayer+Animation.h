//
//  CALayer+Animation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "QuickAnimationBlock.h"


@interface CALayer (Animation)


/**
 Create the radius changing animation
 */
@property (readonly,nonatomic) QuickLayerCornerBlock CornerRadiusTo;

/**
 *  Create the shadowOpacity changing animation
 */
@property (readonly,nonatomic) QuickShadowOpacityBlock ShadowOpacityTo;

/**
 *  Create the shadowOffset changing animation
 */
@property (readonly,nonatomic) QuickShadowOffsetBlock ShadowOffsetTo;

/**
 *  Create the shadow's blur radius changing animation
 */
@property (readonly,nonatomic) QuickShadowRadiusBlock ShadowRadiusTo;

/**
 *  Create the shadow's color changing animation
 */
@property (readonly,nonatomic) QuickColorBlock ShadowColorTo;

/**
 Create the layer's borderWidth changing animation
 */
@property (readonly,nonatomic) QuickFloatBlock BorderWidthTo;

/**
 Create the layer's borderColor changing animation
 */
@property (readonly,nonatomic) QuickColorBlock BorderColorTo;

@end
