/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.

 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import <pop/POPAnimatableProperty.h>
#import <pop/POPAnimation.h>

/**
 是否对动画的值的进行夹住处理
 Start确保值一定比fromValue大
 End确保值一定比endValue小
 */
typedef NS_OPTIONS(NSUInteger, POPAnimationClampFlags)
{
  kPOPAnimationClampNone        = 0,
  kPOPAnimationClampStart       = 1UL << 0,
  kPOPAnimationClampEnd         = 1UL << 1,
  kPOPAnimationClampBoth = kPOPAnimationClampStart | kPOPAnimationClampEnd,
};

/**
 属性动画
 */
@interface POPPropertyAnimation : POPAnimation

/**
 需要做动画的属性
 */
@property (strong, nonatomic) POPAnimatableProperty *property;

/**
 动画的初始值
 */
@property (copy, nonatomic) id fromValue;

/**
 动画的结束值
*/
@property (copy, nonatomic) id toValue;

/**
 四舍五入程度（与精确度有关）
 1表示直接舍弃小数，以整数递进
 0表示不进行四舍五入
 */
@property (assign, nonatomic) CGFloat roundingFactor;

/**
 动画值的限制模式（Start,End,Both,None）
 */
@property (assign, nonatomic) NSUInteger clampMode;

/**
 该属性表明动画值是每帧递增还是直接设置
 默认是no,因为是否可以递增取决于值的类型
 */
@property (assign, nonatomic, getter = isAdditive) BOOL additive;

@end
