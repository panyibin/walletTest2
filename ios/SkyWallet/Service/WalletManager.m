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

@end
