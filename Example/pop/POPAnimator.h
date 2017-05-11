/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

@protocol POPAnimatorDelegate;

/**
 动画播放管理类，负责渲染动画
 */
@interface POPAnimator : NSObject

/**
单例
 */
+ (instancetype)sharedAnimator;

#if !TARGET_OS_IPHONE
/**
 @abstract Allows to select display to bind. Returns nil if failed to create the display link.
 */
- (instancetype)initWithDisplayID:(CGDirectDisplayID)displayID;
#endif

/**
 @abstract The optional animator delegate.
 */
@property (weak, nonatomic) id<POPAnimatorDelegate> delegate;

/**
 返回display link 的刷新频率，如果不可用则返回0
 */
@property (readonly, nonatomic) CFTimeInterval refreshPeriod;

@end

/**
 @abstract The animator delegate.
 */
@protocol POPAnimatorDelegate <NSObject>

/**
 @abstract Called on each frame before animation application.
 */
- (void)animatorWillAnimate:(POPAnimator *)animator;

/**
 @abstract Called on each frame after animation application.
 */
- (void)animatorDidAnimate:(POPAnimator *)animator;

@end
