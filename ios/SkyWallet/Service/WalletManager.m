//
//  WalletManager.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WalletManager.h"

@implementation WalletManager

RCT_EXPORT_MODULE()

+ (instancetype)sharedInstance {
  static WalletManager *_instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[self alloc] init];
  });
  
  return _instance;
}

RCT_REMAP_METHOD(getSeed, getSeedWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  NSString *seed = [self getSeed];
  resolve(seed);
}

- (NSString*)getSeed {
  NSString *seed = MobileNewSeed();
  return seed;
}

RCT_REMAP_METHOD(getPinCode, getPinCodeWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  NSString *pinCode = [[NSUserDefaults standardUserDefaults] stringForKey:kPinCode];
  resolve(pinCode);
}

RCT_REMAP_METHOD(createNewWallet, createWallet:(NSString*)walletName seed:(NSString*)seed pinCode:(NSString*)pinCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  BOOL success = [self createWallet:walletName seed:seed pinCode:pinCode];
  
  resolve(@(success));
}

- (BOOL)createWallet:(NSString*)walletName seed:(NSString*)seed pinCode:(NSString*)pinCode {
  if(!walletName || !seed || !pinCode) {
    return NO;
  }
  
  NSError *error;
  NSString *password = [self passwordWithPinCode:pinCode];
  MobileInit([self getWalletDir], password, &error);
  if (!error) {
    [self registerNewCoin];
    [[NSUserDefaults standardUserDefaults] setObject:pinCode forKey:kPinCode];
  }
  
  NSString *walletId = MobileNewWallet(@"skycoin", walletName, seed, password, &error);
  
  if(!error) {
    WalletModel *wm = [[WalletModel alloc] init];
    wm.walletName = walletName;
    wm.walletId = walletId;
    wm.walletType = @"skycoin";
    wm.pinCode = pinCode;
    wm.seed = seed;
    
    [self addWalletLocally:wm];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewWalletCreatedNotification object:nil];
    
    return YES;
  } else {
    return NO;
  }
}

RCT_EXPORT_METHOD(createNewAddressWithWalletId:(NSString*)walletId num:(NSInteger)num) {
  NSError *error;
  NSString *pinCode = [[NSUserDefaults standardUserDefaults] stringForKey:kPinCode];
  NSString *password = [self passwordWithPinCode:pinCode];
  MobileNewAddress(walletId, num, password, &error);
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kNewAddressCreatedNotification object:nil];
}

RCT_REMAP_METHOD(sendSkyCoinWithWalletId, sendSkyCoinWithWalletId:(NSString*)walletId toAddress:(NSString*)toAddr amount:(NSString*)amount resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  NSError *error;
  MobileSend(kCoinTypeSky, walletId, toAddr, amount, &error);
  if(!error) {
    resolve(@"success");
    [[NSNotificationCenter defaultCenter] postNotificationName:kCoinSentNotification object:nil];
  } else {
    resolve([error.userInfo getStringForKey:@"NSLocalizedDescription"]);
  }
}

- (NSString*)passwordWithPinCode:(NSString*)pinCode {
  NSString *password = [NSString stringWithFormat:@"%ld", [pinCode hash]];
  return password;
}

- (NSArray*)getLocalWalletArray {
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalWalletArray];
  if(data) {
    NSArray *walletArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return walletArray;
  } else {
    return nil;
  }
}

- (void)addWalletLocally:(WalletModel*)walletModel {
  NSArray *localWalletArray = [self getLocalWalletArray];
  NSMutableArray *mutableLocalWalletArray;
  
  if(localWalletArray && [localWalletArray isKindOfClass:[NSArray class]] && localWalletArray.count > 0) {
    mutableLocalWalletArray = [[NSMutableArray alloc] initWithArray:localWalletArray];
  } else {
    mutableLocalWalletArray = [[NSMutableArray alloc] init];
  }
  
  [mutableLocalWalletArray addObject:walletModel];
  
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mutableLocalWalletArray];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLocalWalletArray];
}

- (NSString*)getWalletDir {
  NSError *error;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
  NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/SkyWallet"];
  
  if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
  
  return dataPath;
}

- (void)initWallet {
  NSString *pinCode = [[NSUserDefaults standardUserDefaults] stringForKey:kPinCode];
  if (pinCode) {
    NSString *password = [self passwordWithPinCode:pinCode];
    NSError *error;
    MobileInit([self getWalletDir], password, &error);
    
    [self registerNewCoin];
  }
}

- (void)registerNewCoin {
  NSError *error;
  MobileRegisterNewCoin(@"spocoin", @"47.75.36.182:8620", &error);
  MobileRegisterNewCoin(@"skycoin", @"47.75.36.182:6420", &error);
}

- (WalletBalanceModel*)getBalanceOfWallet:(NSString*)walletId coinType:(NSString*)coinType {
  NSError *error;
  NSString *balanceJsonStr = MobileGetWalletBalance(coinType, walletId, &error);
  NSDictionary *balanceDict = [SWUtils dictionaryFromJsonString:balanceJsonStr];
  WalletBalanceModel *wbm = [[WalletBalanceModel alloc] initWithDictionary:balanceDict];
  
  return wbm;
}

- (WalletBalanceModel*)getBalanceOfAddress:(NSString*)address coinType:(NSString*)coinType {
  NSError *error;
  NSString *balanceJsonStr = MobileGetBalance(coinType, address, &error);
  NSDictionary *balanceDict = [SWUtils dictionaryFromJsonString:balanceJsonStr];
  WalletBalanceModel *wbm = [[WalletBalanceModel alloc] initWithDictionary:balanceDict];
  
  return wbm;
}

@end
