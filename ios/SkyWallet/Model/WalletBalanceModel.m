//
//  WalletBalanceModel.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/18.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WalletBalanceModel.h"

@implementation WalletBalanceModel

- (instancetype)initWithDictionary:(NSDictionary*)dict {
  self = [super init];
  if (self) {
    _balance = [dict getStringForKey:@"balance"];
    _hours = [dict getStringForKey:@"hours"];
  }
  
  return self;
}

@end
