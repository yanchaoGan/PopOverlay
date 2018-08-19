//
//  ViewController.m
//  LoginPopDemo
//
//  Created by ganyanchao on 2018/7/7.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "ViewController.h"
#import "BFPopSequenceRule.h"
#import "PopAuthResultView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLoginPop];
}

- (void)showLoginPop {
    
    for (int i = 0; i < 5; i ++) {
        BFPopRuleItem *t = BFPopRuleItem.alloc.init;
        t.request = ^(BFPopRuleItem *item, id future) {
            item.result = @{@"code":@"0",@"message":@"success"};
        };
        t.curPut = ^UIView *(BFPopRuleItem *item, id result) {
            PopAuthResultView *rv = DVLLoadNib(PopAuthResultView.className);
            rv.testLabel.text = [NSString stringWithFormat:@"this is %zi",i];
            rv.backgroundColor = i%2?UIColor.redColor:UIColor.greenColor;
            return rv;
        };
        [BFPopSequenceRule addRule:t];
    }
}



@end
