//
//  QuickAnimationSequeue.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimation.h"

@interface QuickAnimationSequeue : NSObject<QuickAnimation>


- (instancetype)init;
- (void)appendAnimation:(id<QuickAnimation>)animation;
- (void)appendCallback:(QuickAnimationCallBack)callback;
- (void)appendInterval:(CGFloat)interval;
- (void)insertAnimation:(id<QuickAnimation>)animation atIndex:(NSUInteger)index;
- (void)insertCallback:(QuickAnimationCallBack)callback atIndex:(NSUInteger)index;
- (void)insertInterval:(CGFloat)interval atIndex:(NSUInteger)index;
- (void)joinAnimation:(id<QuickAnimation>)animation;


@end
