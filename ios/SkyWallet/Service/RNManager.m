//
//  RNManager.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "RNManager.h"
#import <React/RCTBundleURLProvider.h>

@implementation RNManager

+ (NSURL*)jsCodeLocation {
    NSURL* jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  
  return jsCodeLocation;
}

@end
