//
//  JLAlertView.h
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/8.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertView.h"
#import "AppDelegate.h"
#import "JLAlertViewController.h"
#import "JLAlertWindow.h"
#import "JLAlertBackGroundWindow.h"
#import "JLAlertHeader.h"


static UIWindow *alert__oldKeyWindow;

@interface JLAlertView ()


/**内容背景视图  覆盖 标题 和 副标题*/
@property (nonatomic, strong)UIView *whiteBackView;

/**mainView*/
@property (nonatomic, strong)UIView *mainView;

/**topTitle*/
@property (nonatomic, strong)UILabel *topTitleLabel;

/**second title*/
@property (nonatomic, strong)UILabel *secondDescription;

/**显示内容队列*/
@property (nonatomic, strong)NSMutableArray *contentDatas;

/**确定按钮*/
@property (nonatomic, strong)UIButton *sureBtn;

/**按钮数组*/
@property (nonatomic, strong)NSMutableArray *btns;

/**是否为两个按钮*/
@property (nonatomic, assign)BOOL isDouble;

/**contentW*/
@property (nonatomic, assign)CGFloat contentW;

/**contentW*/
@property (nonatomic, assign)UIEdgeInsets contentInsets;

/**widndow*/
@property (nonatomic, strong)UIWindow *oldKeyWindow;

@property (nonatomic, strong)UIWindow *alertWindow;

@property (nonatomic, strong)JLAlertBackGroundWindow *alert__BackGroundView;

/**是否可见*/
@property (nonatomic, assign,getter=isVisible)BOOL visible;

/**ge */
@property (nonatomic, weak)UIViewController *associatedViewController;


@end


@implementation JLAlertView
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate SureButtonTitle:(nullable NSString *)sureButtonTitle otherButtonTitles:(NSArray <NSString *>*) otherButtonTitles
{
    if (self = [self initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.delegate = delegate;
        [self initializeDataWithTitle:title Message:message SureButtonTitle:sureButtonTitle otherButtonTitles:otherButtonTitles];
        
        [self setUpViews];
        
        [self initializeView];
        
//        if([[JLSkinManager sharedManager] isNightSkin]){
//            UIView *nightLayer  = [[UIView alloc]initWithFrame:self.bounds];
//            nightLayer.userInteractionEnabled = NO;
//            nightLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//            nightLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//            [self insertSubview:nightLayer aboveSubview:_mainView];
//        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willregin) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeregin) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}
- (void)willregin{
    if (self.visible) {
        [self.oldKeyWindow makeKeyAndVisible];
        [self tearDown:NO];
        _alert__BackGroundView = nil;
        for (JLAlertView *view in [JLAlertView allAlerts]) {
            view.associatedViewController = nil;
            view.visible = NO;
            view.alertWindow = nil;
        }
    }
}
- (void)becomeregin{
    JLAlertView *alert = [[JLAlertView allAlerts] lastObject];
    [alert show];
    
}
- (void)initializeDataWithTitle:(NSString *)title Message:(NSString *)seconTitle SureButtonTitle:(nullable NSString *)sureButtonTitle   otherButtonTitles:(NSArray <NSString *>*) otherButtonTitles{
    _contentInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    NSMutableDictionary *title_Dic = [NSMutableDictionary dictionary];
    [title_Dic setObject:title?title:@"" forKey:JLAlertViewTopTitle];
    [title_Dic setObject:seconTitle?seconTitle:@"" forKey:JLAlertViewSecondTitle];
    [title_Dic setObject:sureButtonTitle?sureButtonTitle:@"" forKey:JLAlertViewSureButton];
    [title_Dic setObject:otherButtonTitles?otherButtonTitles:@[] forKey:JLAlertViewOtherButtons];
    
    
    
    [self.contentDatas addObject:title_Dic];
    
    [self.btns removeAllObjects];
    
    [self creatBtn];
}
- (void)setUpViews{
    _mainView = [[UIView alloc]init];
    _mainView.clipsToBounds = YES;
    _mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _mainView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0f];
    _mainView.layer.cornerRadius = 10;
    
    _topTitleLabel = [[UILabel alloc]init];
    _topTitleLabel.backgroundColor = [UIColor clearColor];
    _topTitleLabel.numberOfLines = 1;
    //    [UIColor colorWithHexString:@"#333333"]
    _topTitleLabel.textColor = [UIColor blackColor];
    _topTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _secondDescription = [[UILabel alloc]init];
    _secondDescription.backgroundColor = [UIColor clearColor];
    _secondDescription.textColor = [UIColor blackColor];
    _secondDescription.numberOfLines = 0;
    _secondDescription.font = [UIFont systemFontOfSize:14.];
    _secondDescription.textAlignment = NSTextAlignmentLeft;
}
- (void)addButtonWithTitle:(nullable NSString *)title BtnColorStyle:(JLAlertViewBtnColor)btnColor{
    if (title && [title isEqualToString:@""] == NO) {
        UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [otherBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIColor *color = [UIColor colorWithRed:65/255.0 green:131/255.0 blue:1.0 alpha:1.0];
        if (btnColor == JLAlertViewBtnColorGray) {
            color = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        }
        [otherBtn setTitleColor:color forState:UIControlStateNormal];
        [otherBtn setTitle:title forState:UIControlStateNormal];
        otherBtn.backgroundColor = [UIColor whiteColor];
        [otherBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        if (self.contentDatas.count > 0)
        {
            NSDictionary *dic = self.contentDatas[0];
            NSString *sureBtn = dic[JLAlertViewSureButton];
            //如果有sureBtn,就与这个按钮交换,始终保持 sureBtn  在最大索引处
            if ([sureBtn isEqualToString:@""] == NO) {
                NSUInteger count;
                if (self.btns.count > 0) {
                    count = _btns.count - 1;
                }else {
                    count = 0;
                }
                [self.btns insertObject:otherBtn atIndex:count];
            }else {
                [self.btns addObject:otherBtn];
            }
        }
        
        [self initializeView];
    }
    
}

- (void)initializeView{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    
    if (!self.mainView.superview) {
        [self addSubview:self.mainView];
    }
    if (!_whiteBackView.superview) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.mainView addSubview:_whiteBackView];
    }
    
    if (!self.topTitleLabel.superview) {
        [self.mainView addSubview:self.topTitleLabel];
    }
    if (!self.secondDescription.superview) {
        [self.mainView addSubview:self.secondDescription];
    }
    
    __block typeof(self)weakSelf = self;
    [self.btns enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.superview) {
            [weakSelf.mainView addSubview:obj];
        }
    }];
}
- (void)creatBtn{
    if (self.contentDatas.count > 0)
    {
        NSDictionary *dic = self.contentDatas[0];
        NSArray *array = dic[JLAlertViewOtherButtons];
        
        NSString *str = dic[JLAlertViewSureButton];
        
        
        if (array && array.count > 0) {
            NSMutableArray *arr_m = [NSMutableArray arrayWithCapacity:array.count];
            [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
                [btn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:obj forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0] forState:UIControlStateNormal];
                [arr_m addObject:btn];
                
            }];
            
            [self.btns addObjectsFromArray:arr_m];
        }
        
        //只有主动传入 确认按钮标题.才会创建确认按钮
        if ([str isEqualToString:@""] == NO) {
            UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [sureBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [sureBtn setTitleColor:[UIColor colorWithRed:65/255.0 green:131/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            [sureBtn setTitle:str forState:UIControlStateNormal];
            sureBtn.backgroundColor = [UIColor whiteColor];
            [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [self.btns addObject:sureBtn];
        }
        
    }
    
    
}

- (void)layoutSubviews{
    _alert__BackGroundView.frame = [UIScreen mainScreen].bounds;
    _alert__BackGroundView.rootViewController.view.frame = [UIScreen mainScreen].bounds;
    [super layoutSubviews];
    
    if (self.contentDatas.count == 0) return;
    if (self.btns.count == 2) {
        _isDouble = YES;
    }
    CGSize screenSize = [JLAlertView currentScreenSize];
    CGFloat w = screenSize.width;
    CGFloat h = screenSize.height;
    
    _contentW = MIN(w, h) * 0.65;
    
    NSMutableDictionary *title_dic = self.contentDatas.firstObject;
    NSString *topStr = title_dic[JLAlertViewTopTitle];
    NSString *secondStr = title_dic[JLAlertViewSecondTitle];
    
    CGSize topSize = CGSizeZero;
    if (![topStr isEqualToString:@""]) {
        topSize = [self stringSizeStr:topStr Width:_contentW - 2*_contentInsets.left TopTitle:YES];
    }
    
    
    CGSize secondSize = CGSizeZero;
    if (![secondStr isEqualToString:@""]) {
        secondSize = [self stringSizeStr:secondStr Width:_contentW - 2*_contentInsets.left TopTitle:NO];
    }
    
    self.topTitleLabel.text = topStr;
    self.secondDescription.text = secondStr;
    
    self.topTitleLabel.frame = CGRectZero;
    if (![topStr isEqualToString:@""]) {
        self.topTitleLabel.frame = CGRectMake(_contentInsets.left, _contentInsets.top, _contentW - 2*_contentInsets.left, topSize.height);
    }
    
    self.secondDescription.frame = CGRectZero;
    if (![secondStr isEqualToString:@""]) {
        if (CGRectEqualToRect(CGRectZero, self.topTitleLabel.frame)) {
            self.secondDescription.frame = CGRectMake((_contentW - secondSize.width)/2 , CGRectGetMaxY(self.topTitleLabel.frame) + _contentInsets.top, secondSize.width, secondSize.height);
        }else {
            self.secondDescription.frame = CGRectMake((_contentW - secondSize.width)/2 , CGRectGetMaxY(self.topTitleLabel.frame) + _contentInsets.top/2, secondSize.width, secondSize.height);
        }
        
    }
    
    if (CGRectEqualToRect(CGRectZero, self.secondDescription.frame)) {
        self.secondDescription.frame = self.topTitleLabel.frame;
    }
    
    _whiteBackView.frame = CGRectMake(0, 0, _contentW, ceil(CGRectGetMaxY(self.secondDescription.frame))+_contentInsets.top);
    
    //    NSLog(@"%f",_whiteBackView.frame.size.height);
    __block typeof(self)weakSelf = self;
    __block UIView *preView;
    [self.btns enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (weakSelf.isDouble) {//两个按钮的情况
            CGFloat x = CGRectGetMaxX(preView.frame);
            
            obj.frame = CGRectMake(idx*JLALERT_SPLITE_H + x, floorf(CGRectGetMaxY(weakSelf.whiteBackView.frame))+JLALERT_SPLITE_H, [weakSelf cacluteBtnWWithContetn], JLALERT_BTN_H);
            //            NSLog(@"%lu--%f",idx,obj.frame.origin.y);
        }else {
            CGFloat y = CGRectGetMaxY(preView.frame);
            if (y == 0) {
                y = CGRectGetMaxY(weakSelf.whiteBackView.frame);
            }
            obj.frame = CGRectMake(0, y+JLALERT_SPLITE_H, [weakSelf cacluteBtnWWithContetn], JLALERT_BTN_H);
            [obj setNeedsLayout];
            //            NSLog(@"%lu--%f",idx,obj.frame.origin.y);
        }
        preView = obj;
        if (idx == weakSelf.btns.count-1) {
            weakSelf.sureBtn = (UIButton *)obj;
        }
    }];
    preView = nil;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        self.mainView.frame = CGRectMake((MAX(w, h)- _contentW)/2, (MIN(w, h)- CGRectGetMaxY(self.sureBtn.frame))/2, _contentW, CGRectGetMaxY(self.sureBtn.frame));
    }else {
        self.mainView.frame = CGRectMake((MIN(w, h)- _contentW)/2, (MAX(w, h)- CGRectGetMaxY(self.sureBtn.frame))/2, _contentW, CGRectGetMaxY(self.sureBtn.frame));
    }
    
}

- (CGFloat)cacluteBtnWWithContetn{
    NSUInteger count = self.btns.count;
    if (count != 2 && _isDouble == NO) {
        return _contentW;
    }else {
        return _contentW/2;
    }
}


- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)contentDatas{
    if (_contentDatas == nil) {
        _contentDatas = [NSMutableArray array];
    }
    return _contentDatas;
}
- (NSInteger)numberOfButtons{
    return self.btns.count;
}
#pragma mark click
- (void)cancleBtnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        
        NSUInteger index = [self.btns indexOfObject:sender];
        
        [self.delegate alertView:self clickedButtonAtIndex:index];
    }
    
    [self dismissWithClean:YES];
}

- (void)show{
    _oldKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    [JLAlertView getOldKeyWindow];
    
    if (![[JLAlertView allAlerts]containsObject:self]) {
        [[JLAlertView allAlerts] addObject:self];
    }
    
    if (self.isVisible) {
        return;
    }

    if ([JLAlertView currentAlertView].isVisible) {
        [self transitionOutCompletion:^{
            JLAlertView *alertView = [JLAlertView currentAlertView];
            [alertView dismissWithClean:NO];
        }];
        
        return;
    }
    
    [self showBackGround];
    
    if (self.associatedViewController == nil) {
        JLAlertViewController *viewController = [[JLAlertViewController alloc] initWithNibName:nil bundle:nil];
        viewController.alertView = self;
        viewController.rootViewControllerPrefersStatusBarHidden = JLAlertView_prefersStatusBarHidden;
        viewController.rootViewControllerCanRoration = JLAlertView_canrorate;
        viewController.rootViewControllerInterfaceOrientationMask = JLAlertView_InterfaceOrientationMask;
        
        JLAlertWindow *window = [[JLAlertWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController;
        self.associatedViewController = viewController;
        self.alertWindow = window;
    }
   
    [UIView animateWithDuration:0.3 animations:^{
//        _alertWindow.hidden = NO;
        _alertWindow.alpha = 1;
    }];
    [self.alertWindow makeKeyAndVisible];
//    [self initializeView];
    
    [self transitionInCompletion:^{
        
    }];
    
    self.visible = YES;
    [JLAlertView setCurrentAlertView:self];
    
}
// Transition
- (void)transitionInCompletion:(void(^)(void))completion
{
    _mainView.alpha = 0;
    _mainView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
//    _blurView.alpha = 0.9;
//    _blurView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _mainView.alpha = 1.;
                         _mainView.transform = CGAffineTransformMakeScale(1.0,1.0);
                         
//                         _blurView.alpha = 1.;
//                         _blurView.transform = CGAffineTransformMakeScale(1.0,1.0);
                     }
                     completion:^(BOOL finished) {
//                         [_blurView blur];
                         if (completion) {
                             completion();
                         }
                     }];
}
- (void)transitionOutCompletion:(void(^)(void))completion
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         _mainView.alpha = 0;
                         _mainView.transform = CGAffineTransformMakeScale(0.9,0.9);
                         
//                         _blurView.alpha = 0.9;
//                         _blurView.transform = CGAffineTransformMakeScale(0.9,0.9);
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }];
}
- (void)dismissWithClean:(BOOL)clean{
    
    
    self.visible = NO;
    [JLAlertView setCurrentAlertView:nil];
    [self tearDown:clean];
    
    JLAlertView *nextAlertView;
    NSInteger index = [[JLAlertView allAlerts] indexOfObject:self];
    if (index != NSNotFound && index < [JLAlertView allAlerts].count - 1) {
        nextAlertView = [JLAlertView allAlerts][index + 1];
    }
    
    if (clean) {
        if (self.superview) {
            [self removeFromSuperview];
        }
        [[JLAlertView allAlerts]removeObject:self];
        
    }
    
    if (nextAlertView) {
        [nextAlertView show];
        return;
    } else {
        // show last alert view
        if ([JLAlertView allAlerts].count > 0) {
            JLAlertView *alert = [[JLAlertView allAlerts] lastObject];
           
            [alert show];
            return;
        }
    }
    [_oldKeyWindow makeKeyAndVisible];
    _oldKeyWindow.hidden = NO;
}
- (void)dealloc{
    //    NSLog(@"JLAlertView -- dealloc");
}
+ (JLAlertView *)currentAlertView{
    return alert__currentAlertView;
}
+ (void)setCurrentAlertView:(JLAlertView *)alertView{
    alert__currentAlertView = alertView;
}
- (void)tearDown:(BOOL)clean{
    if (clean) {
        [_alertWindow removeFromSuperview];
        _alertWindow = nil;
        
        [_alert__BackGroundView removeFromSuperview];
        _alert__BackGroundView = nil;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
//            _alertWindow.hidden = YES;
            _alertWindow.alpha = 0;
            _alert__BackGroundView.alpha = 0;
        }];
    }
}
+ (UIWindow *)getBusinessWindow{
    return alert__oldKeyWindow;
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentViewController:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [self getCurrentViewController:svc.selectedViewController];
        else
            return vc;
        
    }
    else if ([vc isKindOfClass:[UISplitViewController class]])
    {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0){
            return [self getCurrentViewController:svc.viewControllers.lastObject];
        }
        
        else{
            return vc;
        }
        
    }
    else if ([vc isKindOfClass:[UINavigationController class]])
    {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [self getCurrentViewController:svc.topViewController];
        else
            return vc;
    }
    else if (vc.presentedViewController)
    {
        // Return visible view
        // Return presented view controller
        return [self getCurrentViewController:vc.presentedViewController];
    }
    else
    {
        // Unknown view controller type, return last child view controller
        return vc;
    }
    
}
+ (void)getOldKeyWindow{
    if (alert__oldKeyWindow == nil) {
        
        alert__oldKeyWindow = [UIApplication sharedApplication].keyWindow;
        NSLog(@"获取到业务window%@",alert__oldKeyWindow);
    }
    
}
- (void)showBackGround{
    if (_alert__BackGroundView == nil) {
        _alert__BackGroundView = [[JLAlertBackGroundWindow alloc]initWithFrame:CGRectMake(0, 0, [JLAlertView currentScreenSize].width, [JLAlertView currentScreenSize].height)];
        _alert__BackGroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        if ([[UIApplication sharedApplication].keyWindow.rootViewController respondsToSelector:@selector(prefersStatusBarHidden)]) {
            UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
            UIViewController *visibleVC = [JLAlertView getCurrentViewController:rootVc];
            JLAlertView_prefersStatusBarHidden = [visibleVC prefersStatusBarHidden];
            JLAlertView_canrorate = [visibleVC shouldAutorotate];
            JLAlertView_InterfaceOrientationMask = [visibleVC supportedInterfaceOrientations];
        }
        
    }
    _alert__BackGroundView.alpha = 0;
    [_alert__BackGroundView makeKeyAndVisible];
    [UIView animateWithDuration:0.3 animations:^{
        _alert__BackGroundView.alpha = 1;
    }];
}
+ (CGSize)currentScreenSize
{
    CGRect frame = [UIScreen mainScreen].bounds;

    CGFloat screenWidth = frame.size.width;
    CGFloat screenHeight = frame.size.height;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation) && ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
        CGFloat tmp = screenWidth;
        screenWidth = screenHeight;
        screenHeight = tmp;
    }
    
    return CGSizeMake(screenWidth, screenHeight);
}
+ (NSMutableArray *)allAlerts{
    if (alert__alertElement == nil) {
        alert__alertElement = [NSMutableArray array];
    }
    return alert__alertElement;
}
- (CGSize)stringSizeStr:(NSString *)str Width:(CGFloat)width TopTitle:(BOOL)isTopTitle{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *font = [UIFont systemFontOfSize:14.];
    if (isTopTitle) {
        font = [UIFont boldSystemFontOfSize:18];
    }
    
    
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    
    CGSize tempSize = [str boundingRectWithSize:CGSizeMake(width, 120) options:
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    tempSize = CGSizeMake(ceil(tempSize.width), ceil(tempSize.height));
    return tempSize;
}

@end
