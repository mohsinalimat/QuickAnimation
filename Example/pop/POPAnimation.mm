/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import "POPAnimationExtras.h"
#import "POPAnimationInternal.h"

#import <objc/runtime.h>

#import "POPAction.h"
#import "POPAnimationRuntime.h"
#import "POPAnimationTracerInternal.h"
#import "POPAnimatorPrivate.h"

using namespace POP;

#pragma mark - POPAnimation

@implementation POPAnimation
@synthesize solver = _solver;
@synthesize currentValue = _currentValue;
@synthesize progressMarkers = _progressMarkers;

#pragma mark - Lifecycle

//只允许子类实例化
- (id)init
{
  
  [NSException raise:NSStringFromClass([self class]) format:@"Attempting to instantiate an abstract class. Use a concrete subclass instead."];
  return nil;
}

//初始化方法
- (id)_init
{
  self = [super init];
  if (nil != self) {
    [self _initState];
  }
  return self;
}

//初始化状态，POPAnimationState是实用c++ 实现的结构体
- (void)_initState
{
  _state = new POPAnimationState(self);
}

- (void)dealloc
{
  if (_state) {
    //释放c++的内存，清空野指针
    delete _state;
    _state = NULL;
  };
}

//真正的属性与状态是存在结构体中的，详见POPAnimationInternal.h
#pragma mark - Properties

- (id)delegate
{
  return _state->delegate;
}

- (void)setDelegate:(id)delegate
{
  _state->setDelegate(delegate);
}

- (BOOL)isPaused
{
  return _state->paused;
}

- (void)setPaused:(BOOL)paused
{
  _state->setPaused(paused ? true : false);
}

//如果是可以反转的动画，那么整体重复次数，是实际播放次数的一半
- (NSInteger)repeatCount
{
  if (_state->autoreverses) {
    return _state->repeatCount / 2;
  } else {
    return _state->repeatCount;
  }
}

//如果是翻转动画，那么实际动画播放次数应该乘以2，因为来回算一次。
- (void)setRepeatCount:(NSInteger)repeatCount
{
  //边界判断，不允许溢出。
  if (repeatCount > 0) {
    if (repeatCount > NSIntegerMax / 2) {
      repeatCount = NSIntegerMax / 2;
    }

    if (_state->autoreverses) {
      _state->repeatCount = (repeatCount * 2);
    } else {
      _state->repeatCount = repeatCount;
    }
  }
}

- (BOOL)autoreverses
{
  return _state->autoreverses;
}

- (void)setAutoreverses:(BOOL)autoreverses
{
  _state->autoreverses = autoreverses;
  if (autoreverses) {
    if (_state->repeatCount == 0) {
      [self setRepeatCount:1];
    }
  }
}
//属性的获取，以及设置的便捷宏

FB_PROPERTY_GET(POPAnimationState, type, POPAnimationType);
DEFINE_RW_PROPERTY_OBJ_COPY(POPAnimationState, animationDidStartBlock, setAnimationDidStartBlock:, POPAnimationDidStartBlock);
DEFINE_RW_PROPERTY_OBJ_COPY(POPAnimationState, animationDidReachToValueBlock, setAnimationDidReachToValueBlock:, POPAnimationDidReachToValueBlock);
DEFINE_RW_PROPERTY_OBJ_COPY(POPAnimationState, completionBlock, setCompletionBlock:, POPAnimationCompletionBlock);
DEFINE_RW_PROPERTY_OBJ_COPY(POPAnimationState, animationDidApplyBlock, setAnimationDidApplyBlock:, POPAnimationDidApplyBlock);
DEFINE_RW_PROPERTY_OBJ_COPY(POPAnimationState, name, setName:, NSString*);
DEFINE_RW_PROPERTY(POPAnimationState, beginTime, setBeginTime:, CFTimeInterval);
DEFINE_RW_FLAG(POPAnimationState, removedOnCompletion, removedOnCompletion, setRemovedOnCompletion:);
DEFINE_RW_FLAG(POPAnimationState, repeatForever, repeatForever, setRepeatForever:);


//如果kvc无法取出这个key的属性，则转交给_state的dict处理
- (id)valueForUndefinedKey:(NSString *)key
{
  return _state->dict[key];
}

//如果通过kvc无法设置这个属性，则调用这个方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //value为空，则删除字典中对应的值
  if (!value) {
    [_state->dict removeObjectForKey:key];
  } else {
      //否则判断_state的字典是否为空，空就创建一个
    if (!_state->dict)
      _state->dict = [[NSMutableDictionary alloc] init];
    _state->dict[key] = value;
  }
}

//如果需要使用trace跟踪，会在第一次调用的时候，创建一个
- (POPAnimationTracer *)tracer
{
  if (!_state->tracer) {
    _state->tracer = [[POPAnimationTracer alloc] initWithAnimation:self];
  }
  return _state->tracer;
}

- (NSString *)description
{
  NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
  [self _appendDescription:s debug:NO];
  [s appendString:@">"];
  return s;
}

- (NSString *)debugDescription
{
  NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
  [self _appendDescription:s debug:YES];
  [s appendString:@">"];
  return s;
}

#pragma mark - Utility

POPAnimationState *POPAnimationGetState(POPAnimation *a)
{
  return a->_state;
}

- (BOOL)_advance:(id)object currentTime:(CFTimeInterval)currentTime elapsedTime:(CFTimeInterval)elapsedTime
{
  return YES;
}

- (void)_appendDescription:(NSMutableString *)s debug:(BOOL)debug
{
  if (_state->name)
    [s appendFormat:@"; name = %@", _state->name];
  
  if (!self.removedOnCompletion)
    [s appendFormat:@"; removedOnCompletion = %@", POPStringFromBOOL(self.removedOnCompletion)];
  
  if (debug) {
    if (_state->active)
      [s appendFormat:@"; active = %@", POPStringFromBOOL(_state->active)];
    
    if (_state->paused)
      [s appendFormat:@"; paused = %@", POPStringFromBOOL(_state->paused)];
  }
  
  if (_state->beginTime) {
    [s appendFormat:@"; beginTime = %f", _state->beginTime];
  }
  
  for (NSString *key in _state->dict) {
    [s appendFormat:@"; %@ = %@", key, _state->dict[key]];
  }
}

@end


#pragma mark - POPPropertyAnimation

#pragma mark - POPBasicAnimation

#pragma mark - POPDecayAnimation

//统一在POPAnimator这个播放器的单例中管理动画的增加与删除
@implementation NSObject (POP)

- (void)pop_addAnimation:(POPAnimation *)anim forKey:(NSString *)key
{
  [[POPAnimator sharedAnimator] addAnimation:anim forObject:self key:key];
}

- (void)pop_removeAllAnimations
{
  [[POPAnimator sharedAnimator] removeAllAnimationsForObject:self];
}

- (void)pop_removeAnimationForKey:(NSString *)key
{
  [[POPAnimator sharedAnimator] removeAnimationForObject:self key:key];
}

- (NSArray *)pop_animationKeys
{
  return [[POPAnimator sharedAnimator] animationKeysForObject:self];
}

- (id)pop_animationForKey:(NSString *)key
{
  return [[POPAnimator sharedAnimator] animationForObject:self key:key];
}

@end

@implementation NSProxy (POP)

- (void)pop_addAnimation:(POPAnimation *)anim forKey:(NSString *)key
{
  [[POPAnimator sharedAnimator] addAnimation:anim forObject:self key:key];
}

- (void)pop_removeAllAnimations
{
  [[POPAnimator sharedAnimator] removeAllAnimationsForObject:self];
}

- (void)pop_removeAnimationForKey:(NSString *)key
{
  [[POPAnimator sharedAnimator] removeAnimationForObject:self key:key];
}

- (NSArray *)pop_animationKeys
{
  return [[POPAnimator sharedAnimator] animationKeysForObject:self];
}

- (id)pop_animationForKey:(NSString *)key
{
  return [[POPAnimator sharedAnimator] animationForObject:self key:key];
}

@end

@implementation POPAnimation (NSCopying)

- (instancetype)copyWithZone:(NSZone *)zone
{
  /*
   * Must use [self class] instead of POPAnimation so that subclasses can call this via super.
   * Even though POPAnimation and POPPropertyAnimation throw exceptions on init,
   * it's safe to call it since you can only copy objects that have been successfully created.
   */
  POPAnimation *copy = [[[self class] allocWithZone:zone] init];
  
  if (copy) {
    copy.name = self.name;
    copy.beginTime = self.beginTime;
    copy.delegate = self.delegate;
    copy.animationDidStartBlock = self.animationDidStartBlock;
    copy.animationDidReachToValueBlock = self.animationDidReachToValueBlock;
    copy.completionBlock = self.completionBlock;
    copy.animationDidApplyBlock = self.animationDidApplyBlock;
    copy.removedOnCompletion = self.removedOnCompletion;
    
    copy.autoreverses = self.autoreverses;
    copy.repeatCount = self.repeatCount;
    copy.repeatForever = self.repeatForever;
  }
    
  return copy;
}

@end
