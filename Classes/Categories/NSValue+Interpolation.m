//
//  NSValue+Interpolation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "NSValue+Interpolation.h"

@implementation NSValue (Interpolation)

+ (CGPoint)pointWithFrom:(CGPoint)fromValue to:(CGPoint)toValue progress:(CGFloat)progress{
    return CGPointMake(
                       (toValue.x-fromValue.x)*progress + fromValue.x,
                       (toValue.y-fromValue.y)*progress + fromValue.y
                       );
}

+ (CGFloat)floatWithFrom:(CGFloat)fromValue to:(CGFloat)toValue progress:(CGFloat)progress{
    return (toValue - fromValue) * progress + fromValue;
}

+ (NSInteger)integerWithFrom:(NSInteger)fromValue to:(NSInteger)toValue progress:(CGFloat)progress{
    return  (NSInteger)ceil((toValue - fromValue) * progress) + fromValue;
}

+ (UIColor*)colorWithFrom:(UIColor*)fromValue to:(UIColor*)toValue progress:(CGFloat)progress{
    if (fromValue == nil && toValue == nil){
        return nil;
    }
  
    CGFloat oA = 0,oR = 0,oG =0,oB =0,nA = 0,nR = 0,nG = 0,nB = 0;
    [fromValue getRed:&oR green:&oG blue:&oB alpha:&oA];
    [toValue getRed:&nR green:&nG blue:&nB alpha:&nA];
    
    return [UIColor colorWithRed:(nR-oR)*progress + oR
                           green:(nG-oG)*progress + oG
                            blue:(nB-oB)*progress + oB
                           alpha:(nA-oA)*progress + oA];
}


@end
