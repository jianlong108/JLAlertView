//
//  CXCusKeyWindowRootViewController.m
//  CXAlertViewDemo
//
//  Created by Wangjianlong on 2018/12/5.
//  Copyright © 2018 JL. All rights reserved.
//

#import "CusKeyWindowRootViewController.h"

@interface CusKeyWindowRootViewController ()

@property(nonatomic, strong) CustomKeyWindow *keyWindow;

@end

@implementation CusKeyWindowRootViewController

- (instancetype)initWithCustomKeyWindow:(CustomKeyWindow *)customKeyWindow
{
    if (self = [super init]) {
        _keyWindow = customKeyWindow;
    }
    return self;
}

- (void)loadView
{
    self.view = self.keyWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


@end
