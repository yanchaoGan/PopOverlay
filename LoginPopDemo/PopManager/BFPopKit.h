//
//  BFPopKit.h
//  SuperFans
//
//  Created by ganyanchao on 2018/7/9.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#ifndef BFPopKit_h
#define BFPopKit_h

#import "BFPopRuleItem.h"

extern NSMutableArray *_sMArr;
extern BFPopRuleItem * _needShowIndex;

@protocol BFPopConfigInterface <NSObject>


/**
 YES request 并发调用。 default
 NO 等待该rule 可用，再发起请求
 @return
 */
+ (BOOL)isConcurrent;

/**
 YES 从后续Rule中查找第一个result不为空的为止
 NO 找下一个next。没有result 则等待 。default
 @return
 */
+ (BOOL)isImmediatelyPut;

@end


#endif /* BFPopKit_h */
