//
//  BFPopSequenceRule.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFPopSequenceRule.h"
#import "BFAlertVC+PopRule.h"

//PopViews all 登陆pop业务view
#import "PopAuthResultView.h"


@implementation BFPopSequenceRule

+ (void)load {
    [self clearData];
}

//MARK: Public
+ (void)addRule:(BFPopRuleItem *)item {
    NSAssert(item.request != nil, @"item request must not nil");
    NSAssert(item.curPut != nil, @"item curPut must not nil");
    
    BOOL concurrent = [self isConcurrent];
    if (concurrent) {
        item.type = PutTypeConcurrent;
    } else {
        item.type = PutTypeSerial;
    }
    if ([NSArray isEmpty:_sMArr] == NO) {
        BFPopRuleItem *last = _sMArr.lastObject;
        last.next = item;
        [_sMArr addObject:item];
        if (concurrent) {
            item.request(item, nil);
        }
    }
    else {
        [_sMArr addObject:item];
        _needShowIndex = item;
        item.request(item, nil);
    }
}

+ (BOOL)isConcurrent {
    return YES; //YES 并发，NO 串行
}

@end


@implementation BFPopSequenceRule (LoginScene)

+ (void)popLoginScene {
    //demo
    BFPopRuleItem *auth = [self authPopItem];
    [self addRule:auth];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addRule:[self authPopItem]];
    });
}

+ (BFPopRuleItem *)authPopItem {
    //请求认证结果弹窗
    BFPopRuleItem *t = BFPopRuleItem.new;
    t.request = ^(BFPopRuleItem *item, id future) {
        //mock a request 将结果保存 ..eg:
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDictionary *response = @{@"code":@(0)};
            item.result = response;
        });
    };
    
    t.curPut = ^UIView *(BFPopRuleItem *item, id result) {
        if ([[result objectForKey:@"code"] isEqual:@(0)] == NO) {
            return nil;
        }
        PopAuthResultView *v = DVLLoadNib(@"PopAuthResultView");
        v.result = result;
        return v;
    };
    return t;
}

@end
