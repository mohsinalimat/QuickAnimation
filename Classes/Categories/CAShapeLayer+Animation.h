//
//  CAShapeLayer+Animation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "QuickAnimationBlock.h"

@interface CAShapeLayer (Animation)


/**
 Create the strokeStart and the strokeEnd changing animation
 */
@property (readonly,nonatomic) QuickStrokeRangeBlock StrokeRangeTo;

/**
 *  Create the stroke color changing animation
 */
@property (readonly,nonatomic) QuickColorBlock StrokeColorTo;

/**
 *  Create the fill color changing animation
 */
@property (readonly,nonatomic) QuickColorBlock FillColorTo;

/**
 Create the layer's lineWidth changing animation
 */
@property (readonly,nonatomic) QuickFloatBlock LineWidthTo;

@end
