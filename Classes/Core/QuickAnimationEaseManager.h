//
//  QuickAnimationEaseManager.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickAnimationEnum.h"

@interface QuickAnimationEaseManager : NSObject

/**
 *  According to the playing time and animation duration, calculate and return a 0 to 1 floating point, said the current value of the animation
 *
 *  @param easeType Easing function type
 *  @param time     current time
 *  @param duration the duration of animation
 *
 *  @return 0-1
 */
+(float)evalute:(QuickAnimationEaseType)easeType time:(float)time duration:(float)duration;
/**
 *  According to the playing time and animation duration, calculate and return a 0 to 1 floating point, said the current value of the animation
 *
 *  @param easeType Easing function type
 *  @param time     current time
 *  @param duration the duration of animation
 *  @param overshootOrAmplitude amplitude,used for bounces
 *  @param period period, used for bounces
 *  @return 0-1
 */
+(float)evalute:(QuickAnimationEaseType)easeType time:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period;

@end
