//
//  JLAlertHeader.h
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/29.
//  Copyright © 2016年 JL. All rights reserved.
//

#ifndef JLAlertHeader_h
#define JLAlertHeader_h

#import "JLAlertBackGroundWindow.h"
#import "JLAlertView.h"


//按钮高度
#define JLALERT_BTN_H 46.0f

//分割线高度
#define JLALERT_SPLITE_H 0.5f

/**Debug打印*/
#if DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif



static NSString const * JLAlertViewTopTitle = @"JLAlertViewTopTitle";
static NSString const * JLAlertViewSecondTitle = @"JLAlertViewSecondTitle";
static NSString const * JLAlertViewSureButton = @"JLAlertViewSureButton";
static NSString const * JLAlertViewOtherButtons = @"JLAlertViewOtherButtons";
static NSMutableArray *alert__alertElement;
//static JLAlertBackGroundWindow *_alert__BackGroundView;
static JLAlertView *alert__currentAlertView;
static BOOL JLAlertView_prefersStatusBarHidden;
static BOOL JLAlertView_canrorate;
static UIInterfaceOrientationMask JLAlertView_InterfaceOrientationMask;

static UIWindow *alert__oldKeyWindow;



#endif /* JLAlertHeader_h */
