//
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimation.h"

@interface  QuickAnimationManager()

@property (strong,nonatomic) NSMutableArray* playingAnimation;

@end

@implementation QuickAnimationManager

+(instancetype)sharedManager{
    static QuickAnimationManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QuickAnimationManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]){
        _playingAnimation = [NSMutableArray array];
    }
    return self;
}

-(void)addAnimation:(id<QuickAnimation>)anim{
    [_playingAnimation addObject:anim];
}

-(void)removeAnimation:(id<QuickAnimation>)anim{
    [_playingAnimation removeObject:anim];
}

@end
