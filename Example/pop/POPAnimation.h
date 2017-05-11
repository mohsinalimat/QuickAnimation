/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/NSObject.h>

#import <pop/POPAnimationTracer.h>
#import <pop/POPGeometry.h>

@class CAMediaTimingFunction;

/**
 @概述：动画类的抽象基类
 @描述：实例化其中一个具体的子类
 */
@interface POPAnimation : NSObject

/**
 @概述：动画的名称
 @描述：可选的属性，用来标识动画
 */
@property (copy, nonatomic) NSString *name;

/**
 @概述：动画的开始时间
 @描述：默认是从0开始，并且直接开始。
 */
@property (assign, nonatomic) CFTimeInterval beginTime;

/**
 @概述：动画代理
 实现了POPAnimationDelegate中的方法
 */
@property (weak, nonatomic) id delegate;

/**
 @描述 动画追踪
 返回一个动画追踪对象，如果没有就创建一个，使用start/stop方法来开启或关闭动画事件的收集
 */
@property (readonly, nonatomic) POPAnimationTracer *tracer;

/**
 @描述 动画开始时候调用的开始动画
 */
@property (copy, nonatomic) void (^animationDidStartBlock)(POPAnimation *anim);

/**
 @描述 当动画中的属性值到达或者超过的时候的调用
 */
@property (copy, nonatomic) void (^animationDidReachToValueBlock)(POPAnimation *anim);

/**
 当动画完成的时候调用
 */
@property (copy, nonatomic) void (^completionBlock)(POPAnimation *anim, BOOL finished);

/**
 每一帧动画被应用的时候调用
 */
@property (copy, nonatomic) void (^animationDidApplyBlock)(POPAnimation *anim);

/**
 动画播放完成后是否删除动画，默认删除，如果不删除，可以复用。
 */
@property (assign, nonatomic) BOOL removedOnCompletion;

/**
 动画是否处于暂停状态的标示。
 一个被暂停的动画师不在活动动画的列表之中。动画初始化的时候，默认是暂停的，当动画被添加后，处于非暂停状态。直到动画播放完毕，属性会被设置为NO
 */
@property (assign, nonatomic, getter = isPaused) BOOL paused;

/**
 动画是否需要自动反转
 动画将在播放完毕后，倒叙播放
 代理函数的调用顺序：
 1.animationDidStart:动画开始播放的时候调用（包括倒叙播放开始的时候）
 2.animationDidReachToValue:当设置为yes的时候，该函数至少调用2次，每次值达到toValue或者超过的时候都会调用，正序动画播放完后，原先的fromValue和toValue将调换。
 3.animationDidStop:finished:达到toValue的时候会被调用，但是如果reverse设置为yes,finished参数将传no,直到整个翻转动画播放完毕了，才会传yes.
 */
@property (assign, nonatomic) BOOL autoreverses;

/**
 动画重复次数
 0或者1表示不会重复，
 其他正数表示重复几次

 1.animationDidStop:finished:只有完成的时候，finish参数才会被设置为yes
 
 可以和reverse属性联合使用，一次动画包括一个来回。
 */
@property (assign, nonatomic) NSInteger repeatCount;

/**
 无限循环播放
 */
@property (assign, nonatomic) BOOL repeatForever;

@end

/**
 动画代理方法
 */
@protocol POPAnimationDelegate <NSObject>
@optional

/**
动画开始的时候播放
 */
- (void)pop_animationDidStart:(POPAnimation *)anim;

/**
 动画的属性值达到toValue或者超过toValue的时候调用
 */
- (void)pop_animationDidReachToValue:(POPAnimation *)anim;

/**
动画属性值到达toValue的时候播放，finished表示整个动画是否完成
 */
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished;

/**
动画每帧被应用的时候调用
 */
- (void)pop_animationDidApply:(POPAnimation *)anim;

@end


@interface NSObject (POP)

/**
加入动画，key为动画的唯一识别标示
 */
- (void)pop_addAnimation:(POPAnimation *)anim forKey:(NSString *)key;

/**
 移除所有的动画
 */
- (void)pop_removeAllAnimations;

/**
根据key值删除对应的动画
 */
- (void)pop_removeAnimationForKey:(NSString *)key;

/**
取出所有的动画标示keys
 */
- (NSArray *)pop_animationKeys;

/**
根据key取出对应的动画
 */
- (id)pop_animationForKey:(NSString *)key;

@end

/**
 copying 只复制设置，不复制动画状态。
 *  This implementation of NSCopying does not do any copying of animation's state, but only configuration.
 *  i.e. you cannot copy an animation and expect to apply it to a view and have the copied animation pick up where the original left off.
 *  Two common uses of copying animations:
 *  * you need to apply the same animation to multiple different views.
 *  * you need to absolutely ensure that the the caller of your function cannot mutate the animation once it's been passed in.
 */
@interface POPAnimation (NSCopying) <NSCopying>

@end
