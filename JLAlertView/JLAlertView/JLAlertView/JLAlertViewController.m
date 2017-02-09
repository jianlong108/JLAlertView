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
@property (nonatomic, strong)UIWindow *alertWindow;
@property (nonatomic, strong)JLAlertBackGroundWindow *alert__BackGroundView;

- (void)initializeView;
+ (UIViewController *)getCurrentViewController:(UIViewController *)vc;
+ (UIWindow *)getBusinessWindow;
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

- (BOOL)shouldAutorotate{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    UIViewController *disPlayVC = [JLAlertView getCurrentViewController:viewController];
    return [disPlayVC shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    UIViewController *disPlayVC = [JLAlertView getCurrentViewController:viewController];
    return [disPlayVC supportedInterfaceOrientations];
}
- (BOOL)prefersStatusBarHidden{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    
    UIViewController *temViewController = nil;
    do {
        temViewController = [viewController childViewControllerForStatusBarHidden];
        if (temViewController)
        {
            viewController = temViewController;
        }
        
    } while (temViewController != nil);
    
    return [viewController prefersStatusBarHidden];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    
    UIViewController *temViewController = nil;
    do {
        temViewController = [viewController childViewControllerForStatusBarStyle];
        if (temViewController)
        {
            viewController = temViewController;
        }
        
    } while (temViewController != nil);
    
    return [viewController preferredStatusBarStyle];
}

@end
