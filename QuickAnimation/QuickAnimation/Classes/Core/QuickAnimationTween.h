//
//  QuickAnimationTween.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimation.h"

@interface QuickAnimationTween : NSObject <QuickAnimation>


@property (assign,nonatomic) BOOL removedOnCompletion;

@property (assign,nonatomic) QuickAnimationLoopType loopType;

@property (assign,nonatomic) QuickAnimationEaseType easeType;

@property (assign,nonatomic) BOOL isFrom;


#pragma mark - Method
-(instancetype)initWithAnimationBlock:(QuickAnimationValueProgress) valueProgressBlock;


@end
