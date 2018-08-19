//
//  BFPopSequenceRule.h
//  SuperFans
//
//  Created by ganyanchao on 2018/7/6.
//  Copyright © 2018年 com.afander.finance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFPopKit.h"

@interface BFPopSequenceRule : NSObject <BFPopConfigInterface>

//for any other Scene. you can use this
+ (void)addRule:(BFPopRuleItem *)item;

@end

