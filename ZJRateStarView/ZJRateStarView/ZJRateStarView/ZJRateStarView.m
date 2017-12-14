//
//  ZJRateStarView.m
//  ZJRateStarView
//
//  Created by zoujie on 2017/12/14.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJRateStarView.h"

@interface ZJRateStarView()
//normal star imageviews
@property (nonatomic, strong) NSArray *normalStars;
//highlight star imageviews
@property (nonatomic, strong) NSArray *selectedStars;
//highlight star containers
@property (nonatomic, strong) UIView *progressView;

@end

@implementation ZJRateStarView

+ (instancetype)starView {
    return [[ZJRateStarView alloc] initWithTotalStars:5 style:ZJRateStarStyleTotalOnly currentScores:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultConfig];
        [self addEventAction];
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
        [self addEventAction];
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithTotalStars:(CGFloat)totalStars style:(ZJRateStarStyle)style currentScores:(CGFloat)currentScores {
    self = [super init];
    if (self) {
        _totalStars = totalStars;
        _style = style;
        _currentScores = currentScores;
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateAllFrames];
}

- (CGSize)intrinsicContentSize {//autolayout self-size
    return CGSizeMake((_starSize.width + _paddingWidth) * _totalStars - _paddingWidth, _starSize.height);
}
#pragma mark - Set Up UI
- (void)defaultConfig {
    _totalStars = 5;
    _style = ZJRateStarStyleTotalOnly;
    _currentScores = 0;
    _paddingWidth = 10;
    _starSize = CGSizeMake(28, 28);
    _normalImage = [self bundleImageWithName:@"rate_star_normal"];
    _selectedImage = [self bundleImageWithName:@"rate_star_highlight"];
}

- (void)setUpUI {
    [self clearAllStars];
    [self setUpNormalStars];
    [self setUpSelectedStars];
}

- (void)setUpNormalStars {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger index = 0; index < _totalStars; index ++) {
        UIImageView *star = [[UIImageView alloc] initWithImage:_normalImage];
        star.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:star];
        [array addObject:star];
    }
    _normalStars = array.copy;
}

- (void)setUpSelectedStars {
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height - _starSize.height) / 2, [self progressWidth], _starSize.height)];
    _progressView.backgroundColor = [UIColor clearColor];
    _progressView.clipsToBounds = YES;
    [self addSubview:_progressView];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger index = 0; index < _totalStars; index ++) {
        UIImageView *star = [[UIImageView alloc] initWithImage:_selectedImage];
        star.contentMode = UIViewContentModeScaleAspectFill;
        [_progressView addSubview:star];
        [array addObject:star];
    }
    _selectedStars = array.copy;
}

- (void)clearAllStars {
    if (_normalStars.count > 0) {
        for (UIImageView *normalStar in _normalStars) {
            [normalStar removeFromSuperview];
        }
        _normalStars = @[];
    }
    if (_progressView) {
        [_progressView removeFromSuperview];
        _progressView = nil;
        _selectedStars = @[];
    }
}

#pragma mark - Helper
- (CGFloat )progressWidth {
    CGFloat score = [self translateScore:_currentScores];
    NSInteger total = floor(score);
    CGFloat more = score - total;
    return total * (_paddingWidth + _starSize.width) + more * _starSize.width;
}

- (CGFloat )translateScore:(CGFloat )score {
    if (score < 0) {
        return 0;
    }
    if (score > _totalStars) {
        return _totalStars;
    }
    
    if (self.style == ZJRateStarStyleTotalOnly) {
        return ceil(score);
    }
    else if (self.style == ZJRateStarStyleAllowHalf) {
        return ceil(score * 2) / 2.0;
    }
    else if (self.style == ZJRateStarStyleAllowFloat) {
        return ceil(score * 10) / 10.0;
    }
    return score;
}

- (void)updateAllFrames {
    for (UIImageView *star in _normalStars) {
        NSInteger index = [_normalStars indexOfObject:star];
        star.center = CGPointMake(_starSize.width / 2 + index * (_starSize.width + _paddingWidth), self.bounds.size.height / 2);
        star.bounds = CGRectMake(0, 0, _starSize.width, _starSize.height);
    }
    for (UIImageView *star in _selectedStars) {
        NSInteger index = [_selectedStars indexOfObject:star];
        star.center = CGPointMake(_starSize.width / 2 + index * (_starSize.width + _paddingWidth), self.bounds.size.height / 2);
        star.bounds = CGRectMake(0, 0, _starSize.width, _starSize.height);
    }
    _progressView.frame = CGRectMake(0, (self.bounds.size.height - _starSize.height) / 2, [self progressWidth], _starSize.height);
}

- (UIImage *)bundleImageWithName:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ZJRateStarView" ofType:@"bundle"];
    bundlePath = [[NSBundle bundleWithPath:bundlePath] pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:bundlePath];
}

#pragma mark - Event Action
- (void)addEventAction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDidTap:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGestureDidTap:(UITapGestureRecognizer *)tap {
    if (!_allowRate) {
        return;
    }
    CGFloat tapOffsetX = [tap locationInView:self].x;
    NSInteger totalSores = floor(tapOffsetX / (_starSize.width + _paddingWidth));
    CGFloat more = tapOffsetX - totalSores * (_starSize.width + _paddingWidth);
    if (more > _starSize.width) {//空白位置的点击
        return;
    }
    self.currentScores = [self translateScore:totalSores + more / _starSize.width];
    if ([self.delegate respondsToSelector:@selector(zjRateStarViewDidTapScore:)]) {
        [self.delegate zjRateStarViewDidTapScore:_currentScores];
    }
}
#pragma mark - Setter
- (void)setCurrentScores:(CGFloat)currentScores {
    _currentScores = [self translateScore:currentScores];
    if (_progressView) {
        [UIView animateWithDuration:(_hasAnimation ? 0.2 : 0) animations:^{
            _progressView.frame = CGRectMake(0, (self.bounds.size.height - _starSize.height) / 2, [self progressWidth], _starSize.height);
        }];
    }
}

- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    for (UIImageView *star in _normalStars) {
        star.image = _normalImage;
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    for (UIImageView *star in _selectedStars) {
        star.image = _selectedImage;
    }
}

- (void)setStarSize:(CGSize)starSize {
    _starSize = starSize;
    [self setNeedsLayout];
}

- (void)setPaddingWidth:(CGFloat)paddingWidth {
    _paddingWidth = paddingWidth;
    [self setNeedsLayout];
}

- (void)setTotalStars:(NSInteger)totalStars {
    if (_totalStars != totalStars) {
        _totalStars = totalStars;
        [self setUpUI];
    }
}

- (void)setStyle:(ZJRateStarStyle)style {
    if (_style != style) {
        _style = style;
        self.currentScores = _currentScores;
    }
}

@end
