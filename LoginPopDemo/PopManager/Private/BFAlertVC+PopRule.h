//
//  BFAlertVC+PopRule.h
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFAlertVC.h"
#import "BFPopSequenceRule.h"

@class BFPopRuleItem;

@interface BFPopSequenceRule (Private)

+ (void)clearData;
+ (void)prepareForNext;

+ (BOOL)isIndexReadyForItem:(BFPopRuleItem *)item;
+ (void)showCurPopView:(UIView *)view withItem:(BFPopRuleItem *)item;

@end

typedef NS_ENUM(NSInteger, PutType) {
    PutTypeSerial,
    PutTypeConcurrent,
};

@interface BFPopRuleItem (Private)

@bf_strong_property(BFPopRuleItem *, next);
@bf_assign_property(int, type);

- (void)putCurrent;
- (void)putNext;

@end


@interface ZXRouter (PopRule)

+ (void)showPopView:(UIView *)view withRule:(BFPopRuleItem *)item;

@end
