//
//  JLAlertViewBackGroundController.m
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/29.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertBackGroundController.h"
#import "JLAlertHeader.h"

@interface JLAlertBackGroundController ()

@end

@implementation JLAlertBackGroundController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return self;
}
- (BOOL)prefersStatusBarHidden
{
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
- (BOOL)shouldAutorotate{
    UIViewController *viewController = [alert__oldKeyWindow rootViewController];
    
    UIViewController *temViewController = nil;
    do {
        temViewController = [viewController childViewControllerForStatusBarHidden];
        if (temViewController)
        {
            viewController = temViewController;
        }
        
    } while (temViewController != nil);
    
    return [viewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UIViewController *viewController = [alert__oldKeyWindow rootViewController];
    
    UIViewController *temViewController = nil;
    do {
        temViewController = [viewController childViewControllerForStatusBarHidden];
        if (temViewController)
        {
            viewController = temViewController;
        }
        
    } while (temViewController != nil);
    
    return [viewController supportedInterfaceOrientations];
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
- (void)dealloc{
    NSLog(@"JLAlertBackGroundController--dealloc");
}

@end
