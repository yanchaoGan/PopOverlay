//
//  BFAlertVC.h
//  SuperFans
//
//  Created by ganyanchao on 2018/6/13.
//  Copyright © 2018 com.afander.finance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AIAnimateType) {
    AIAnimateTypeNone = -1, //没有动画
    AIAnimateTypeDefault, //0 默认心跳 动画
};

//obj tell alert Vc something
@protocol AlertDataSource <NSObject>

@optional
- (UIView *)view; /**< alert content.  presume VC*/

- (CGRect)bf_alertContentFrameOnWindow;

- (AIAnimateType)bf_animateType;

/**
 点击背景是否自动消失。 默认不消失
 */
- (BOOL)bf_enableAutoDissmiss;

@end

//aler vc tell obj something
@protocol AlertFeedBackInterface <NSObject>

@optional

/**< 弹窗要显示了。 针对需要处理背景层view的*/
- (void)bf_backgroudViewDidShow:(UIView *)bgView;

/**< alert dismiss 了*/
- (void)bf_alertDidClose;

@end


@interface BFAlertVC : UIViewController

@property (nonatomic, strong) id<AlertDataSource, AlertFeedBackInterface> alertContent;

@end


@interface NSObject (bf_alert)

/**< 自己希望弹窗消失的话，主动调用 . 动画时间需要 0.1 s */
- (void)dvl_dismissAlert;

//在动画消失之后执行 动画时间需要 0.1 s
// block copy
- (void)dvl_dismissAlertComplete:(dispatch_block_t)block;

/**< 获取弹窗容器*/
- (BFAlertVC *)bf_alertContainer;

@end
