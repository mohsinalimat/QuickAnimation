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


#pragma mark -animation control

- (void)startAnimation;
- (void)stopAnimation;
- (void)resumeAnimation;
- (void)pauseAnimation;

#pragma mark - animation event
@property (assign,nonatomic) CGFloat delayTime;

@property (readonly,nonatomic) BOOL isPause;

@property (assign,nonatomic) NSInteger loops;

@property (copy,nonatomic) NSString* name;

@property (readonly,nonatomic) NSString* udidName;

@property (assign,nonatomic) CGFloat duration;


/**
 动画完成时候调用
 */
@property (strong,nonatomic) QuickAnimationCallBack completeCallBack;

@property (strong,nonatomic) QuickAnimationCallBack completeWhenInQueue;

/**
 动画开始时候调用
 */
@property (strong,nonatomic) QuickAnimationCallBack startCallBack;

/**
 动画取消暂停的时候调用
 */
@property (strong,nonatomic) QuickAnimationCallBack resumeCallBack;

/**
 停止动画的时候调用
 */
@property (strong,nonatomic) QuickAnimationCallBack stopCallBack;

/**
 播放动画的时候调用
 */
@property (strong,nonatomic) QuickAnimationCallBack playCallBack;

/**
 暂停动画的时候调用
 */
@property (strong,nonatomic) QuickAnimationCallBack pauseCallBack;


@end

@interface QuickAnimationManager:NSObject

+(instancetype)sharedManager;
-(void)addAnimation:(id<QuickAnimation>)anim;
-(void)removeAnimation:(id<QuickAnimation>)anim;

@end
