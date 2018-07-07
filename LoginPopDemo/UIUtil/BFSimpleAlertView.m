//
//  BFSimpleAlertView.m
//  SuperFans
//
//  Created by ganyanchao on 2018/6/23.
//  Copyright © 2018 com.afander.finance. All rights reserved.
//

#import "BFSimpleAlertView.h"
#import "UIView+YYAdd.h"

@interface BFSimpleAlertView_BGView : UIView
@end

@implementation BFSimpleAlertView_BGView

- (instancetype)init {
    self = [self initWithFrame:ZXRouter.keyWindow.bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    }
    return self;
}

@end


@interface BFSimpleAlertView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSMutableArray *btns;

@end


@implementation BFSimpleAlertView

#pragma mark - Layout
- (void)configUI {
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.backgroundColor = UIColor.whiteColor;
    
    UILabel *titleLabel;
    if (self.title) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT(19);
        titleLabel.textColor = DVLColorGen(@"434d52");
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        titleLabel.text = self.title;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(21);
            make.centerX.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
    }
    
    UILabel *msgLabel;
    if (self.msg) {
        msgLabel = [[UILabel alloc] init];
        msgLabel.font = FONT(19);
        msgLabel.textColor = DVLColorGenAlpha(@"434d52", 0.7);
        msgLabel.textAlignment = NSTextAlignmentCenter;
        msgLabel.numberOfLines = 0;
        self.messageLabel = msgLabel;
        
        msgLabel.text = self.msg;
        [self addSubview:msgLabel];
        [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(35);
            make.right.equalTo(self).offset(-35);
            make.top.equalTo(titleLabel?titleLabel.mas_bottom:self).offset(21);
            make.height.greaterThanOrEqualTo(20);
        }];
    }
    
    UIView *anchorTop = msgLabel?:(titleLabel?:self);
    UIView *lineH = [[UIView alloc] init];
    lineH.backgroundColor = DVLColorGen(@"f2f7f7");
    [self addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(anchorTop.mas_bottom).offset(21);
        make.height.equalTo(1);
    }];
    
    if (self.btns.count == 0) {
        [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-21);
        }];
    }
    else if (self.btns.count == 1) {
        RIButtonItem *it = [self.btns safeObjectAtIndex:0];
        UIButton *btn = [self btnWithMsg:it.label color:DVLColorGen(@"434d52") tag:0];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(lineH);
            make.height.equalTo(44);
            make.bottom.equalTo(self);
        }];
    }
    else if (self.btns.count == 2) {
        
        RIButtonItem *it = [self.btns safeObjectAtIndex:0];
        UIButton *btn = [self btnWithMsg:it.label color:DVLColorGenAlpha(@"434d52", 0.7) tag:0];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(lineH);
            make.height.equalTo(44);
            make.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        
        RIButtonItem *it_1 = [self.btns safeObjectAtIndex:1];
        UIButton *btn_1 = [self btnWithMsg:it_1.label color:DVLColorGenAlpha(@"434d52", 1.0) tag:1];
        [self addSubview:btn_1];
        [btn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btn.mas_right);
            make.top.equalTo(lineH);
            make.height.equalTo(btn);
            make.bottom.right.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        
        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = DVLColorGen(@"f2f7f7");
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(lineH.mas_bottom);
            make.width.equalTo(1);
            make.bottom.equalTo(self);
        }];
    }
    else {
        RIButtonItem *it;
        UIButton *btn;
        UIColor *color;
        UIButton *lastBtn;
        NSInteger count = self.btns.count;
        for (int i = 0; i < count; i++) {
            it = [self.btns safeObjectAtIndex:0];
            if (!color) {
                color = DVLColorGenAlpha(@"#434d52", 0.7);
            }
            if (i == count -1) {
                color = DVLColorGen(@"ff6b46");
            }
            btn = [self btnWithMsg:it.label color:color tag:i];
            
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(lastBtn?lastBtn.mas_bottom:lineH.mas_bottom);
                make.height.equalTo(44);
            }];
            lastBtn = btn;
        }
        
        [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
    }
    
    [self bringSubviewToFront:lineH];

    for (RIButtonItem *it in self.btns) {
        if (it.showStyle) {
            it.showStyle(it);
        }
    }
}


- (UIButton *)btnWithMsg:(NSString *)msg
                   color:(UIColor *)color
                     tag:(NSInteger)index {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:msg forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(16);
    btn.tag = index;
    [btn removeTarget:self action:@selector(onTapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(onTapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    RIButtonItem *it = [self.btns safeObjectAtIndex:index];
    it.button = btn;
    
    return btn;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self.messageLabel setNeedsLayout];
    [self.messageLabel layoutIfNeeded];
    self.messageLabel.preferredMaxLayoutWidth = self.messageLabel.width;
    _messageLabel.font = FONT(14);
}

#pragma mark - Public

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg {
    BFSimpleAlertView *av = BFSimpleAlertView.alloc.init;
    av.title = title;
    av.msg = msg;
    return av;
}

- (void)addButtonWithText:(NSString *)text
               clickBlock:(void(^)(void))block {
    [self addButtonWithText:text clickBlock:block finalStyle:nil];
}

- (void)addButtonWithText:(NSString *)text
               clickBlock:(void(^)(void))block
               finalStyle:(void(^)(RIButtonItem *style))style {
    
    if ([NSString isEmpty:text]) {
        return;
    }
    RIButtonItem *it = [RIButtonItem itemWithLabel:text action:block];
    it.showStyle = style;
    [self.btns addObject:it];
}

- (void)show {
    [self configUI];
    
    BFSimpleAlertView_BGView *bv = [[BFSimpleAlertView_BGView alloc] init];
    [bv addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bv);
        make.width.equalTo(270);
    }];
    [ZXRouter.keyWindow addSubview:bv];
    [self.layer addAnimation:[self popAnimate] forKey:@"animate"];
}

- (void)dismiss {
    [self.superview removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark - Action
- (void)onTapBtnAction:(UIButton *)btn {
    RIButtonItem *it = [self.btns safeObjectAtIndex:btn.tag];
    [self dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (it.action) {
            it.action();
        }
    });
}

#pragma mark - Helper
- (CAKeyframeAnimation *)popAnimate {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return popAnimation;
}

#pragma mark - Getter
- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
