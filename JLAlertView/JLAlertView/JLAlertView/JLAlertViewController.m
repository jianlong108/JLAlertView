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

@interface JLAlertViewController ()

@property (nonatomic, strong) JLAlertView *alertView;

@end

@implementation JLAlertViewController

#pragma mark - View life cycle
- (void)dealloc
{
    NSLog(@"JLAlertViewConroller--dealloc");
}

- (instancetype)initWithAlertView:(JLAlertView *)alertView
{
    if (self = [super init]) {
        self.alertView = alertView;
    }
    return self;
}

- (void)loadView
{
    if (self.alertView) {
        self.view = self.alertView;
    } else {
        self.view = [[UIView alloc]init];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
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

- (BOOL)prefersStatusBarHidden
{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    
    UIViewController *temViewController = nil;
    do {
        temViewController = [viewController childViewControllerForStatusBarHidden];
        if (temViewController)
        {
            viewController = temViewController;
        }
        
    } while (temViewController != nil);
    if ([viewController isEqual:self]) {
        return NO;
    }
    return [viewController prefersStatusBarHidden];
}
- (BOOL)shouldAutorotate
{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    UIViewController *disPlayVC = [JLAlertView getCurrentViewController:viewController];
    if ([disPlayVC isEqual:self]) {
        return YES;
    }
    return [disPlayVC shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    UIViewController *disPlayVC = [JLAlertView getCurrentViewController:viewController];
    if ([disPlayVC isEqual:self]) {
        return UIInterfaceOrientationMaskAll;
    }
    return [disPlayVC supportedInterfaceOrientations];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController *viewController = [[JLAlertView getBusinessWindow] rootViewController];
    
    UIViewController *temViewController = nil;
    do {
        temViewController = [viewController childViewControllerForStatusBarStyle];
        if (temViewController)
        {
            viewController = temViewController;
        }
        
    } while (temViewController != nil);
    if ([viewController isEqual:self]) {
        return UIStatusBarStyleDefault;
    }
    return [viewController preferredStatusBarStyle];
}

@end
