//
//  QuickAnimationBezierUtil.h
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 Calculated interpolation of curve
 */
@interface QuickAnimationBezierUtil : NSObject

-(instancetype)initWithBezierPath:(UIBezierPath*)path;

/**
 Gets the point value of the curve at valueProgress persent

 @param valueProgress persent
 @return (x,y)
 */
- (CGPoint)pointAt:(CGFloat)valueProgress;



/**
 Create bezier path from attribute string

 @param string The attribute string used to generate the path
 @param size the max size
 @return UIBezierPath
 */
+ (UIBezierPath*)createBezierPathFrom:(NSAttributedString *)string size:(CGSize)size;

@end
