//
//  NSValue+Interpolation.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSValue (Interpolation)

+ (CGPoint)pointWithFrom:(CGPoint)fromValue to:(CGPoint)toValue progress:(CGFloat)progress;
+ (CGFloat)floatWithFrom:(CGFloat)fromValue to:(CGFloat)toValue progress:(CGFloat)progress;
+ (NSInteger)integerWithFrom:(NSInteger)fromValue to:(NSInteger)toValue progress:(CGFloat)progress;
+ (UIColor*)colorWithFrom:(UIColor*)fromValue to:(UIColor*)toValue progress:(CGFloat)progress;


@end
