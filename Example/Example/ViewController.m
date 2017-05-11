//
//  ViewController.m
//  Example
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "ViewController.h"
#import "QuickAnimationHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
    view.MoveTo(CGPointMake(100, 100), 5).Play();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
