//
//  JLAlertViewController.h
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/8.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLAlertView.h"

@interface JLAlertViewController : UIViewController


@property (nonatomic, strong) JLAlertView *alertView;

@property (nonatomic, assign) BOOL rootViewControllerPrefersStatusBarHidden;
@property (nonatomic, assign) BOOL rootViewControllerCanRoration;
@property (nonatomic, assign) UIInterfaceOrientationMask rootViewControllerInterfaceOrientationMask;
@end
