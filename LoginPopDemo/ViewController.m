//
//  ViewController.m
//  LoginPopDemo
//
//  Created by ganyanchao on 2018/7/7.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "ViewController.h"
#import "BFPopSequenceRule.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [BFPopSequenceRule serialPut];
}


@end
