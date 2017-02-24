//
//  JLBlureView.m
//  JLAlertView
//
//  Created by Wangjianlong on 2017/2/23.
//  Copyright © 2017年 JL. All rights reserved.
//

#import "JLBlureView.h"


@interface JLBlureView ()

@property (nonatomic, weak) UIToolbar *toolbar;

- (void)setup;

@end

@implementation JLBlureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _toolbar.frame = self.bounds;
    _backgroundView.frame = self.bounds;
}

#pragma mark - PB
- (void)blur
{
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.7;
    }];
}

#pragma - PV
- (void)setup
{
    if (!_toolbar) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        toolbar.translucent = YES;
        toolbar.barStyle = UIBarStyleBlack;
        [self.layer insertSublayer:toolbar.layer atIndex:0];
        _toolbar = toolbar;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.alpha = 0.4;
        backgroundView.backgroundColor = [UIColor blackColor];
        [self.layer insertSublayer:backgroundView.layer above:_toolbar.layer];
        _backgroundView = backgroundView;
    }
}
@end
