//
//  JLAlertViewController.m
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/8.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertViewController.h"
#import "JLAlertHeader.h"

@interface JLAlertView ()

@property (nonatomic, strong)UIWindow *oldKeyWindow;

- (void)initializeView;

@end

@implementation JLAlertViewController
#pragma mark - View life cycle

- (void)dealloc{
    NSLog(@"JLAlertViewConroller--dealloc");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.alertView];
    
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
//- (UIViewController *)childViewControllerForStatusBarStyle{
//    NSLog(@"JLAlertViewController--childViewControllerForStatusBarStyle--%@",_alert__BackGroundView.rootVC.oldKeyWindow.rootViewController);
//    return _alert__BackGroundView.rootVC.oldKeyWindow.rootViewController;
//}
//- (UIViewController *)childViewControllerForStatusBarHidden{
//    return _alert__BackGroundView.rootVC.oldKeyWindow.rootViewController;
//}
@end
