//
//  WalletGeneratorViewController.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/17.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WalletGeneratorViewController.h"

@interface WalletGeneratorViewController ()

@end

@implementation WalletGeneratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  self.navigationController.navigationBar.hidden = YES;
  
  RCTRootView *newWalletView = [RNManager viewWithModuleName:@"WalletGenerator" initialProperties:@{@"needPinCode":@(self.needPinCode)}];
  [self.view addSubview:newWalletView];
  
  [newWalletView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.view);
  }];
}

@end
