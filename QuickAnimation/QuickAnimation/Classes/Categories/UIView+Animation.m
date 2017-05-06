//
//  UIView+Animation.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "UIView+Animation.h"
#import "QuickAnimationTween.h"
#import "NSValue+Interpolation.h"
#import "QuickAnimationSequeue.h"

@implementation UIView (Animation)

#pragma mark - Move To

- (QuickPointBlock)MoveTo{
    
    return ^QuickAnimationTween* (CGPoint des,CGFloat duration){
        CGPoint fromValue = self.center;
        CGPoint toValue = des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGPoint movePoint = [NSValue pointWithFrom:fromValue to:toValue progress:valueProgress];
            self.center = CGPointMake(movePoint.x, movePoint.y);
        }];
        tween.duration = duration;
        return tween;
    };
    
}

- (QuickFloatBlock)MoveXTo{
    return ^QuickAnimationTween* (CGFloat des,CGFloat duration){
        CGFloat fromValue = self.center.x;
        CGFloat toValue = des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat movex = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.center = CGPointMake(movex, self.center.y);
        }];
        tween.duration = duration;
        return tween;
    };
}

- (QuickFloatBlock)MoveYTo{
    return ^QuickAnimationTween* (CGFloat des,CGFloat duration){
        CGFloat fromValue = self.center.y;
        CGFloat toValue = des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat movey = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.center = CGPointMake(self.center.x, movey);
        }];
        tween.duration = duration;
        return tween;
    };
}

#pragma mark - Move By

- (QuickPointBlock)MoveBy{
    
    return ^QuickAnimationTween* (CGPoint des,CGFloat duration){
        CGPoint fromValue = self.center;
        CGPoint toValue = CGPointMake(fromValue.x+des.x, fromValue.y+des.y);
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGPoint movePoint = [NSValue pointWithFrom:fromValue to:toValue progress:valueProgress];
            self.center = CGPointMake(movePoint.x, movePoint.y);
        }];
        tween.duration = duration;
        return tween;
    };
    
}

- (QuickFloatBlock)MoveXBy{
    return ^QuickAnimationTween* (CGFloat des,CGFloat duration){
        CGFloat fromValue = self.center.x;
        CGFloat toValue = fromValue + des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat movex = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.center = CGPointMake(movex, self.center.y);
        }];
        tween.duration = duration;
        return tween;
    };
}

- (QuickFloatBlock)MoveYBy{
    return ^QuickAnimationTween* (CGFloat des,CGFloat duration){
        CGFloat fromValue = self.center.y;
        CGFloat toValue = fromValue + des;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat movey = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.center = CGPointMake(self.center.x, movey);
        }];
        tween.duration = duration;
        return tween;
    };
}

#pragma mark - Alpha , Color

- (QuickFadeBlock)FadeTo{
    return ^QuickAnimationTween* (CGFloat alpha,CGFloat duration){
        CGFloat fromValue = self.alpha;
        CGFloat toValue =  alpha;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGFloat currentValue = [NSValue floatWithFrom:fromValue to:toValue progress:valueProgress];
            self.alpha = currentValue;
        }];
        tween.duration = duration;
        return tween;
    };
}

- (QuickColorBlock)ColorTo{
    return ^QuickAnimationTween* (UIColor* color,CGFloat duration){
        UIColor* fromValue = self.backgroundColor;
        UIColor* toValue =  color;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            UIColor* currentValue = [NSValue colorWithFrom:fromValue to:toValue progress:valueProgress];
            self.backgroundColor = currentValue;
        }];
        tween.duration = duration;
        return tween;
    };
}

#pragma mark - Scale To

- (QuickScaleBlock)ScaleTo{
    
    return ^QuickAnimationTween* (CGPoint scale,CGPoint anchorPoint,CGFloat duration){
        
        scale.x = MAX(0, scale.x);
        scale.y = MAX(0, scale.y);
        
        CGSize oldSize = self.frame.size;
//        CGPoint anchorPositon = CGPointMake(self.frame.origin.x, <#CGFloat y#>)
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            
            CGPoint oldOrginal = self.frame.origin;
            CGPoint currentValue = [NSValue pointWithFrom:CGPointMake(1, 1) to:scale progress:valueProgress];

            CGFloat currentWidth = oldSize.width * currentValue.x;
            CGFloat currentHeight = oldSize.height * currentValue.y;
            
            CGFloat currentX = oldOrginal.x + self.frame.size.width * anchorPoint.x - currentWidth * anchorPoint.x;
            
            CGFloat currentY = oldOrginal.y + self.frame.size.height * anchorPoint.y - currentHeight * anchorPoint.y;
            
            self.frame = CGRectMake(currentX, currentY, currentWidth , currentHeight);
        }];
        tween.duration = duration;
        return tween;
    };
    
}

- (QuickScaleWHBlock)ScaleWidthTo{
    return ^QuickAnimationTween* (CGFloat scale,CGFloat anchor,CGFloat duration){
        
        scale = MAX(0, scale);
        
        CGSize oldSize = self.frame.size;

        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            
            CGPoint oldOrginal = self.frame.origin;
            CGFloat currentValue = [NSValue floatWithFrom:1 to:scale progress:valueProgress];
            
            CGFloat currentWidth = oldSize.width * currentValue;
            CGFloat currentHeight = oldSize.height;
            CGFloat currentX = oldOrginal.x + self.frame.size.width * anchor - currentWidth* anchor;
            CGFloat currentY = oldOrginal.y;
            
            self.frame = CGRectMake(currentX, currentY, currentWidth , currentHeight);
        }];
        tween.duration = duration;
        return tween;
    };

}

- (QuickScaleWHBlock)ScaleHeightTo{
    return ^QuickAnimationTween* (CGFloat scale,CGFloat anchor,CGFloat duration){
        
        scale = MAX(0, scale);
        
        CGSize oldSize = self.frame.size;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGPoint oldOrginal = self.frame.origin;
            CGFloat currentValue = [NSValue floatWithFrom:1 to:scale progress:valueProgress];
            
            CGFloat currentHeight = oldSize.height * currentValue;
            CGFloat currentWidth = oldSize.width;
            CGFloat currentY = oldOrginal.y + self.frame.size.height * anchor - currentHeight* anchor;
            CGFloat currentX = oldOrginal.x;
            
            self.frame = CGRectMake(currentX, currentY, currentWidth , currentHeight);
        }];
        tween.duration = duration;
        return tween;
    };
    
}

#pragma mark - Rotation

- (QuickRotationBlock)RotationTo{
    return ^QuickAnimationTween* (CGFloat rotation,CGFloat duration){
        CGAffineTransform transform = self.transform;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            self.transform = CGAffineTransformRotate(transform, rotation*valueProgress*M_PI / 180.0f);
        }];
        tween.duration = duration;
        return tween;
    };
}

- (QuickRotationAroundXYZBlock)RotationAllAxisTo{
    return ^QuickAnimationTween* (CGFloat x,CGFloat y, CGFloat z,CGFloat duration){
        
        CATransform3D transform = self.layer.transform;
        CGFloat toDegree = M_PI / 180.0f;
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            
            
            CATransform3D nTransform = CATransform3DInvert(transform);
            nTransform.m34 = -1 / 180.0f;
            nTransform = CATransform3DRotate(nTransform,
                                                           x*valueProgress*toDegree,
                                                           1, 0, 0);
            nTransform = CATransform3DRotate(nTransform,
                                            y*valueProgress*toDegree,
                                            0, 1, 0);
            nTransform = CATransform3DRotate(nTransform,
                                            z*valueProgress*toDegree,
                                            0, 0, 1);
            self.layer.transform = nTransform;
            
            
        }];
        tween.duration = duration;
        return tween;
    };

}

#pragma mark - Shake

- (QuickShakeRotationBlock)ShakeRotation{
    
    return  ^id<QuickAnimation> (CGFloat rotationStrength, NSInteger shakeCount ,CGFloat duration){
        
        CGAffineTransform transform = self.transform;
        CGFloat rotation = rotationStrength;
        QuickAnimationSequeue* queue = [[QuickAnimationSequeue alloc]init];
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            
            self.transform = CGAffineTransformRotate(transform, rotation *valueProgress*M_PI / 180.0f);
        }];

        tween.duration = duration / 4.0f;
        tween.loopType = QuickAnimationLoopYoyo;
        [queue appendAnimation:tween];
        
        tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            
            self.transform = CGAffineTransformRotate(transform, -rotation *valueProgress*M_PI / 180.0f);
        }];
        tween.duration = duration / 4.0f;
        tween.loopType = QuickAnimationLoopYoyo;
        [queue appendAnimation:tween];
        queue.loops = shakeCount;
      
        return queue;
    };
}

- (QuickShakePositionBlock)ShakePosition{
    
    return  ^id<QuickAnimation> (CGFloat radiusStrenth, NSInteger shakeCount ,CGFloat duration){
        
        CGPoint center = self.center;
        
//        __block CGFloat x;
//        __block CGFloat sign;
//        __block CGPoint desPoint;
//        __block CGPoint desPoint2;
        CGFloat x = fmod(arc4random(),radiusStrenth*2)-radiusStrenth;
        CGFloat sign = (arc4random() % 2) == 0 ? 1: -1;
        CGPoint desPoint = CGPointMake(center.x + x,
                               center.y + sign * sqrt(radiusStrenth*radiusStrenth - x * x));
        CGPoint desPoint2 = CGPointMake(center.x - x,
                                center.y - sign * sqrt(radiusStrenth*radiusStrenth - x * x));
        
        QuickAnimationSequeue* queue = [[QuickAnimationSequeue alloc]init];
        
        QuickAnimationTween* tween = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGPoint movePoint = [NSValue pointWithFrom:center to:desPoint progress:valueProgress];
            self.center = CGPointMake(movePoint.x, movePoint.y);
        }];
        
//        tween.startCallBack = ^(id<QuickAnimation> anim) {
//             x = fmod(arc4random(),radiusStrenth*2)-radiusStrenth;
//             sign = (arc4random() % 2) == 0 ? 1: -1;
//             desPoint = CGPointMake(center.x + x,
//                                           center.y + sign * sqrt(radiusStrenth*radiusStrenth - x * x));
//             desPoint2 = CGPointMake(center.x - x,
//                                            center.y - sign * sqrt(radiusStrenth*radiusStrenth - x * x));
//        };
        
        tween.duration = duration / 4.0f;
        tween.loopType = QuickAnimationLoopYoyo;
        tween.easeType = QuickAnimationEaseOutSine;
        [queue appendAnimation:tween];
        
        tween =  [[QuickAnimationTween alloc]initWithAnimationBlock:^(float current, float duration, float valueProgress) {
            CGPoint movePoint = [NSValue pointWithFrom:center to:desPoint2 progress:valueProgress];
            self.center = CGPointMake(movePoint.x, movePoint.y);
        }];

        tween.duration = duration / 4.0f;
        tween.loopType = QuickAnimationLoopYoyo;
        tween.easeType = QuickAnimationEaseOutSine;
        [queue appendAnimation:tween];
        queue.loops = shakeCount;
        
        return queue;
    };
}



@end
