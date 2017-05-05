//
//  QuickAnimationTween.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimationTween.h"
#import "QuickAnimationEaseManager.h"

@interface QuickAnimationTween()<POPAnimationDelegate>
{
    __strong id _holdSelf;
    QuickAnimationEaseType _easeType;
    QuickAnimationLoopType _loopType;
    CFTimeInterval _currentTime;
    BOOL _isReverse;
    BOOL _startFlag;
    
}
@property (strong,nonatomic) QuickAnimationValueProgress valueProgressBlock;
@property (strong,nonatomic) POPCustomAnimation* animation;

@end

@implementation QuickAnimationTween

@synthesize
loops = _loops,
name = _name,
duration = _duration,
delayTime = _delayTime,
resumeCallBack = _resumeCallBack,
startCallBack = _startCallBack,
pauseCallBack = _pauseCallBack,
stopCallBack = _stopCallBack,
completeCallBack = _completeCallBack,
completeWhenInQueue = _completeWhenInQueue,
playCallBack = _playCallBack;

- (instancetype)init{
    return nil;
}

- (instancetype)initWithAnimationBlock:(QuickAnimationValueProgress) valueProgressBlock{
    
    if (self = [super init]){
        
        _valueProgressBlock = valueProgressBlock;
        __weak QuickAnimationTween* weakSelf = self;
        _animation = [POPCustomAnimation animationWithBlock:^BOOL(id target, POPCustomAnimation *animation) {
            __strong QuickAnimationTween* strongSelf = weakSelf;
            return [strongSelf _customAction:target animation:animation];
        }];
        _animation.delegate = self;
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    _animation.name = [NSUUID UUID].UUIDString;
    _name = _animation.name;
    _currentTime = 0;
    _isReverse = NO;
    self.easeType = QuickAnimationEaseLinear;
    self.loopType = QuickAnimationLoopRestart;
    self.loops = 1;
    self.duration = 0.0f;
    self.removedOnCompletion = YES;
    self.isFrom = NO;
    
}

- (BOOL)_customAction:(id)target animation:(POPCustomAnimation*)animation{
    _currentTime += animation.elapsedTime;
    CGFloat t = _currentTime;
    CGFloat d = _duration;
    BOOL ret = t < d;
    if (_isReverse){
        t = d - t;
        t = t > 0 ? t : 0;
    }
    
    if (_valueProgressBlock){
        CGFloat valueProgress = [QuickAnimationEaseManager evalute:self.easeType time:t duration:d];
        if (valueProgress < 0) {
            valueProgress = 0;
        }else if (valueProgress > 1){
            valueProgress = 1;
        }
        _valueProgressBlock(_currentTime,d,_isFrom ? 1 - valueProgress : valueProgress);
    }
    return ret;
}

- (void)reset{
    _startFlag = NO;
    _currentTime = 0;
    [self setLoops:_loops];
}
#pragma mark - animation control

- (void)startAnimation{
    _holdSelf = self;
    [self reset];
    [[POPAnimator sharedAnimator] pop_addAnimation:_animation forKey:_animation.name];
}
- (void)stopAnimation{
    
    if (_stopCallBack){
        _stopCallBack(self);
    }
    [self reset];
    [[POPAnimator sharedAnimator] pop_removeAnimationForKey:_animation.name];
    _holdSelf = nil;
}

- (void)resumeAnimation{
    if (_animation.isPaused){
        if (_resumeCallBack){
            _resumeCallBack(self);
        }
        _animation.paused = NO;
    }
}
- (void)pauseAnimation{
    if (!_animation.isPaused){
        if (_pauseCallBack){
            _pauseCallBack(self);
        }
        _animation.paused = YES;
    }
}

#pragma mark - getter setter

- (NSString *)udidName{
    return _animation.name;
}

- (void)setLoops:(NSInteger)loops{
    _loops = loops;
    if (loops == -1){
        _animation.repeatForever = YES;
    }else{
        _animation.repeatForever = NO;
        _animation.repeatCount = (_loopType == QuickAnimationLoopYoyo) ? loops*2 : loops;
    }
}

- (void)setDelayTime:(CGFloat)delayTime{
    _delayTime = delayTime;
    _animation.beginTime = CACurrentMediaTime() + delayTime;
}


- (BOOL)removedOnCompletion{
    return _animation.removedOnCompletion;
}

- (void)setRemovedOnCompletion:(BOOL)removedOnCompletion{
    _animation.removedOnCompletion = removedOnCompletion;
}

- (void)setLoopType:(QuickAnimationLoopType)loopType{
    _loopType = loopType;
    self.loops = self.loops;
}

- (QuickAnimationLoopType)loopType{
    return _animation.autoreverses ? QuickAnimationLoopYoyo : QuickAnimationLoopRestart;
}

- (BOOL)isPause{
    return _animation.isPaused;
}


-(BOOL)isEqual:(id)object{
    if ([object respondsToSelector:@selector(name)]){
        return [self.udidName isEqualToString:[object udidName]];
    }
    return NO;
}
- (void)dealloc{
    
    if (_animation){
        [[POPAnimator sharedAnimator] pop_removeAnimationForKey:_animation.name];
        _animation = nil;
    }
}

#pragma mark - animation delegate
/**
 @abstract Called on animation start.
 @param anim The relevant animation.
 */
- (void)pop_animationDidStart:(POPAnimation *)anim{
    if (!_startFlag){
        if (_startCallBack){
            _startCallBack(self);
        }
        _startFlag = YES;
    }
}

- (void)pop_animationDidReachToValue:(POPAnimation *)anim{
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    
    if (_loopType == QuickAnimationLoopYoyo && _currentTime >= _duration){
        _isReverse = !_isReverse;
    }
    if (_currentTime >= _duration){
        //not pause
        _currentTime = 0;
    }
    
    if (finished){
        
        if (_completeCallBack){
            _completeCallBack(self);
        }
        if (_completeWhenInQueue){
            _completeWhenInQueue(self);
        }
        [self reset];
        _holdSelf = nil;
    }
}



@end
