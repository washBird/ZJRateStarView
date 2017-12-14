//
//  ViewController.m
//  ZJRateStarView
//
//  Created by zoujie on 2017/12/14.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ViewController.h"
#import "ZJRateStarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZJRateStarView *rateView = [ZJRateStarView starView];
    rateView.frame = CGRectMake(100, 100, 200, 40);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
