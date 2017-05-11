/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

#import <pop/POPAnimationEvent.h>

@class POPAnimation;

/**
 @概述： 动画事件的追踪类，用来帮助测试
 */
@interface POPAnimationTracer : NSObject

/**
 @描述： 开始记录事件
 */
- (void)start;

/**
 @描述： 停止记录事件
 */
- (void)stop;

/**
 @描述 重制记录事件. 如果已经是启动状态，则将继续运行.
 */
- (void)reset;

/**
 @abstract Property representing all recorded events.
 @discussion Events are returned in order of occurrence.
 */
@property (nonatomic, assign, readonly) NSArray *allEvents;

/**
 @abstract Property representing all recorded write events for convenience.
 @discussion Events are returned in order of occurrence.
 */
@property (nonatomic, assign, readonly) NSArray *writeEvents;

/**
 @abstract Queries for events of specified type.
 @param type The type of event to return.
 @returns An array of events of specified type in order of occurrence.
 */
- (NSArray *)eventsWithType:(POPAnimationEventType)type;

/**
 @abstract Property indicating whether tracer should automatically log events and reset collection on animation completion.
 */
@property (nonatomic, assign) BOOL shouldLogAndResetOnCompletion;

@end
