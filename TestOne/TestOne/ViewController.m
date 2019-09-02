//
//  ViewController.m
//  TestOne
//
//  Created by Qiang Lee on 2019/9/2.
//  Copyright © 2019 JMFT. All rights reserved.
//

#import "ViewController.h"
#import "WaveLineAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WaveLineAnimationView *view = [[WaveLineAnimationView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:view];
}


@end
