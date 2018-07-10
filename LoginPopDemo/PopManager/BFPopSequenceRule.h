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



@interface BFPopSequenceRule (LoginScene)

//Demo
//提供一个简单的登陆后弹窗场景
//以及 使用模板
+ (void)popLoginScene;

@end

