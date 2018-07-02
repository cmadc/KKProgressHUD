//
//  ViewController.m
//  KKProgressHUD
//
//  Created by CaiMing on 2017/6/19.
//  Copyright © 2017年 CaiMing. All rights reserved.
//

#import "ViewController.h"
#import <KKProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [KKProgressHUD showMBProgressAddTo:self.view];

    [KKProgressHUD showReminder:self.view message:@"12333333"];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
