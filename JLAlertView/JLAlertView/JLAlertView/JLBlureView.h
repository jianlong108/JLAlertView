//
//  JLBlureView.h
//  JLAlertView
//
//  Created by Wangjianlong on 2017/2/23.
//  Copyright © 2017年 JL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLBlureView : UIView

@property (nonatomic, weak) UIView *backgroundView;

- (void)blur;

@end
