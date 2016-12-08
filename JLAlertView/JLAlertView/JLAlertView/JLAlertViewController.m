//
//  JLAlertViewController.m
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/8.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertViewController.h"
@interface JLAlertView ()

- (void)initializeView;

@end

@implementation JLAlertViewController
#pragma mark - View life cycle

- (void)loadView
{
    self.view = self.alertView;
}
- (void)dealloc{
    //    NSLog(@"AHAlertViewConroller--dealloc");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.alertView initializeView];
    
    [UIApplication sharedApplication].statusBarHidden = _rootViewControllerPrefersStatusBarHidden;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = _rootViewControllerPrefersStatusBarHidden;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = _rootViewControllerPrefersStatusBarHidden;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.alertView setNeedsLayout];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return _rootViewControllerInterfaceOrientationMask;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return _rootViewControllerCanRoration;
}

- (BOOL)shouldAutorotate
{
    return _rootViewControllerCanRoration;
}
- (BOOL)prefersStatusBarHidden
{
    return _rootViewControllerPrefersStatusBarHidden;
}
@end
