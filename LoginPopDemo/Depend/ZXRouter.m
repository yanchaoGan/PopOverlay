
#import "ZXRouter.h"

@interface ZXRouter()
@property (nonatomic, weak) UIViewController *navigator;
@end

@implementation ZXRouter

- (UIViewController *)navigator {
    if (!_navigator) {
        _navigator = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
    return _navigator;
}

+ (instancetype)sharedInstance
{
    static ZXRouter *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self class] new];
    });
    return _sharedInstance;
}

+ (UIViewController *)curViewController
{
    UIViewController *topViewController = [self topViewController];
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        topViewController = [(UINavigationController *)topViewController topViewController];
    }
    return topViewController;
}


+ (UIViewController *)topViewController
{
    UIViewController *rootNavigator = [ZXRouter sharedInstance].navigator;
    UIViewController *presentController = rootNavigator;
    while (presentController.presentedViewController)
    {
        presentController = presentController.presentedViewController;
    }
    return presentController;
}



+ (UIWindow *)keyWindow {
    return UIApplication.sharedApplication.delegate.window;
}

+ (void)presentController:(UIViewController *)controller animated:(BOOL)animated {
    [self presentController:controller modalPresentationStyle:UIModalPresentationOverFullScreen animated:animated];
}

+ (void)presentController:(UIViewController *)controller
   modalPresentationStyle:(UIModalPresentationStyle)style
                 animated:(BOOL)animated {
    if (!controller) {
        return;
    }
    UIViewController *presentController = [self topViewController];
    if (![controller isKindOfClass:[UINavigationController class]]) {
        controller = [[UINavigationController alloc] initWithRootViewController:controller];
        [(UINavigationController *)controller setNavigationBarHidden:YES];
    }
    controller.modalPresentationStyle = style;//UIModalPresentationOverFullScreen;
    controller.modalPresentationCapturesStatusBarAppearance = YES;
    [presentController presentViewController:controller animated:animated completion:nil];
}


+ (void)showAlertVc:(UIViewController *)vc {
    BFAlertVC *alertVc = [[BFAlertVC alloc] init];
    alertVc.alertContent = vc;
    [self presentController:alertVc animated:NO];
}

+ (void)showAlertView:(UIView *)view {
    BFAlertVC *alertVc = [[BFAlertVC alloc] init];
    alertVc.alertContent = view;
    [self presentController:alertVc animated:NO];
}


@end
