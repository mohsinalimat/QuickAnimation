//
//  UILabel+Animation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickAnimationBlock.h"

@interface UILabel (Animation)

@property (readonly,nonatomic) QuickTypeWriteTextBlock WriteTextTo;
@property (readonly,nonatomic) QuickColorBlock TextColorTo;

@end
