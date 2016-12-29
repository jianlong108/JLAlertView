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
    return NO;
//    return JLAlertView_prefersStatusBarHidden;
}
- (BOOL)shouldAutorotate{
//    return JLAlertView_canrorate;
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return JLAlertView_InterfaceOrientationMask;
    return UIInterfaceOrientationMaskPortrait;
}
- (void)dealloc{
    NSLog(@"JLAlertBackGroundController--dealloc");
}
//- (UIViewController *)childViewControllerForStatusBarStyle{
//    NSLog(@"JLAlertBackGroundController--childViewControllerForStatusBarStyle--%@",self.oldKeyWindow.rootViewController);
//    return self.oldKeyWindow.rootViewController;
//}
//- (UIViewController *)childViewControllerForStatusBarHidden{
//    return self.oldKeyWindow.rootViewController;
//}
@end
