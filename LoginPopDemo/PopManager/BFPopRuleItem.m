//
//  BFPopRuleItem.m
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import "BFPopRuleItem.h"
#import "BFPopSequenceRule.h"

@implementation BFPopRuleItem

#pragma mark - Setter
- (void)setResult:(id)result {
    _result = result;
    [self putCurrent];
}

#pragma mark - Public
- (void)putCurrent {
    if (self.curPut) {
        self.curPut(self, self.result);
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
            nt.curPut(nt, nt.result);
        }
    }
}

@end
