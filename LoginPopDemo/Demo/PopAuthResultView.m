//
//  PopAuthResultView.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "PopAuthResultView.h"
#import "BFAlertVC.h"

@implementation PopAuthResultView

- (CGRect)bf_alertContentFrameOnWindow {
    CGSize size = CGSizeMake(250, 300);
    CGPoint origin = CGPointMake((SCREEN_WIDTH - size.width)/2.0, (SCREEN_HEIGHT - size.height)/2.0);
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (AIAnimateType)bf_animateType  {
    return AIAnimateTypeDefault;
}

- (void)bf_backgroudViewDidShow:(UIView *)bgView {
    bgView.backgroundColor = DVLColorGenAlpha(@"#000000", 0.8);
}

- (IBAction)closeAction:(id)sender {
    [self dvl_dismissAlert];
}


@end
