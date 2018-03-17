//
//  MainViewController.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "MainViewController.h"
#import "WalletGeneratorViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  NSArray *walletArray = [[WalletManager sharedInstance] getLocalWalletArray];
  if(!walletArray || walletArray.count == 0) {
    WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] init];
    vc.needPinCode = YES;
    
    [[NavigationHelper sharedInstance].rootNavigationController pushViewController:vc animated:NO];
  } else {
    for (WalletModel *wm in walletArray) {
      NSError *error;
      NSString *seed = MobileGetSeed(wm.walletId, &error);
      
      NSLog(@"wallet id:%@, seed:%@", wm.walletId, seed);
    }
  }
}

- (IBAction)clickNewWallet:(id)sender {
  WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] init];
  [[NavigationHelper sharedInstance].rootNavigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
