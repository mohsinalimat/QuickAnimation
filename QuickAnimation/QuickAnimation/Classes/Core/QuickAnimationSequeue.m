//
//  QuickAnimationSequeue.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimationSequeue.h"
#import "QuickAnimationTween.h"

@interface QuickAnimationSequeue()
{
    NSString* _udidName;
    NSMutableArray<id<QuickAnimation>>* _animationArray;
    NSMutableArray<id<QuickAnimation>>* _playingAniamtions;
    NSMutableDictionary* _joinAnimation;
    id<QuickAnimation> _delayAnimation;
    BOOL _isPause;
}
@end

@implementation QuickAnimationSequeue

@synthesize
name = _name,
duration = _duration,
loops = _loops,
delayTime = _delayTime,
resumeCallBack = _resumeCallBack,
startCallBack = _startCallBack,
pauseCallBack = _pauseCallBack,
stopCallBack = _stopCallBack,
completeCallBack = _completeCallBack,
completeWhenInQueue = _completeWhenInQueue,
playCallBack = _playCallBack;


- (instancetype)init{
    if (self = [super init]){
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    _name = [NSUUID UUID].UUIDString;
    _udidName = [_name copy];
    _loops = 1;
    _animationArray = [NSMutableArray array];
    _playingAniamtions = [NSMutableArray array];
    _joinAnimation = [NSMutableDictionary dictionary];
    _isPause = NO;
    _delayAnimation = [self createIntervalTween:_delayTime];
    __weak typeof(self) weakSelf  = self;
    _delayAnimation.completeCallBack = ^(id<QuickAnimation> anim) {
        if (weakSelf.startCallBack){
            weakSelf.startCallBack(weakSelf);
        }
        [weakSelf nextAnimation:anim];
    };
    _delayAnimation.duration = 0.0f;
    
}

- (void)appendAnimation:(id<QuickAnimation>)animation{
    
    __weak typeof(self) weakSelf = self;
    animation.completeWhenInQueue = ^(id<QuickAnimation> anim) {
        [weakSelf nextAnimation:anim];
    };
    [_animationArray addObject:animation];
}

- (void)appendCallback:(QuickAnimationCallBack)callback{
    
    [self appendAnimation:[self createCallbackTween:callback] ];
}

- (void)appendInterval:(CGFloat)interval{
    
    [self appendAnimation:[self createIntervalTween:interval] ];
}

- (void)insertAnimation:(id<QuickAnimation>)animation atIndex:(NSUInteger)index{
    
    __weak typeof(self) weakSelf = self;
    animation.completeWhenInQueue = ^(id<QuickAnimation> anim) {
        [weakSelf nextAnimation:anim];
    };
    [_animationArray insertObject:animation atIndex:index];
}

- (void)insertCallback:(QuickAnimationCallBack)callback atIndex:(NSUInteger)index{
    
    [self insertAnimation:[self createCallbackTween:callback] atIndex:index];
}

- (void)insertInterval:(CGFloat)interval atIndex:(NSUInteger)index{
    [self insertAnimation:[self createIntervalTween:interval] atIndex:index];
}

- (void)joinAnimation:(id<QuickAnimation>)animation{
    
    id<QuickAnimation> lastAnim = _delayAnimation;
    if (_animationArray.count != 0){
        lastAnim = _animationArray.lastObject;
    }
    NSMutableArray* arr = _joinAnimation[lastAnim.udidName];
    if (![arr isKindOfClass:[NSMutableArray class]]){
        arr = [NSMutableArray array];
        _joinAnimation[lastAnim.udidName] = arr;
    }
    __weak typeof(self) weakSelf = self;
    animation.completeWhenInQueue = ^(id<QuickAnimation> anim) {
        [weakSelf nextAnimation:anim];
    };
    [arr addObject:animation];
}

- (id<QuickAnimation>)createCallbackTween:(QuickAnimationCallBack)callback{
    
    QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:nil];
    tween.completeCallBack = callback;
    return tween;
}

- (id<QuickAnimation>)createIntervalTween:(CGFloat)interval{
    
    QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:nil];
    tween.delayTime = interval;
    
    return tween;
}

- (void)nextAnimation:(id<QuickAnimation>)lastAnim{
    
    if (lastAnim == nil && _animationArray.count > 0){
        
        for (id<QuickAnimation> anim in _playingAniamtions) {
            [anim stopAnimation];
        }
        [_playingAniamtions removeAllObjects];
        _delayAnimation.delayTime = _delayTime;
        [self animationWillStart:_delayAnimation];
        [_delayAnimation startAnimation];
        
        return;
    }
    
    [self animationDidComplete:lastAnim];
    if (lastAnim == _delayAnimation){
        
        [self animationWillStart:_animationArray[0]];
        [_animationArray[0] startAnimation];
        return;
    }
    NSUInteger index = [_animationArray indexOfObject:lastAnim];
    
    if (index != NSNotFound){
        index ++;
        if (index < _animationArray.count){
            id<QuickAnimation> nextAnim = _animationArray[index];
            [self animationWillStart:nextAnim];
            [nextAnim startAnimation];
        }
    }
    if (_playingAniamtions.count == 0){
        //动画结束
        if (_loops>0)
            _loops -- ;
        if (_loops==0){
           
            if (_completeCallBack){
                _completeCallBack(self);
            }
            if (_completeWhenInQueue){
                _completeWhenInQueue(self);
            }
            [[QuickAnimationManager sharedManager] removeAnimation:self];
        }else {
            [self nextAnimation:nil];
        }
        
    }
}

-(void)dealloc{
    for (id<QuickAnimation> anim in _playingAniamtions) {
        [anim stopAnimation];
    }

}
#pragma mark - animation control

- (void)startAnimation{
    [[QuickAnimationManager sharedManager] addAnimation:self];
    [self nextAnimation:nil];
}

- (void)stopAnimation{
   
    for (id<QuickAnimation> anim in _playingAniamtions) {
        [anim stopAnimation];
    }
    
    if (_stopCallBack){
        _stopCallBack(self);
    }
    
    [[QuickAnimationManager sharedManager] removeAnimation:self];
    
}

- (void)resumeAnimation{
    
    _isPause = NO;
    for (id<QuickAnimation> anim in _playingAniamtions) {
        [anim resumeAnimation];
    }
    
    if (_resumeCallBack){
        _resumeCallBack(self);
    }
}
- (void)pauseAnimation{
    
    _isPause = YES;
    for (id<QuickAnimation> anim in _playingAniamtions) {
        [anim pauseAnimation];
    }
    
    if (_pauseCallBack){
        _pauseCallBack(self);
    }
}


#pragma mark - internal

- (void)animationWillStart:(id<QuickAnimation>)anim{
    [_playingAniamtions addObject:anim];
    //check join
    NSArray* arr = _joinAnimation[anim.udidName];
    if (arr.count > 0){
        for (id<QuickAnimation> tmp in arr) {
            [_playingAniamtions addObject:tmp];
            [tmp startAnimation];
        }
    }
}

- (void)animationDidComplete:(id<QuickAnimation>)anim{
    [_playingAniamtions removeObject:anim];
}

#pragma mark - property

- (NSString *)udidName{
    return _udidName;
}

- (void)setDelayTime:(CGFloat)delayTime{
    _delayTime = delayTime;
    
}

- (BOOL)isPause{
    return _isPause;
}



@end



