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

//- (BOOL)shouldAutorotate{
//    UIViewController *viewController = [alert__oldKeyWindow rootViewController];
//    
//    UIViewController *temViewController = nil;
//    do {
//        temViewController = [viewController childViewControllerForStatusBarHidden];
//        if (temViewController)
//        {
//            viewController = temViewController;
//        }
//        
//    } while (temViewController != nil);
//    
//    return [viewController shouldAutorotate];
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    UIViewController *viewController = [alert__oldKeyWindow rootViewController];
//    
//    UIViewController *temViewController = nil;
//    do {
//        temViewController = [viewController childViewControllerForStatusBarHidden];
//        if (temViewController)
//        {
//            viewController = temViewController;
//        }
//        
//    } while (temViewController != nil);
//    
//    return [viewController supportedInterfaceOrientations];
//}
- (BOOL)prefersStatusBarHidden{
    UIViewController *viewController = [alert__oldKeyWindow rootViewController];
    
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
    UIViewController *viewController = [alert__oldKeyWindow rootViewController];
    
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
