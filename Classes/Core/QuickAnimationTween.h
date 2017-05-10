//
//  QuickAnimationTween.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimation.h"
#import "QuickAnimationBlock.h"

@interface QuickAnimationTween : NSObject <QuickAnimation>

/**
 Animation cycle mode
 */
@property (assign,nonatomic) QuickAnimationLoopType loopType;

/**
 Easing function type
 */
@property (assign,nonatomic) QuickAnimationEaseType easeType;


/**
 Indicates that the animation will be played from toValue to fromValue.
 Default is NO
 */
@property (assign,nonatomic) BOOL isFrom;


#pragma mark - Method

/**
 During the animation playback process, will continue to call the progressBlock

 */
-(instancetype)initWithAnimationBlock:(QuickAnimationValueProgress) valueProgressBlock;


@end
