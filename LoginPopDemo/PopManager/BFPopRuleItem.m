//
//  BFPopRuleItem.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFPopRuleItem.h"
#import "BFAlertVC+PopRule.h"

@implementation BFPopRuleItem

- (void)dealloc {
    NSLog(@"dealloc - %@", self.className);
}

#pragma mark - Setter
- (void)setResult:(id)result {
    NSAssert(result != nil, @"result must not nil");
    _result = result;
    [self putCurrent];
}

@end
