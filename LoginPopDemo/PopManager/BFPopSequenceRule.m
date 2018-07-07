//
//  BFPopSequenceRule.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFPopSequenceRule.h"
#import "BFPopRuleItem.h"
#import "BFAlertVC+PopRule.h"
#import "NSArray+ZXTool.h"

//PopViews all 业务view
#import "PopAuthResultView.h"

NSMutableArray *_sMArr;
NSInteger _needShowIndex;

@implementation BFPopSequenceRule

+ (void)load {
    [super load];
    [self makeRule];
}

+ (void)makeRule {
    _sMArr = @[].mutableCopy;
    _needShowIndex = 0;
    
    BFPopRuleItem *t1 = [self authPopItem];
    BFPopRuleItem *test = [self authPopItem];
    BFPopRuleItem *test2 = [self authPopItem];
    
    //finally
    [_sMArr addObjectsFromArray:@[t1,test,test2]];
    for (int i = 0; i < _sMArr.count; i ++) {
        BFPopRuleItem *preT = [_sMArr safeObjectAtIndex:i-1];
        BFPopRuleItem *t = _sMArr[i];
        t.popIndex = i;
        preT.next = t;
    }
}

#pragma mark - Public
+ (void)serialPut {
    for (BFPopRuleItem *t in _sMArr) {
        t.type = PutTypeSerial;
    }
    BFPopRuleItem *first = _sMArr.firstObject;
    if (first.request) {
        first.request(first, nil);
    }
}

+ (void)concurrentPut {
    for (BFPopRuleItem *t in _sMArr) {
        t.type = PutTypeConcurrent;
        if (t.request) {
            t.request(t, nil);
        }
    }
}

#pragma mark - Private

+ (void)clearData {
    _sMArr = nil;
    _needShowIndex = 0;
}

+ (void)prepareForNext {
    if (_needShowIndex < _sMArr.count -1) {
        _needShowIndex += 1;
    }
}

#pragma mark - Core

+ (BOOL)isIndexReadyForItem:(BFPopRuleItem *)item {
    if (item.popIndex != _needShowIndex) {
        return NO;
    }
    return YES;
}

+ (void)showCurPopView:(UIView *)view withItem:(BFPopRuleItem *)item {
    [ZXRouter showPopView:view withRule:item];
    if (item == _sMArr.lastObject) {
        [self clearData];
    }
}

#pragma mark - Getter 

+ (BFPopRuleItem *)authPopItem {
    //请求认证结果弹窗
    BFPopRuleItem *t = BFPopRuleItem.new;
    t.request = ^(BFPopRuleItem *item, id future) {
        //将结果保存 ..eg:
        NSString *uid = @"123";
        id httpResponse = uid;
        item.result = httpResponse;
    };
    t.curPut = ^(BFPopRuleItem *item, id result) {
        //根据结果决定 是否展示自己 || 展示下一个..eg:
        if ([result isEqualToString: @"123"] == NO) {
            [item putNext];
            return;
        }
        if ([self isIndexReadyForItem:item]) { //must call
            PopAuthResultView *v =  DVLLoadNib(@"PopAuthResultView");
            [self showCurPopView:v withItem:item];
        }
    };
    return t;
}

@end
