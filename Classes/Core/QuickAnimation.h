//
//  QuickAnimation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickAnimationBlock.h"
#import <POP.h>



@protocol QuickAnimation <NSObject>

/**
 *  Delay playing time
 */
@property (assign,nonatomic) CGFloat delayTime;

/**
 Whether the animation is paused
 */
@property (readonly,nonatomic) BOOL isPause;

/**
 Animated loop frequency
 */
@property (assign,nonatomic) NSInteger loops;

/**
 The name of the animation
 */
@property (copy,nonatomic) NSString* name;

/**
 The id of the animation
 */
@property (readonly,nonatomic) NSString* udidName;

/**
 The duration of the animation
 */
@property (assign,nonatomic) CGFloat duration;


#pragma mark - Quickly set properties

/**
 Quickly set the number of cycles and the loop mode
 */
@property (readonly,nonatomic) SetLoopBlock SetLoops;

/**
 Quickly set the delay time
 */
@property (readonly,nonatomic) SetDelayBlock SetDelay;

/**
 Quickly set easing function mode
 */
@property (readonly,nonatomic) SetEaseBlock SetEase;

/**
 Quickly set isFrom
 */
@property (readonly,nonatomic) FromBlock From;

/**
 Quickly call 'startAnimation' method
 */
@property (readonly,nonatomic) PlayAnimationBlock Play;

/**
 Quickly call 'stopAnimation' method
 */
@property (readonly,nonatomic) StopAnimationBlock Stop;

#pragma mark - animation control

- (void)startAnimation;
- (void)stopAnimation;
- (void)resumeAnimation;
- (void)pauseAnimation;


#pragma mark - animation event

/**
 When the animation is finished, call it
 */
@property (strong,nonatomic) QuickAnimationCallBack completeCallBack;

/**
 When the animation is finished, call it，not active use
 */
@property (strong,nonatomic) QuickAnimationCallBack completeWhenInQueue;

/**
 When the animation is started, call it
 */
@property (strong,nonatomic) QuickAnimationCallBack startCallBack;

/**
 When the animation is resumed, call it
 */
@property (strong,nonatomic) QuickAnimationCallBack resumeCallBack;

/**
 When the animation is stopped, call it
 */
@property (strong,nonatomic) QuickAnimationCallBack stopCallBack;

/**
 When the animation is paused, call it
 */
@property (strong,nonatomic) QuickAnimationCallBack pauseCallBack;

@end


/**
 Animation manager, in order to ensure that the animtion object is not released when animation playing
 */
@interface QuickAnimationManager:NSObject

+(instancetype)sharedManager;
-(void)addAnimation:(id<QuickAnimation>)anim;
-(void)removeAnimation:(id<QuickAnimation>)anim;

@end
