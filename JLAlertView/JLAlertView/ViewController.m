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

/***/
@property (nonatomic, weak) CAShapeLayer *shapLayer;

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
    
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 300, 100, 100)].CGPath;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.fillRule = @"even-odd";
    shapLayer.strokeColor = [UIColor redColor].CGColor;
    
    shapLayer.strokeStart = 0.0;
    shapLayer.strokeEnd = 0.5;
    
    //斜接...拐角处的角度.
    _shapLayer.miterLimit = 3;
    
    shapLayer.lineWidth = 5;
    
    //设置路径上最后一个点的样式
    shapLayer.lineCap = kCALineCapSquare;
    
    //设置路径上拐点的样式
    shapLayer.lineJoin = kCALineJoinRound;
    
    [self.view.layer addSublayer:shapLayer];
    _shapLayer = shapLayer;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [[NSNotificationCenter defaultCenter]postNotificationName:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice] userInfo:@{@"UIDeviceOrientation":@3}];
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
    CGFloat end = _shapLayer.strokeEnd;
    end+=0.01;
    if (end > 1.0) {
        end = 1.0f;
    }
    _shapLayer.strokeEnd = end;
    
    
    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
//    NSLog(@"preferredStatusBarStyle");
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
- (void)entryAPPSTORE{
    UIAlertView *ALERT1 = [[UIAlertView alloc]initWithTitle:@"第一个" message:@"喜欢我就给我个好评吧.谢谢啊,我会努力做得更好!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [ALERT1 show];
    
    UIAlertView *ALERT2 = [[UIAlertView alloc]initWithTitle:@"第2个" message:@"喜欢我就给我个好评吧.谢谢啊,我会努力做得更好!" delegate:self cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [ALERT2 show];
}
- (void)entryPhotoReader{
    JLAlertView *alert = [[JLAlertView alloc]initWithTitle:@"第一个" message:@"喜欢我就给我个好评吧.谢谢啊,我会努力做得更好!" delegate:nil SureButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
    JLAlertView *alert1 = [[JLAlertView alloc]initWithTitle:@"第2个" message:@"喜欢我就给我个好评吧.谢谢啊,我会努力做得更好!" delegate:nil SureButtonTitle:@"sure" otherButtonTitles:nil];
    [alert1 show];
}
@end
