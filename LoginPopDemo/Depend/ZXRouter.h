
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXRouter : NSObject

+ (UIWindow *)keyWindow;

+ (UIViewController *)curViewController;

//默认弹出方式： UIModalPresentationOverFullScreen
+ (void)presentController:(UIViewController *)controller animated:(BOOL)ani;

//自己控制弹出方式
+ (void)presentController:(UIViewController *)controller
   modalPresentationStyle:(UIModalPresentationStyle)style
                 animated:(BOOL)animated;

/**< 以模态弹窗的方式弹出 小方框
 @see: BFAlertVC
 */
+ (void)showAlertVc:(UIViewController *)vc;
+ (void)showAlertView:(UIView *)view;



@end
