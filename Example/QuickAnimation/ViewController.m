//
//  ViewController.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "ViewController.h"
#import "QuickAnimationTween.h"
#import "QuickAnimationSequeue.h"
#import "UIView+Animation.h"
#import "UILabel+Animation.h"
#import "CALayer+Animation.h"
#import <JPFPSStatus.h>
#import "CAShapeLayer+Animation.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *dummy;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) QuickAnimationSequeue* animation;
@property (weak, nonatomic) IBOutlet UIView *aView;
@property (nonatomic, strong) QuickAnimationTween* sanimation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[JPFPSStatus sharedInstance] open];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _aView.hidden = YES;
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor purpleColor];
    UILabel* subView = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 40, 200)];
    subView.numberOfLines = 0;
    subView.textColor = [UIColor blueColor];
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:subView];
    [self.view addSubview:view];
    
    CAShapeLayer* shape = [CAShapeLayer layer];
    [self.view.layer addSublayer:shape];
    shape.frame = self.view.bounds;
    shape.path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    shape.fillColor = [UIColor grayColor].CGColor;
    shape.strokeColor = [UIColor purpleColor].CGColor;
    shape.lineWidth = 5;
    shape.StrokeRangeTo(0, 0, 5).Play();
    shape.StrokeColorTo([UIColor yellowColor], 5).Play();
    shape.FillColorTo(nil, 5).Play();
    shape.LineWidthTo(0, 5).Play();
    view.layer.ShadowColorTo([UIColor purpleColor], 5).Play();
    view.layer.BorderWidthTo(3, 5).Play();
    view.layer.BorderColorTo([UIColor yellowColor], 5).Play();
    view.layer.ShadowOpacityTo(5, 5).Play();
    view.layer.ShadowRadiusTo(10, 5).Play();
    view.layer.ShadowOffsetTo(CGPointMake(5, -5), 5).Play();
    view.layer.CornerRadiusTo(30, 5).Play();
    
}
- (IBAction)action:(id)sender {
    static int i = 0;
    if (i % 2 == 0){
        [self.animation stopAnimation];
    }else{
        [self.animation startAnimation];
    }
    i++;
}
-(void)testQueue{
    
    
    
    self.dummy = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.dummy.layer.cornerRadius = 15.0f;
    self.dummy.backgroundColor = [UIColor darkGrayColor];
    self.dummy.center = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-50, 150);
    
    UIView *centerMark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.dummy addSubview:centerMark];
    centerMark.backgroundColor = [UIColor redColor];
    centerMark.layer.cornerRadius = 5.0f;
    centerMark.center = CGPointMake(15.0f, 15.0f);
    
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.ball.layer.cornerRadius = 5.0f;
    self.ball.backgroundColor = [UIColor redColor];
    self.ball.center = CGPointMake(CGRectGetMinX([UIScreen mainScreen].bounds)+50, 150);
    
    CGFloat fromValue = self.dummy.center.y;
    CGFloat toValue = self.dummy.center.y+200;
    NSMutableArray* queues = [NSMutableArray array];
    
    
    
    for (int i=0;i<3;i++){
        QuickAnimationSequeue* queue = [[QuickAnimationSequeue alloc]init];
        queue.name = [NSString stringWithFormat:@"队列%d",i+1];
        queue.startCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-开始动画",anim.name);
        };
        
        queue.stopCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-手动停止动画",anim.name);
        };
        queue.resumeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-恢复动画",anim.name);
        };
        queue.pauseCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-暂停动画",anim.name);
        };
        queue.completeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-完成动画",anim.name);
        };
        [queues addObject:queue];
    }
    self.animation = queues[0];
    self.animation.loops = 2;
    self.animation.delayTime = 2;
    for (int i=0;i<2;i++){
        QuickAnimationTween* anim = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float t, float d,float valueProgress) {
            
        }];
        
        [queues[1] appendAnimation:anim];
        [queues[1] appendCallback:^{
            
        }];
        if (i==1){
            QuickAnimationTween* anim = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float t, float d,float valueProgress) {
                
            }];
            anim.easeType = QuickAnimationEaseInBounce;
            anim.duration = 6;
            anim.name = [NSString stringWithFormat:@"动画other-%d",i+1];
            anim.startCallBack = ^(id<QuickAnimation> anim) {
                NSLog(@"%@-开始动画",anim.name);
            };
            anim.stopCallBack = ^(id<QuickAnimation> anim) {
                NSLog(@"%@-手动停止动画",anim.name);
            };
            anim.resumeCallBack = ^(id<QuickAnimation> anim) {
                NSLog(@"%@-恢复动画",anim.name);
            };
            anim.pauseCallBack = ^(id<QuickAnimation> anim) {
                NSLog(@"%@-暂停动画",anim.name);
            };
            anim.completeCallBack = ^(id<QuickAnimation> anim) {
                NSLog(@"%@-完成动画",anim.name);
            };
            [queues[1] joinAnimation:anim];
        }
        anim.easeType = QuickAnimationEaseInBounce;
        anim.duration = 5;
        anim.name = [NSString stringWithFormat:@"动画2-%d",i+1];
        anim.startCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-开始动画",anim.name);
        };
        anim.stopCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-手动停止动画",anim.name);
        };
        anim.resumeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-恢复动画",anim.name);
        };
        anim.pauseCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-暂停动画",anim.name);
        };
        anim.completeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-完成动画",anim.name);
        };
        
    }
    for (int i=0;i<2;i++){
        QuickAnimationTween* anim = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float t, float d,float valueProgress) {
            
        }];
        
        [queues[2] appendAnimation:anim];
        
        anim.easeType = QuickAnimationEaseInBounce;
        anim.duration = 6;
        anim.name = [NSString stringWithFormat:@"动画3-%d",i+1];
        anim.startCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-开始动画",anim.name);
        };
        anim.stopCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-手动停止动画",anim.name);
        };
        anim.resumeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-恢复动画",anim.name);
        };
        anim.pauseCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-暂停动画",anim.name);
        };
        anim.completeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-完成动画",anim.name);
        };
        
    }
    
    for (int i=0;i<3;i++){
        QuickAnimationTween* anim = [[QuickAnimationTween alloc]initWithAnimationBlock:^(float t, float d,float valueProgress) {
            if (d==0) return ;
            CGFloat value = (toValue-fromValue)*valueProgress + fromValue;
            self.dummy.center = CGPointMake(self.dummy.center.x, value);
            self.ball.center = CGPointMake(50+(CGRectGetWidth([UIScreen mainScreen].bounds)-150)*(t/d), value);
            
        }];
        
        [queues[0] appendAnimation:anim];
        if (i==1){
            [queues[0] joinAnimation:queues[1]];
            [queues[0] joinAnimation:queues[2]];
        }
        anim.easeType = QuickAnimationEaseInBounce;
        anim.duration = 5;
        anim.name = [NSString stringWithFormat:@"动画1-%d",i+1];
        anim.startCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-开始动画",anim.name);
        };
        anim.stopCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-手动停止动画",anim.name);
        };
        anim.resumeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-恢复动画",anim.name);
        };
        anim.pauseCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-暂停动画",anim.name);
        };
        anim.completeCallBack = ^(id<QuickAnimation> anim) {
            NSLog(@"%@-完成动画",anim.name);
        };
        
    }
    [self.animation startAnimation];
    
}
@end
