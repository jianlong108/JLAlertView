//
//  CXCustomKeyWindow.h
//  JLAlertView
//
//  Created by Wangjianlong on 2018/12/5.
//  Copyright © 2018 JL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CusKeyWindowRootViewController;
@class CustomKeyWindow;
typedef void(^CustomKeyWindowHandler)(CustomKeyWindow *alertView);

@interface CustomKeyWindow : UIView

@property (nonatomic, copy) CustomKeyWindowHandler willShowHandler;
@property (nonatomic, copy) CustomKeyWindowHandler didShowHandler;
@property (nonatomic, copy) CustomKeyWindowHandler willDismissHandler;
@property (nonatomic, copy) CustomKeyWindowHandler didDismissHandler;

@property (nonatomic, readonly, getter = isVisible) BOOL visible;

// AlertView action
- (void)show;
- (void)dismiss;
- (void)shake;
// Operation
- (void)cleanAllPenddingAlert;

- (CusKeyWindowRootViewController *)getKeyWindowRootViewController;

- (void)transitionInCompletion:(void(^)(void))completion;
- (void)transitionOutCompletion:(void(^)(void))completion;
- (void)validateLayout;

- (void)windowDidDisappear;

@end

NS_ASSUME_NONNULL_END
