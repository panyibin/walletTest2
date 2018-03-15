//
//  MainViewController.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.navigationController.navigationBar.hidden = YES;
  
  RCTRootView *welcomeView = [[RCTRootView alloc] initWithBundleURL:[RNManager jsCodeLocation] moduleName:@"SkyWallet" initialProperties:nil launchOptions:nil];
  
  [self.view addSubview:welcomeView];
  
  [welcomeView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.view);
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
