//
//  QAEase.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#ifndef QAEnum_h
#define QAEnum_h

/**
 Animation cycle mode
 */
typedef enum : NSUInteger {
    
    /**
     *  After each round of animation is finished, it will start from scratch and re-play the animation
     */
    QuickAnimationLoopRestart,
    /**
     *  After the animation is finished, it will play in reverse order
     */
    QuickAnimationLoopYoyo,
    
} QuickAnimationLoopType;


/**
 Easing function type
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
