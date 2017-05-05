//
//  ViewController.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "ViewController.h"
#import "MMPaintView.h"
#import "QuickAnimationTween.h"
#import "QuickAnimationSequeue.h"
#import "UIView+Animation.h"
#import "UILabel+Animation.h"

@interface ViewController ()
@property (nonatomic, strong) MMPaintView *paintView;
@property (nonatomic, strong) UIView *dummy;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, weak) QuickAnimationSequeue* animation;
@property (weak, nonatomic) IBOutlet UIView *aView;
@property (nonatomic, strong) QuickAnimationTween* sanimation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _aView.hidden = YES;
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 500, 100)];
    view.backgroundColor = [UIColor purpleColor];
    UILabel* subView = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 400, 80)];
    subView.numberOfLines = 0;
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    subView.backgroundColor = [UIColor yellowColor];
    [view addSubview:subView];
    [self.view addSubview:view];
    
//    QuickAnimationTween* t = _aView.MoveTo(CGPointMake(100, 100), 3);
//    t.easeType = QuickAnimationEaseOutBounce;
//    [t startAnimation];
    
//    QuickAnimationTween* tween =  _aView.Scale(CGPointMake(0.5, 0.5),CGPointMake(0.5, 0.5),3);
    QuickAnimationTween* tween =  subView.WriteTextTo(@"发送到发送的服务而且人情味儿去玩儿企鹅我认为而且儿玩儿玩儿去",3);
    [subView.TextColorTo([UIColor redColor], 3) startAnimation];
    tween.easeType = QuickAnimationEaseOutExpo;
    [tween startAnimation];

    
    
    
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
    
    
    self.paintView = [[MMPaintView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:self.paintView atIndex:0];
    self.paintView.backgroundColor = [UIColor whiteColor];
    
    self.dummy = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.dummy.layer.cornerRadius = 15.0f;
    self.dummy.backgroundColor = [UIColor darkGrayColor];
    self.dummy.center = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-50, 150);
    
    UIView *centerMark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.dummy addSubview:centerMark];
    centerMark.backgroundColor = [UIColor redColor];
    centerMark.layer.cornerRadius = 5.0f;
    centerMark.center = CGPointMake(15.0f, 15.0f);
    
    [self.paintView addSubview:self.dummy];
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.ball.layer.cornerRadius = 5.0f;
    self.ball.backgroundColor = [UIColor redColor];
    self.ball.center = CGPointMake(CGRectGetMinX([UIScreen mainScreen].bounds)+50, 150);
    
    [self.paintView addSubview:self.ball];
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
    self.paintView.backgroundColor = [UIColor clearColor];
    self.paintView.layer.backgroundColor = [UIColor purpleColor].CGColor;
    
}
@end
