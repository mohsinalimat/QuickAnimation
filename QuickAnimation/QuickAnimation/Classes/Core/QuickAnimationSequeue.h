//
//  QuickAnimationSequeue.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimation.h"


/**
 To create an animation queue, the animation in the queue will play in order
 */
@interface QuickAnimationSequeue : NSObject<QuickAnimation>

/**
 Instantiation method
 */
- (instancetype)init;

/**
 Add an animation to the queue
 */
- (void)appendAnimation:(id<QuickAnimation>)animation;

/**
 Add a callback
 */
- (void)appendCallback:(QuickAnimationQueueCallBack)callback;

/**
 Add time interval
 */
- (void)appendInterval:(CGFloat)interval;

/**
 
 Add an animation at the specified location in the queue

 @param animation animation
 @param index The location of the animation
 */
- (void)insertAnimation:(id<QuickAnimation>)animation atIndex:(NSUInteger)index;

/**
 Add an callback at the specified location in the queue

 @param callback callback
 @param index The location of the callback
 */
- (void)insertCallback:(QuickAnimationQueueCallBack)callback atIndex:(NSUInteger)index;

/**
 Add time interval at the specified location in the queue

 @param interval time interval
 @param index The location of the time interval
 */
- (void)insertInterval:(CGFloat)interval atIndex:(NSUInteger)index;

/**
 The added animation will be played at the same time as the last animation in the queue

 @param animation the added animtation
 */
- (void)joinAnimation:(id<QuickAnimation>)animation;


@end
