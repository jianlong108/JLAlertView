//
//  JLAlertViewBackGroundController.m
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/29.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertBackGroundController.h"
#import "JLAlertHeader.h"

@interface JLAlertView ()

+ (UIViewController *)getCurrentViewController:(UIViewController *)vc;
+ (UIWindow *)getBusinessWindow;

@end

@interface JLAlertBackGroundController ()

@end

@implementation JLAlertBackGroundController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return self;
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

- (void)dealloc
{
    NSLog(@"JLAlertBackGroundController--dealloc");
}

@end
