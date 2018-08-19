//
//  BFSimpleAlertView.h
//  SuperFans
//
//  Created by ganyanchao on 2018/6/23.
//  Copyright © 2018 com.afander.finance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"


/**
 系统alert 替代
 */
@interface BFSimpleAlertView : UIView

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;


- (void)addButtonWithText:(NSString *)text
               clickBlock:(void(^)(void))block;
- (void)addButtonWithText:(NSString *)text
                     clickBlock:(void(^)(void))block
                finalStyle:(void(^)(RIButtonItem *style))style;

- (void)show;
- (void)dismiss;

@end
