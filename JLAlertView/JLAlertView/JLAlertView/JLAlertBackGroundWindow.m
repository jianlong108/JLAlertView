//
//  JLAlertBackGroundWindow.m
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/29.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertBackGroundWindow.h"
#import "JLAlertBackGroundController.h"
#import "JLBlureView.h"


@implementation JLAlertBackGroundWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.windowLevel = UIWindowLevelAlert - 1;
        self.opaque = NO;
        
//        JLBlureView *blureView = [[JLBlureView alloc]initWithFrame:self.bounds];
//        blureView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self addSubview:blureView];
        
        JLAlertBackGroundController *vc = [[JLAlertBackGroundController alloc] init];
        self.rootViewController = vc;
        self.rootViewController.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] set];
    CGContextFillRect(context, self.bounds);
}

- (void)dealloc
{
    NSLog(@"JLAlertViewBackGroundView--dealloc");
}


@end
