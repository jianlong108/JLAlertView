//
//  CXCusKeyWindowRootViewController.h
//  CXAlertViewDemo
//
//  Created by Wangjianlong on 2018/12/5.
//  Copyright © 2018 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface CusKeyWindowRootViewController : UIViewController

@property(nonatomic, readonly) CustomKeyWindow *keyWindow;
@property (nonatomic, assign) BOOL rootViewControllerPrefersStatusBarHidden;
- (instancetype)initWithCustomKeyWindow:(CustomKeyWindow *)customKeyWindow;


@end

NS_ASSUME_NONNULL_END
