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
  
  [self loadData];
  
  self.walletView = [RNManager viewWithModuleName:@"Wallet"
                                initialProperties:nil];
  [self.view addSubview:self.walletView];
  
  [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.view);
  }];
}

- (void)viewDidAppear:(BOOL)animated {
  [self loadData];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.walletView.appProperties = @{
                                      @"totalCoinBalance":self.totalCoinBalance ? : @"",
                                      @"totalHourBalance":self.totalHourBalance ? : @"",
                                      @"data": self.walletJsonArray ? : @[]
                                      };
  });
}

- (void)loadData {
  self.walletArray = [[WalletManager sharedInstance] getLocalWalletArray];
  
  NSMutableArray *mutableWalletArray = [[NSMutableArray alloc] init];
  NSInteger totalCoinBalance = 0;
  float totalHourBalance = 0;
  
  for (WalletModel *wm in self.walletArray) {
    NSDictionary *wmDict = [wm convertToDictionary];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:wmDict];
    
    NSError *error;
    NSString *walletBalance = MobileGetWalletBalance(@"skycoin", wm.walletId, &error);
    if (walletBalance) {
      NSDictionary *balanceDict = [SWUtils dictionaryOfJsonString:walletBalance];
      NSString *balance = [balanceDict getStringForKey:@"balance"];
      NSString *hours = [balanceDict getStringForKey:@"hours"];
      
      if (balance) {
        totalCoinBalance += [balance integerValue];
        totalHourBalance += [hours floatValue];
      }
      
      [dict setObject:balance forKey:@"balance"];
      [mutableWalletArray addObject:dict];
    }
  }
  
  self.walletJsonArray = mutableWalletArray;
  self.totalCoinBalance = [NSString stringWithFormat:@"%ld", totalCoinBalance];
  self.totalHourBalance = [NSString stringWithFormat:@"%.f", totalHourBalance];
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

//- (void)viewDidAppear:(BOOL)animated {
//  NSArray *walletArray = [[WalletManager sharedInstance] getLocalWalletArray];
//  if(!walletArray || walletArray.count == 0) {
//    WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] init];
//    vc.needPinCode = YES;
//
//    [[NavigationHelper sharedInstance].rootNavigationController pushViewController:vc animated:NO];
//  } else {
//    for (WalletModel *wm in walletArray) {
//      NSError *error;
//      NSString *seed = MobileGetSeed(wm.walletId, &error);
//
//      NSLog(@"wallet id:%@, seed:%@", wm.walletId, seed);
//    }
//  }
//}

- (IBAction)clickNewWallet:(id)sender {
  WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] init];
  [[NavigationHelper sharedInstance].rootNavigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
