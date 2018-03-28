//
//  ViewController.m
//  NumKeyboardTest
//
//  Created by PanYibin on 2018/3/28.
//  Copyright © 2018年 PanYibin. All rights reserved.
//

#import "ViewController.h"
#import "PinInputViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    PinInputViewController *vc = [[PinInputViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
