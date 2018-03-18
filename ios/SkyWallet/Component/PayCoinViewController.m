//
//  PayCoinViewController.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/18.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "PayCoinViewController.h"

@interface PayCoinViewController ()

@property (nonatomic, strong) WalletModel *walletModel;
@property (nonatomic, strong) RCTRootView *payView;

//used for RN
@property (nonatomic, strong) NSString *balance;

@end

@implementation PayCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  if(self.walletModelDict) {
    self.walletModel = [[WalletModel alloc] initWithDictionary:self.walletModelDict];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [self refreshPage];
}

- (void)refreshPage {
  [self loadData];
  
  NSDictionary *initialProperties = @{
                                      @"walletModelDict":self.walletModelDict ? : @{},
                                      @"balance":self.balance ? : @"0"
                                      };
  
  if (!self.payView) {
    self.payView = [RNManager viewWithModuleName:@"PayView" initialProperties:initialProperties];
    [self.view addSubview:self.payView];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(self.view);
    }];
  } else {
    self.payView.appProperties = initialProperties;
  }
}

- (void)loadData {
  WalletBalanceModel *wbm = [[WalletManager sharedInstance] getBalanceOfWallet:self.walletModel.walletId coinType:kCoinTypeSky];
  self.balance = wbm.balance;
}

- (void)loadView {
  UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  view.backgroundColor = [UIColor whiteColor];
  self.view = view;
}

@end
