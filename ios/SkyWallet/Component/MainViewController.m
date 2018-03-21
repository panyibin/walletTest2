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
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNewWalletCreated:) name:kNewWalletCreatedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCoinSent:) name:kCoinSentNotification object:nil];
  
  [self refreshPage];
}

- (void)viewDidAppear:(BOOL)animated {
//  [self refreshPage];
}

- (void)refreshPage {
  [YBLoadingView showInView:self.view];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [self loadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
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
      
//      [self.loadingView hide];
      [YBLoadingView dismiss];
    });
  });
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

- (void)didNewWalletCreated:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self refreshPage];
  });
}

- (void)didCoinSent:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self refreshPage];
  });
}

@end
