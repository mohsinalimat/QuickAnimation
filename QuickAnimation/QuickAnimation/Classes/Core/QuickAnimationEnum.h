//
//  QAEase.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#ifndef QAEnum_h
#define QAEnum_h

/**
 动画循环模式
 */
typedef enum : NSUInteger {
    
    /**
     *  每轮动画播放完毕以后，将从头开始，重新播放动画
     */
    QuickAnimationLoopRestart,
    /**
     *  动画播放完毕后，将倒序播放
     */
    QuickAnimationLoopYoyo,
    
} QuickAnimationLoopType;


/**
 动画播放缓动函数类型
 */
typedef enum : NSUInteger {
    QuickAnimationUnset,
    QuickAnimationEaseLinear,
    QuickAnimationEaseInSine,
    QuickAnimationEaseOutSine,
    QuickAnimationEaseInOutSine,
    QuickAnimationEaseInQuad,
    QuickAnimationEaseOutQuad,
    QuickAnimationEaseInOutQuad,
    QuickAnimationEaseInCubic,
    QuickAnimationEaseOutCubic,
    QuickAnimationEaseInOutCubic,
    QuickAnimationEaseInQuart,
    QuickAnimationEaseOutQuart,
    QuickAnimationEaseInOutQuart,
    QuickAnimationEaseInQuint,
    QuickAnimationEaseOutQuint,
    QuickAnimationEaseInOutQuint,
    QuickAnimationEaseInExpo,
    QuickAnimationEaseOutExpo,
    QuickAnimationEaseInOutExpo,
    QuickAnimationEaseInCirc,
    QuickAnimationEaseOutCirc,
    QuickAnimationEaseInOutCirc,
    QuickAnimationEaseInElastic,
    QuickAnimationEaseOutElastic,
    QuickAnimationEaseInOutElastic,
    QuickAnimationEaseInBack,
    QuickAnimationEaseOutBack,
    QuickAnimationEaseInOutBack,
    QuickAnimationEaseInBounce,
    QuickAnimationEaseOutBounce,
    QuickAnimationEaseInOutBounce,
    QuickAnimationEaseFlash,
    QuickAnimationEaseInFlash,
    QuickAnimationEaseOutFlash,
    QuickAnimationEaseInOutFlash,
    
} QuickAnimationEaseType;

#endif
