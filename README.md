QuickAnimation
==============

iOS utility classes for creating common animations quickly,referred to Unity Dotween.<br/>
The library is based on the facebook's pop library.


Installation
==============



Simple Usage
==============
### Create move animation

```objc
UIView* view = [[UIView alloc]init];
//1.Move the center of the view to (100,100) in 5 seconds 
view.MoveTo(CGPointMake(100, 100), 5.0f).Play();

//2.Just move the center.x of the view to 100 in 5 seconds
view.MoveXTo(100.0f, 5.0f).Play();

//3.Just move the center.y of the view to 100 in 5 seconds
view.MoveYTo(100.0f, 5.0f).Play();

//4.Move the center of the view from current position by (100,100) in 5 seconds
view.MoveBy(CGPointMake(100, 100), 5.0f).Play();

//5.Just move the center.x of the view from current x by 100 in 5 seconds
view.MoveXBy(100.0f, 5.0f).Play();

//6.Just move the center.y of the view from current y by 100 in 5 seconds
view.MoveYBy(100.0f, 5.0f).Play();

//7.Move along curve in 5 seconds
UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:view.center radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];

view.MoveCurve(path,5.0f).Play();
```
### Create fade animation
```objc
//Change the view's alpha value to 0.2 in 5 seconds
view.FadeTo(0.2f,5f).Play();
```
### Create color animation
```objc
//Change the view's backgroundColor to red in 5 seconds
view.ColorTo([UIColor redColor],5f).Play();
```

### Create scale animation
```objc
//With (0.5,0.5) as the anchor point，enlarge the width 1.2 times, enlarge the height 1.5 times , in 5 seconds
view.ScaleTo(CGPointMake(1.2, 1.5), CGPointMake(0.5, 0.5), 5.0f).Play();

// zoom width
view.ScaleWidthTo(1.2,1.2,5.0f).Play();

//zoom height
view.ScaleHeightTo(1,2,1,5.0f).Play();
```

### Create rotation animation
```objc
//Rotate 320 degrees around the Z axis
view.RotationTo(320f,5f).Play();

//Rotate 100 degrees around the X axis, rotate 200 degrees around the Y axis ,rotate 300 degrees around the Z axis ,in 5 seconds
view.RotationAllAxisTo(100,200,300,5).Play();
```
### Create shake animation
```objc
//Create an angle jitter animation.The rotation angle is 30 degrees，shake 5 times ,each time 4 seconds
view.ShakeRotation(30,5,4).Play();

//Create an position shake animation.The shake radius is 10，shake 5 times ,each time 4 seconds
view.ShakePosition(10,5,4).Play();
```

### Create UILabel animation
```objc
UILabel* label = [[UILabel alloc]init];

//Create typewriter animation
label.WriteTextTo(@"the target string",5.0f).Play();

//Create handwriting animation
label.HandWriteTo(@"the target string",5.0f).Play();

//change the label's textColor to red in 5 seconds;
label.TextColorTo([UIColor redColor],5.0f).Play();
```

### Create a queue animation
```objc
//The animations in the queue will be played in sequence
QuickAnimationSequeue* queue = [[QuickAnimationSequeue alloc]init];

//first animation
[queue appendAnimation:view.MoveXTo(10,5.0f)];

//second animation
[queue appendAnimation:view.MoveYTo(10,5.0f)];

//join animation, this animation will play with the last animation in queue at the same time
[queue joinAnimation:view.MoveXTo(0,5.0f)];

//append callback,append time interval
[queue appendCallback:^{
	NSLog(@"call back");            
}];
[queue appendInterval:4.0f];
queue.Play();
```
### The animation properties
```objc
/*
@param easeType : Animated easing function
@param delayTime : Delay playing time
@param isFrom : Positive sequence play or reverse play ,default is NO
@param loops : repeat count
@param loopType : whether autoreverse
**/

QuickAnimationTween* animation;
anmation = view.MoveXTo(1,1)
.SetLoops(5,QuickAnimationLoopYoyo)
.SetDelay(5.0f)
.SetEase(QuickAnimationEaseInBounce)
.From().Play();
     
//call back
animation.startCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"start");
};
animation.stopCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"stop");
};
animation.resumeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"resume");
};
animation.pauseCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"pause");
};
animation.completeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"complete");
};

//animation controll
[animation startAnimation];
[animation stopAnimation];
[animation pauseAnimation];
[animation resumeAnimation];
```

Requirements
==============
This library requires `iOS 6.0+`.

License
==============
QuickAnimation is provided under the MIT license. See LICENSE file for details.

中文文档
==============
iOS 快速创建动画的工具类，使用facebook的pop作为动画引擎。参考了unity的dotween中的动画创建方式。

安装
==============

简单用法
==============

### 创建移动动画

```objc
UIView* view = [[UIView alloc]init];
//1.将view的中心移动到坐标（100，100）的位置，动画时间为5妙 
view.MoveTo(CGPointMake(100, 100), 5.0f).Play();

//2.只移动view的center.x到横坐标为100的位置，动画时间5秒
view.MoveXTo(100.0f, 5.0f).Play();

//3.只移动view的center.y到纵坐标为100的位置，动画时间5秒
view.MoveYTo(100.0f, 5.0f).Play();

//4.将view的中心点向x轴移动100个单位，向y轴移动100个单位，动画时间5秒
view.MoveBy(CGPointMake(100, 100), 5.0f).Play();

//5.将view的中心点的x坐标 ，向x轴移动100个单位，用时5秒
view.MoveXBy(100.0f, 5.0f).Play();

//6.将view的中心点的y坐标 ，向y轴移动100个单位，用时5秒
view.MoveYBy(100.0f, 5.0f).Play();

//7.让view的中心点沿着曲线运动，时间5秒
UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:view.center radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];

view.MoveCurve(path,5.0f).Play();
```
### 创建渐隐渐入动画
```objc
//透明度动画，将view的透明度设置到0.2，用时5秒
view.FadeTo(0.2f,5f).Play();
```
### 创建背景颜色动画
```objc
//背景色动画，将view的背景色设置到红色，用时5秒
view.ColorTo([UIColor redColor],5f).Play();
```

### 创建缩放动画
```objc
//将view的宽度缩放1.2倍，高度缩放1.5倍，缩放的锚点为（0.5，0.5），用时5秒
view.ScaleTo(CGPointMake(1.2, 1.5), CGPointMake(0.5, 0.5), 5.0f).Play();

//只缩放宽度
view.ScaleWidthTo(1.2,1.2,5.0f).Play();

//只缩放高度
view.ScaleHeightTo(1,2,1,5.0f).Play();
```

### 创建旋转动画
```objc
//让view绕z轴顺时针旋转320度，用时5秒
view.RotationTo(320f,5f).Play();

//让view绕x轴顺时针100度，绕y轴顺时针旋转200度,绕z轴逆时针旋转300度，用时5秒
view.RotationAllAxisTo(100,200,-300,5).Play();
```
### 创建震动动画
```objc
//创建一个角度抖动动画，抖动的幅度为单边30度，抖动5次，每次抖动耗时4秒
view.ShakeRotation(30,5,4).Play();

//创建一个位移震动动画，震动的圆心为view的center,半径为10，震动5次，每次耗时4秒
view.ShakePosition(10,5,4).Play();
```

### 创建UILabel动画
```objc
UILabel* label = [[UILabel alloc]init];

//创建打字机逐字显示的动画效果
label.WriteTextTo(@"the target string",5.0f).Play();

//创建字迹逐渐显示的动画效果
label.HandWriteTo(@"the target string",5.0f).Play();

//创建文本文字颜色改变的动画效果
label.TextColorTo([UIColor redColor],5.0f).Play();
```

### 创建队列动画
```objc
//队列中的动画将会顺序播放
QuickAnimationSequeue* queue = [[QuickAnimationSequeue alloc]init];
//第一个动画
[queue appendAnimation:view.MoveXTo(10,5.0f)];

//第二个动画
[queue appendAnimation:view.MoveYTo(10,5.0f)];

//并行动画，加入的动画将会和队列中的最后一个动画同时播放
[queue joinAnimation:view.MoveXTo(0,5.0f)];

//添加回调函数和时间间隔
[queue appendCallback:^{
	NSLog(@"call back");            
}];
[queue appendInterval:4.0f];
queue.Play();
```
### The animation properties
```objc
/*
@param easeType : 动画播放时的缓动模式
@param delayTime : 动画延迟播放的时间
@param isFrom : isFrom为YES时，动画倒序播放，默认为no,正序播放
@param loops : 动画循环次数
@param loopType : 动画循环播放方式，1.每次播放都重头播放 2.每次播放都包含1个往返，即播放完成后会自动倒序播放
**/

QuickAnimationTween* animation;
anmation = view.MoveXTo(1,1)
.SetLoops(5,QuickAnimationLoopYoyo)
.SetDelay(5.0f)
.SetEase(QuickAnimationEaseInBounce)
.From().Play();
     
//动画回调函数
animation.startCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"start");
};
animation.stopCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"stop");
};
animation.resumeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"resume");
};
animation.pauseCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"pause");
};
animation.completeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"complete");
};

//动画控制方法
[animation startAnimation];
[animation stopAnimation];
[animation pauseAnimation];
[animation resumeAnimation];
```


