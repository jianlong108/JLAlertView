//
//  JLAlertView.h
//  JLAlertView
//
//  Created by Wangjianlong on 2016/12/8.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLAlertView;

typedef NS_ENUM(NSInteger, JLAlertViewBtnColor) {
    JLAlertViewBtnColorGray = 0,//灰色文字
    JLAlertViewBtnColorBlue//蓝色文字
};

@protocol JLAlertViewDelegate <NSObject>

@optional

/**
 *  点击索引
 *
 *  @param alertView   alertView
 *  @param buttonIndex 确认按钮是最大的索引
 */
- (void)alertView:(JLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface JLAlertView : UIView

@property(nullable,nonatomic,weak) id<JLAlertViewDelegate> delegate;

@property(nonatomic,readonly) NSInteger numberOfButtons;

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate SureButtonTitle:(nullable NSString *)sureButtonTitle otherButtonTitles:(NSArray <NSString *>*) otherButtonTitles;

- (void)addButtonWithTitle:(nullable NSString *)title BtnColorStyle:(JLAlertViewBtnColor)btnColor;

- (void)show;

@end
