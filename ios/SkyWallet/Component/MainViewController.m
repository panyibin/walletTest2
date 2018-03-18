//
//  MainViewController.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "MainViewController.h"
#import "WalletGeneratorViewController.h"

@interface MainViewController () {
  BOOL rnViewCreated;
}

@property (nonatomic, strong) RCTRootView *walletView;
@property (nonatomic, strong) NSArray *walletArray;

//used for RN
@property (nonatomic, strong) NSArray *walletJsonArray;
@property (nonatomic, strong) NSString *totalCoinBalance;
@property (nonatomic, strong) NSString *totalHourBalance;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [self loadData];
  
  if(!self.walletArray) {
    WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] init];
    vc.needPinCode = YES;
    
    [[NavigationHelper sharedInstance].rootNavigationController pushViewController:vc animated:NO];
  } else {
    NSDictionary *walletViewProperties = @{
                                           @"totalCoinBalance":self.totalCoinBalance ? : @"",
                                           @"totalHourBalance":self.totalHourBalance ? : @"",
                                           @"data": self.walletJsonArray ? : @[]
                                           };
    if (!self.walletView) {
      self.walletView = [RNManager viewWithModuleName:@"Wallet" initialProperties:walletViewProperties];
      [self.view addSubview:self.walletView];
      [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
      }];
    } else {
      self.walletView.appProperties = walletViewProperties;
    }
  }
}

- (void)loadData {
  self.walletArray = [[WalletManager sharedInstance] getLocalWalletArray];
  
  NSMutableArray *mutableWalletArray = [[NSMutableArray alloc] init];
  float totalCoinBalance = 0;
  float totalHourBalance = 0;
  
  for (WalletModel *wm in self.walletArray) {
    NSDictionary *wmDict = [wm convertToDictionary];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:wmDict];
    
    NSError *error;
    NSString *walletBalance = MobileGetWalletBalance(@"skycoin", wm.walletId, &error);
    if (walletBalance) {
      NSDictionary *balanceDict = [SWUtils dictionaryFromJsonString:walletBalance];
      WalletBalanceModel *wbm = [[WalletBalanceModel alloc] initWithDictionary:balanceDict];
      
      totalCoinBalance += [wbm.balance floatValue];
      totalHourBalance += [wbm.hours floatValue];
      
      [dict setObject:wbm.balance forKey:@"balance"];
      [mutableWalletArray addObject:dict];
    }
  }
  
  self.walletJsonArray = mutableWalletArray;
  self.totalCoinBalance = [NSString stringWithFormat:@"%.3f", totalCoinBalance];
  self.totalHourBalance = [NSString stringWithFormat:@"%.3f", totalHourBalance];
}

- (NSArray*)getJsonArray {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  for (WalletModel *wm in self.walletArray) {
    NSDictionary *wmDict = [wm convertToDictionary];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:wmDict];
    
    NSError *error;
    NSString *walletBalance = MobileGetWalletBalance(@"skycoin", wm.walletId, &error);
    
    [dict setObject:walletBalance?:@"0" forKey:@"balance"];
    
    [array addObject:dict];
  }
  
  return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
