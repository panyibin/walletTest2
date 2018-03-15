//
//  WalletModel.h
//  SkyWallet
//
//  Created by PanYibin on 2018/3/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletModel : NSObject

@property(nonatomic, strong) NSString *pinCode;
@property(nonatomic, strong) NSString *walletName;
@property(nonatomic, strong) NSString *walletId;
@property(nonatomic, strong) NSString *seed;

@end
