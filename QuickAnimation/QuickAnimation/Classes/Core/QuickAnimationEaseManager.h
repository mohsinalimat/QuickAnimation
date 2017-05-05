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
 *  根据播放时间和动画持续时间，计算并返回一个0到1的浮点数，表示动画值目前的进度
 *
 *  @param easeType 缓动函数类型
 *  @param time     播放时间
 *  @param duration 持续时间
 *
 *  @return 0-1
 */
+(float)evalute:(QuickAnimationEaseType)easeType time:(float)time duration:(float)duration;
/**
 *  根据播放时间和动画持续时间，计算并返回一个0到1的浮点数，表示动画值目前的进度
 *
 *  @param easeType 缓动函数类型
 *  @param time     播放时间
 *  @param duration 持续时间
 *  @param overshootOrAmplitude 振幅
 *  @param period 时间范围
 *  @return 0-1
 */
+(float)evalute:(QuickAnimationEaseType)easeType time:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period;

@end
