//
//  WalletModel.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WalletModel.h"

@implementation WalletModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if(self) {
    _walletName = [aDecoder decodeObjectForKey:@"walletName"];
    _walletId = [aDecoder decodeObjectForKey:@"walletId"];
    _pinCode = [aDecoder decodeObjectForKey:@"pinCode"];
    _seed = [aDecoder decodeObjectForKey:@"seed"];
    _walletType = [aDecoder decodeObjectForKey:@"walletType"];
  }
  
  return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_walletName forKey:@"walletName"];
  [aCoder encodeObject:_walletId forKey:@"walletId"];
  [aCoder encodeObject:_pinCode forKey:@"pinCode"];
  [aCoder encodeObject:_seed forKey:@"seed"];
  [aCoder encodeObject:_walletType forKey:@"walletType"];
}

@end
