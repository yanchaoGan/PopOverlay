//
//  BFPopRuleItem.h
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFPopRuleItem;

//send a http request
typedef void(^requestAction)(BFPopRuleItem *item, id future);

//return UIView * is show, or nil go next
typedef UIView *(^putAction)(BFPopRuleItem *item, id result);

@interface BFPopRuleItem : NSObject

//step 1
@property (nonatomic, copy) requestAction request;  //send a request in block
@property (nonatomic, strong)id result; //save a response in block

//step 2
@property (nonatomic, copy) putAction curPut;

@end
