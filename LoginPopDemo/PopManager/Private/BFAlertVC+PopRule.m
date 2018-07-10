//
//  BFAlertVC+PopRule.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFAlertVC+PopRule.h"
#import "BFPopRuleItem.h"

NSMutableArray *_sMArr;
BFPopRuleItem * _needShowIndex;

@implementation BFPopSequenceRule (Private)

+ (void)clearData {
    _sMArr = @[].mutableCopy;
    _needShowIndex = nil;
}

+ (void)prepareForNext {
    id cur = _needShowIndex;
    [_sMArr removeObject:cur];
    _needShowIndex = _needShowIndex.next;
}

//MARK: Core
+ (BOOL)isIndexReadyForItem:(BFPopRuleItem *)item {
    if (item != _needShowIndex) {
        return NO;
    }
    return YES;
}

+ (void)showCurPopView:(UIView *)view withItem:(BFPopRuleItem *)item {
    [ZXRouter showPopView:view withRule:item];
}

@end


@implementation BFPopRuleItem (Private)

bf_strong_implement(BFPopRuleItem *, next)
bf_assign_implement(int, type)

- (void)putCurrent {
    //are you ok
    BOOL indexReady = [BFPopSequenceRule isIndexReadyForItem:self];
    if (indexReady == NO) {
        return;
    }
    if (self.curPut) {
        UIView *v = self.curPut(self, self.result);
        if (v == nil) {
            [self putNext];
        }
        else {
            [BFPopSequenceRule showCurPopView:v withItem:self];
        }
    }
}

- (void)putNext {
    BFPopRuleItem *nt = self.next;
    [BFPopSequenceRule prepareForNext];
    
    if (self.type == PutTypeSerial) {
        if (nt.request) {
            nt.request(nt, nil);
        }
    }
    else if (self.type == PutTypeConcurrent) {
        if (nt.result) {
            [nt putCurrent];
        }
    }
}

@end


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
