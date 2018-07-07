//
//  BFAlertVC+PopRule.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFAlertVC+PopRule.h"
#import "BFPopRuleItem.h"

@interface AlertVCDealloc : NSObject
@property (nonatomic, strong) BFPopRuleItem *ruleItem;
@end

@implementation AlertVCDealloc
- (void)dealloc {
    [self.ruleItem putNext];
}
@end


@interface BFAlertVC (PopRule)
@bf_strong_property(AlertVCDealloc *, popDealloc);
@end

@implementation BFAlertVC (PopRule)
bf_strong_implement(AlertVCDealloc *, popDealloc);
@end


@implementation ZXRouter (PopRule)

+ (void)showPopView:(UIView *)view withRule:(BFPopRuleItem *)item {
    
    BFAlertVC *alertVc = [[BFAlertVC alloc] init];
    alertVc.alertContent = view;
    
    AlertVCDealloc *ad = AlertVCDealloc.new;
    ad.ruleItem = item;
    alertVc.popDealloc = ad;
    
    [self presentController:alertVc animated:NO];
}


@end
