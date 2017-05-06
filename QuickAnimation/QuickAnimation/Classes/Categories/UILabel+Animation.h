//
//  UILabel+Animation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickAnimationBlock.h"

@interface UILabel (Animation)


/**
 Quickly create typewriter animation
 */
@property (readonly,nonatomic) QuickTypeWriteTextBlock WriteTextTo;

/**
 Quickly create animations that change the font color
 */
@property (readonly,nonatomic) QuickColorBlock TextColorTo;

@end
