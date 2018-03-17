//
//  WalletManager.h
//  SkyWallet
//
//  Created by PanYibin on 2018/3/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletManager : NSObject<RCTBridgeModule>

+ (instancetype)sharedInstance;

- (void)initWallet;
- (NSArray*)getLocalWalletArray;
- (void)addWalletLocally:(WalletModel*)walletModel;

@end
