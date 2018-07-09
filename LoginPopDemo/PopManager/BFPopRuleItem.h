//
//  BFPopRuleItem.h
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFPopRuleItem;

typedef void(^requestAction)(BFPopRuleItem *item, id future);
typedef void(^putAction)(BFPopRuleItem *item, id httpResponse);

typedef NS_ENUM(NSInteger, PutType) {
    PutTypeSerial,
    PutTypeConcurrent,
};

@interface BFPopRuleItem : NSObject

@property (nonatomic, assign) PutType type;
@property (nonatomic, strong) id result; /**< http response*/

@property (nonatomic, copy) requestAction request; //在request中 保存 result
@property (nonatomic, copy) putAction curPut;

@property (nonatomic, strong) BFPopRuleItem *next;

- (void)putNext;

@end
