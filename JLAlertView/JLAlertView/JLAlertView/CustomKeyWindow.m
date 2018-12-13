//
//  CXCustomKeyWindow.m
//  JLAlertView
//
//  Created by Wangjianlong on 2018/12/5.
//  Copyright © 2018 JL. All rights reserved.
//

#import "CustomKeyWindow.h"
#import "CusKeyWindowRootViewController.h"

@class CustomKeyWindowBackgroundWindow;

static NSMutableArray *__customKeyWindow_custom_key_window_queue;
static BOOL __customKeyWindow_key_window_animating;
static CustomKeyWindowBackgroundWindow *__customKeyWindow_key_background_window;
static CustomKeyWindow *__customKeyWindow_key_window_current_view;
static BOOL __customKeyWindow_rootViewController_prefersStatusBarHidden;

@interface CustomKeyWindowTempViewController : UIViewController

@end

@implementation CustomKeyWindowTempViewController

- (BOOL)prefersStatusBarHidden
{
    return __customKeyWindow_rootViewController_prefersStatusBarHidden;
}

@end

@interface CustomKeyWindowBackgroundWindow : UIWindow

@end

@implementation CustomKeyWindowBackgroundWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        self.windowLevel = UIWindowLevelAlert - 1;
        self.rootViewController = [[CustomKeyWindowTempViewController alloc] init];
        self.rootViewController.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0.5] set];
    CGContextFillRect(context, self.bounds);
}

@end

@interface CustomKeyWindow()

@property (nonatomic, strong) UIWindow *oldKeyWindow;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, assign, getter = isVisible) BOOL visible;

+ (NSMutableArray *)sharedQueue;
+ (CustomKeyWindow *)currentAlertView;

+ (BOOL)isAnimating;
+ (void)setAnimating:(BOOL)animating;

+ (void)showBackground;
+ (void)hideBackgroundAnimated:(BOOL)animated;

@end

@implementation CustomKeyWindow

#pragma mark - interface

// AlertView action
- (void)show
{
    self.oldKeyWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (![[CustomKeyWindow sharedQueue] containsObject:self]) {
        [[CustomKeyWindow sharedQueue] addObject:self];
    }
    
    if ([CustomKeyWindow isAnimating]) {
        return; // wait for next turn
    }
    
    if (self.isVisible) {
        return;
    }
    
    if ([CustomKeyWindow currentAlertView].isVisible) {
        CustomKeyWindow *alert = [CustomKeyWindow currentAlertView];
        [alert dismissWithCleanup:NO];
        return;
    }
    
    if (self.willShowHandler) {
        self.willShowHandler(self);
    }
    
    self.visible = YES;
    
    [CustomKeyWindow setAnimating:YES];
    [CustomKeyWindow setCurrentAlertView:self];
    
    // transition background
    [CustomKeyWindow showBackground];
    
    CusKeyWindowRootViewController *viewController = [self getKeyWindowRootViewController];

    if ([self.oldKeyWindow.rootViewController respondsToSelector:@selector(prefersStatusBarHidden)]) {
        viewController.rootViewControllerPrefersStatusBarHidden = self.oldKeyWindow.rootViewController.prefersStatusBarHidden;
        __customKeyWindow_rootViewController_prefersStatusBarHidden = self.oldKeyWindow.rootViewController.prefersStatusBarHidden;
    }
    
    if (!self.alertWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController;
        self.alertWindow = window;
    }
    [self.alertWindow makeKeyAndVisible];
    [self validateLayout];
    
    [self transitionInCompletion:^{
        if (self.didShowHandler) {
            self.didShowHandler(self);
        }
        
        [CustomKeyWindow setAnimating:NO];
        
        NSInteger index = [[CustomKeyWindow sharedQueue] indexOfObject:self];
        if (index < [CustomKeyWindow sharedQueue].count - 1) {
            [self dismissWithCleanup:NO]; // dismiss to show next alert view
        }
    }];
}

- (void)validateLayout
{
    
}

- (void)dismiss
{
    [self dismissWithCleanup:YES];
}

- (CusKeyWindowRootViewController *)getKeyWindowRootViewController
{
    return [[CusKeyWindowRootViewController alloc]initWithCustomKeyWindow:self];
}

- (void)windowDidDisappear
{
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
}

- (void)shake
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.duration = 0.1;
    animation.repeatCount = 3;
    animation.autoreverses = YES;
    //    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:10.0];
    [self.layer removeAllAnimations];
    [self.layer addAnimation:animation forKey:@"transform.translation.x"];
    
}
// Operation
- (void)cleanAllPenddingAlert
{
    [[CustomKeyWindow sharedQueue] removeAllObjects];
}

#pragma mark - CXAlertView PV
+ (NSMutableArray *)sharedQueue
{
    if (!__customKeyWindow_custom_key_window_queue) {
        __customKeyWindow_custom_key_window_queue = [NSMutableArray array];
    }
    return __customKeyWindow_custom_key_window_queue;
}

+ (CustomKeyWindow *)currentAlertView
{
    return __customKeyWindow_key_window_current_view;
}

+ (void)setCurrentAlertView:(CustomKeyWindow *)alertView
{
    __customKeyWindow_key_window_current_view = alertView;
}

+ (BOOL)isAnimating
{
    return __customKeyWindow_key_window_animating;
}

+ (void)setAnimating:(BOOL)animating
{
    __customKeyWindow_key_window_animating = animating;
}

+ (void)showBackground
{
    if (!__customKeyWindow_key_background_window) {
        
        CGSize screenSize = [self currentScreenSize];
        
        __customKeyWindow_key_background_window = [[CustomKeyWindowBackgroundWindow alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    }
    
    [__customKeyWindow_key_background_window makeKeyAndVisible];
    __customKeyWindow_key_background_window.alpha = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         __customKeyWindow_key_background_window.alpha = 1;
                     }];
}

+ (CGSize)currentScreenSize
{
    CGRect frame;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]) {
        frame = [UIScreen mainScreen].nativeBounds;
    }
    else {
        frame = [UIScreen mainScreen].bounds;
    }
#else
    frame = [UIScreen mainScreen].bounds;
#endif
    
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


+ (void)hideBackgroundAnimated:(BOOL)animated
{
    if (!animated) {
        [__customKeyWindow_key_background_window removeFromSuperview];
        __customKeyWindow_key_background_window = nil;
        return;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         __customKeyWindow_key_background_window.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [__customKeyWindow_key_background_window removeFromSuperview];
                         __customKeyWindow_key_background_window = nil;
                     }];
}

- (void)dismissWithCleanup:(BOOL)cleanup
{
    BOOL isVisible = self.isVisible;
    
    if (isVisible) {
        if (self.willDismissHandler) {
            self.willDismissHandler(self);
        }
    }
    
    void (^dismissComplete)(void) = ^{
        self.visible = NO;
        [self windowDidDisappear];
        
        [CustomKeyWindow setCurrentAlertView:nil];
        
        // show next alertView
        CustomKeyWindow *nextAlertView;
        NSInteger index = [[CustomKeyWindow sharedQueue] indexOfObject:self];
        if (index != NSNotFound && index < [CustomKeyWindow sharedQueue].count - 1) {
            nextAlertView = [CustomKeyWindow sharedQueue][index + 1];
        }
        
        if (cleanup) {
            [[CustomKeyWindow sharedQueue] removeObject:self];
        }
        
        [CustomKeyWindow setAnimating:NO];
        
        if (isVisible) {
            if (self.didDismissHandler) {
                self.didDismissHandler(self);
            }
        }
        
        // check if we should show next alert
        if (!isVisible) {
            return;
        }
        
        if (nextAlertView) {
            [nextAlertView show];
        } else {
            // show last alert view
            if ([CustomKeyWindow sharedQueue].count > 0) {
                CustomKeyWindow *alert = [[CustomKeyWindow sharedQueue] lastObject];
                [alert show];
            }
        }
    };
    
    if (isVisible) {
        [CustomKeyWindow setAnimating:YES];
        [self transitionOutCompletion:dismissComplete];
        
        if ([CustomKeyWindow sharedQueue].count == 1) {
            [CustomKeyWindow hideBackgroundAnimated:YES];
        }
        
    } else {
        dismissComplete();
        
        if ([CustomKeyWindow sharedQueue].count == 0) {
            [CustomKeyWindow hideBackgroundAnimated:YES];
        }
    }
    
    [_oldKeyWindow makeKeyWindow];
    _oldKeyWindow.hidden = NO;
}
// Transition
- (void)transitionInCompletion:(void(^)(void))completion
{
//    _containerView.alpha = 0;
//    _containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
//
//    _blurView.alpha = 0.9;
//    _blurView.transform = CGAffineTransformMakeScale(1.2, 1.2);
//
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         _containerView.alpha = 1.;
//                         _containerView.transform = CGAffineTransformMakeScale(1.0,1.0);
//
//                         _blurView.alpha = 1.;
//                         _blurView.transform = CGAffineTransformMakeScale(1.0,1.0);
//                     }
//                     completion:^(BOOL finished) {
//                         [_blurView blur];
//                         if (completion) {
//                             completion();
//                         }
//                     }];
}

- (void)transitionOutCompletion:(void(^)(void))completion
{
//    [UIView animateWithDuration:0.25
//                     animations:^{
//                         _containerView.alpha = 0;
//                         _containerView.transform = CGAffineTransformMakeScale(0.9,0.9);
//
//                         _blurView.alpha = 0.9;
//                         _blurView.transform = CGAffineTransformMakeScale(0.9,0.9);
//                     }
//                     completion:^(BOOL finished) {
//                         if (completion) {
//                             completion();
//                         }
//                     }];
}
@end
