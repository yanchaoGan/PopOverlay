//
//  BFAlertVC.m
//  SuperFans
//
//  Created by ganyanchao on 2018/6/13.
//  Copyright © 2018 com.afander.finance. All rights reserved.
//

#import "BFAlertVC.h"
#import "ZXRouter.h"

@interface BFAlertVC ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *bgBtn;

@property (nonatomic, copy) dispatch_block_t completeBlock;

@end

@implementation BFAlertVC

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [UIApplication sharedApplication].statusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initUI];
    [self _showAnimate];
    
    if ([self.alertContent respondsToSelector:@selector(bf_backgroudViewDidShow:)]) {
        [self.alertContent bf_backgroudViewDidShow:self.bgView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (!self.contentView.superview) {
        [self _initContentView];
    }
}

- (void)_initContentView {
    //mark add child
    if ([self.alertContent isKindOfClass:[UIViewController class]]) {
        [self addChildViewController:self.alertContent];
    }
    //mark add sub view
    UIView *contentView = nil;
    if ([self.alertContent respondsToSelector:@selector(view)]) {
        contentView = self.alertContent.view;
    }
    else if ([self.alertContent isKindOfClass:[UIView class]]) {
        contentView = (UIView *)self.alertContent;
    }
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    //if yout want not corner, please change your content view
    contentView.layer.cornerRadius = 5;
    
    //mark adjust frame
    CGRect frame = CGRectZero;
    if ([self.alertContent respondsToSelector:@selector(bf_alertContentFrameOnWindow)]) {
        frame = self.alertContent.bf_alertContentFrameOnWindow;
    }
    else {
        CGSize size = CGSizeMake(200, 200);
        CGPoint origin = CGPointMake((SCREEN_WIDTH - size.width)/2.0, (SCREEN_HEIGHT - size.height)/2.0);
        frame = CGRectMake(origin.x, origin.y, size.width, size.height);
    }
    contentView.frame = frame;
}

- (void)_initUI {
    [self.view addSubview:self.bgView];
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.bgBtn];
}

#pragma mark - Action
- (void)onBgBtnAction:(UIButton *)btn {
    BOOL enable = NO;
    if ([self.alertContent respondsToSelector:@selector(bf_enableAutoDissmiss)]) {
        enable = [self.alertContent bf_enableAutoDissmiss];
    }
    if (enable) {
        [self closeViewTapAction];
    }
}

- (void)closeViewTapAction {
    if (self.animateType == AIAnimateTypeDefault) {
        [self _disAnimate];
    }
    else {
        [self r_close];
    }
}

- (void)r_close {
    [self.contentView removeFromSuperview];
    [self dismissViewControllerAnimated:NO completion:self.completeBlock?:nil];
    
    if ([self.alertContent respondsToSelector:@selector(bf_alertClose)]) {
        [self.alertContent bf_alertDidClose];
    }
}


#pragma mark - Animate
- (void)_showAnimate {
    AIAnimateType type = [self animateType];
    if (type == AIAnimateTypeDefault) {
        [self heart_show];
    }
}

- (void)_disAnimate {
    AIAnimateType type = [self animateType];
    if (type == AIAnimateTypeDefault) {
        [self heart_dissmiss];
    }
}

#pragma mark - 心跳动画
- (void)heart_show {
    CABasicAnimation *pulseAnimation = [self heartAnimate:1.1 duration:0.15];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.delegate = self;
    [pulseAnimation setValue:@"show" forKey:@"animate"];
    [self.contentView.layer addAnimation:pulseAnimation forKey:@"animate"];
}

- (void)heart_dissmiss {
    CABasicAnimation *pulseAnimation = [self heartAnimate:0.8 duration:0.1];
    pulseAnimation.delegate = self;
    pulseAnimation.removedOnCompletion = NO;
    pulseAnimation.fillMode = kCAFillModeForwards;
    [pulseAnimation setValue:@"dismiss" forKey:@"animate"];
    [self.contentView.layer addAnimation:pulseAnimation forKey:@"animate"];
}


#pragma mark - Helper
- (CABasicAnimation *)heartAnimate:(CGFloat)size duration:(CGFloat)time {
    float bigSize = size;
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = time;
    pulseAnimation.toValue = [NSNumber numberWithFloat:bigSize];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return pulseAnimation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id v = [anim valueForKey:@"animate"];
    if ([v isEqualToString:@"dismiss"]) {
        [self r_close];
    }
    [self.contentView.layer removeAllAnimations];
}

- (AIAnimateType)animateType {
    AIAnimateType at = AIAnimateTypeDefault;
    if ([self.alertContent respondsToSelector:@selector(bf_animateType)]) {
        at = [self.alertContent bf_animateType];
    }
    return at;
}

#pragma mark - Getter

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor colorFromString:@"#000000" alpha:0.5];
        _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _bgView;
}

- (UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        [_bgBtn addTarget:self action:@selector(onBgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

@end


@implementation NSObject (bf_alert)

- (void)dvl_dismissAlert {
    [self dvl_dismissAlertComplete:nil];
}

- (void)dvl_dismissAlertComplete:(dispatch_block_t)block {
    BFAlertVC *avc = self.bf_alertContainer;
    avc.completeBlock = block;
    [self.bf_alertContainer closeViewTapAction];
}

/**< 获取弹窗容器*/
- (BFAlertVC *)bf_alertContainer {
    UIViewController *avc = nil;
    if ([self isKindOfClass:[UIView class]]) {
        UIViewController *vc = [(UIView *)self viewController];
        if ([vc isKindOfClass:[BFAlertVC class]]) {
            avc = vc;
        }
    }
    else if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = [(UIViewController *)self parentViewController];
        if ([vc isKindOfClass:[BFAlertVC class]]) {
            avc = vc;
        }
    }
    else {
        UIViewController *vc = [ZXRouter curViewController];
        if ([vc isKindOfClass:[BFAlertVC class]]) {
            avc = vc;
        }
    }
    return avc;
}

@end
