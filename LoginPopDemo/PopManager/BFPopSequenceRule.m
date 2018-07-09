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
BFPopRuleItem *_needShowIndex;

@implementation BFPopSequenceRule

+ (void)load {
    [super load];
    [self makeRule];
}

+ (void)makeRule {
    _sMArr = @[].mutableCopy;
    _needShowIndex = nil;
    
    BFPopRuleItem *t1 = [self authPopItem];
    BFPopRuleItem *test = [self authPopItem];
    BFPopRuleItem *test2 = [self authPopItem];
    
    //finally
    [_sMArr addObjectsFromArray:@[t1,test,test2]];
    for (int i = 0; i < _sMArr.count; i ++) {
        BFPopRuleItem *preT = [_sMArr safeObjectAtIndex:i-1];
        BFPopRuleItem *t = _sMArr[i];
        preT.next = t;
    }
    _needShowIndex = _sMArr.firstObject;
}

#pragma mark - Public
+ (void)serialPut {
    for (BFPopRuleItem *t in _sMArr) {
        t.type = PutTypeSerial;
    }
    BFPopRuleItem *first = _sMArr.firstObject;
    //NS_BLOCK_ASSERTIONS :release 下阻止 assert 生效
    NSAssert(first.request != nil, @"request handle must not nil");
    first.request(first, nil);
}

+ (void)concurrentPut {
    for (BFPopRuleItem *t in _sMArr) {
        t.type = PutTypeConcurrent;
        NSAssert(t.request != nil, @"request handle must not nil");
        t.request(t, nil);
    }
}

#pragma mark - Private

+ (void)clearData {
    _sMArr = nil;
    _needShowIndex = nil;
}

+ (void)prepareForNext {
    _needShowIndex = _needShowIndex.next;
}

#pragma mark - Core

+ (BOOL)isIndexReadyForItem:(BFPopRuleItem *)item {
    if (item != _needShowIndex) {
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
        //将请求结果保存 ..eg:
        //send a http request then save response to item in main thread
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
