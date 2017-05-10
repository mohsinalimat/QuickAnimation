QuickAnimation
==============

iOS utility classes for creating common animations quickly,referred to Unity Dotween.<br/>
The library is based on the facebook's pop library.


Installation
==============



Simple Usage
==============
### Create move animation
```
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
```
//Change the view's alpha value to 0.2 in 5 seconds
view.FadeTo(0.2f,5f).Play();
```
### Create color animation
```
//Change the view's backgroundColor to red in 5 seconds
view.ColorTo([UIColor redColor],5f).Play();
```

### Create scale animation
```
//With (0.5,0.5) as the anchor point，enlarge the width 1.2 times, enlarge the height 1.5 times , in 5 seconds
view.ScaleTo(CGPointMake(1.2, 1.5), CGPointMake(0.5, 0.5), 5.0f).Play();

// zoom width
view.ScaleWidthTo(1.2,1.2,5.0f).Play();

//zoom height
view.ScaleHeightTo(1,2,1,5.0f).Play();
```

### Create rotation animation
```
//Rotate 320 degrees around the Z axis
view.RotationTo(320f,5f).Play();

//Rotate 100 degrees around the X axis, rotate 200 degrees around the Y axis ,rotate 300 degrees around the Z axis ,in 5 seconds
view.RotationAllAxisTo(100,200,300,5).Play();
```
### Create shake animation
```
//Create an angle jitter animation.The rotation angle is 30 degrees，shake 5 times ,each time 4 seconds
view.ShakeRotation(30,5,4).Play();

//Create an position shake animation.The shake radius is 10，shake 5 times ,each time 4 seconds
view.ShakePosition(10,5,4).Play();
```

### Create UILabel animation
```
UILabel* label = [[UILabel alloc]init];

//Create typewriter animation
label.WriteTextTo(@"the target string",5.0f).Play();

//Create handwriting animation
label.HandWriteTo(@"the target string",5.0f).Play();

//change the label's textColor to red in 5 seconds;
label.TextColorTo([UIColor redColor],5.0f).Play();
```

### Create a queue animation
```
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
```
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
				.From()
				.Play();
     
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

