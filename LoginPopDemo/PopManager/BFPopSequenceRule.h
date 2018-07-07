//
//  BFPopSequenceRule.h
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFPopSequenceRule : NSObject

//Public
+ (void)serialPut;
+ (void)concurrentPut;

//Private
+ (void)clearData;
+ (void)prepareForNext;

@end
