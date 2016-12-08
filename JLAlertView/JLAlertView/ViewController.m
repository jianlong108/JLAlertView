//
//  ViewController.m
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/8.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "ViewController.h"
#import "JLAlertView.h"

@interface ViewController ()
/**<#说明#>*/
@property (nonatomic, strong)JLAlertView *alert;
@property (nonatomic, strong)JLAlertView *alert1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2*30;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    btn.frame = CGRectMake(30, 44, width, 50);
    [btn setTitle:@"弹alertview" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(entryPhotoReader) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.backgroundColor = [UIColor blackColor];
    btn0.frame = CGRectMake(30, 244, width, 50);
    [btn0 setTitle:@"弹系统alertview" forState:UIControlStateNormal];
    [self.view addSubview:btn0];
    [btn0 addTarget:self action:@selector(entryAPPSTORE) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)entryAPPSTORE{;
}
- (void)entryPhotoReader{
    _alert = [[JLAlertView alloc]initWithTitle:@"第一个" message:@"hello" delegate:nil SureButtonTitle:@"ok" otherButtonTitles:nil];
    [_alert show];
    
    _alert1 = [[JLAlertView alloc]initWithTitle:@"第2个" message:@"welcome" delegate:nil SureButtonTitle:@"sure" otherButtonTitles:nil];
    [_alert1 show];
}
@end
