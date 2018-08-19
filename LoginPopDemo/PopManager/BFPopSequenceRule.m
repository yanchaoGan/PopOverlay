//
//  BFPopSequenceRule.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFPopSequenceRule.h"
#import "BFAlertVC+PopRule.h"


@implementation BFPopSequenceRule

+ (void)load {
    [self clearData];
}

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
        if (concurrent == NO) {
            _needShowIndex = item;
        }
        item.request(item, nil);
    }
}

#pragma mark - Delegate
+ (BOOL)isConcurrent {
    return YES;
}

+ (BOOL)isImmediatelyPut {
    return NO;
}

@end
