//
//  ViewController.m
//  ZJRateStarView
//
//  Created by zoujie on 2017/12/14.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ViewController.h"
#import "ZJRateStarView.h"

@interface ViewController ()<ZJRateStarViewDelegate>
@property (weak, nonatomic) IBOutlet ZJRateStarView *rateStarView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rateStarView.style = ZJRateStarStyleAllowFloat;
    _rateStarView.currentScores = 4.6;
    _rateStarView.allowRate = YES;
    _rateStarView.delegate = self;
    
    ZJRateStarView *rateView = [ZJRateStarView starView];
    rateView.frame = CGRectMake(100, 100, 300, 40);
    rateView.normalImage = [UIImage imageNamed:@"star_normal"];
    rateView.selectedImage = [UIImage imageNamed:@"star_highlighted"];
    rateView.starSize = CGSizeMake(40, 40);
    rateView.paddingWidth = 5;
    [self.view addSubview:rateView];
}

- (void)zjRateStarView:(ZJRateStarView *)rateStarView didTapScore:(CGFloat)currentScore {
    _rateLabel.text = [NSString stringWithFormat:@"%.1f",currentScore];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
