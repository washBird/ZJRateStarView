//
//  ZJRateStarView.h
//  ZJRateStarView
//
//  Created by zoujie on 2017/12/14.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZJRateStarStyle) {
    ZJRateStarStyleTotalOnly = 0,
    ZJRateStarStyleAllowHalf,//0.5
    ZJRateStarStyleAllowFloat,//0.1,0.2..
};

@protocol ZJRateStarViewDelegate<NSObject>
@optional
- (void)zjRateStarViewDidTapScore:(CGFloat )currentScore;
@end

@interface ZJRateStarView : UIView

//set to change all star numbers
@property (nonatomic, assign) NSInteger totalStars;

//set to change star score type
@property (nonatomic, assign) ZJRateStarStyle style;

//set to change star scores, get current star scores
@property (nonatomic, assign) CGFloat currentScores;

//set to change star size
@property (nonatomic, assign) CGSize starSize;

//set to change space between two stars
@property (nonatomic, assign) CGFloat paddingWidth;

//set these to custom star image
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

//set to allow tap action
@property (nonatomic, assign) BOOL allowRate;

//set to enable animation
@property (nonatomic, assign) BOOL hasAnimation;

//change score delegate
@property (nonatomic, weak) id<ZJRateStarViewDelegate> delegate;

+ (instancetype )starView;

- (instancetype)initWithTotalStars:(CGFloat )totalStars style:(ZJRateStarStyle )style currentScores:(CGFloat )currentScores;

@end
