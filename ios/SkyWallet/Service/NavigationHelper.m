//
//  NavigationHelper.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/17.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NavigationHelper.h"
#import "WalletGeneratorViewController.h"
#import "PinCodeViewController.h"

@implementation NavigationHelper

RCT_EXPORT_MODULE()

+ (instancetype)sharedInstance {
  static NavigationHelper *_instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[self alloc] init];
  });
  
  return _instance;
}

- (UINavigationController*)rootNavigationController {
  return (UINavigationController*)[UIApplication sharedApplication].delegate.window.rootViewController;
}

RCT_EXPORT_METHOD(showPinCodeViewControllerWithWalletName:(NSString*)walletName seed:(NSString*)seed animated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    PinCodeViewController *vc = [[PinCodeViewController alloc] initWithNibName:@"PinCodeViewController" bundle:nil];
    vc.walletName = walletName;
    vc.seed = seed;
    
    [[self rootNavigationController] pushViewController:vc animated:animated];
  });
}

RCT_EXPORT_METHOD(showWalletGeneratorViewControllerAnimated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] initWithNibName:@"WalletGeneratorViewController" bundle:nil];
    
    [[self rootNavigationController] pushViewController:vc animated:animated];
  });
}

RCT_EXPORT_METHOD(popViewControllerAnimated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[self rootNavigationController] popViewControllerAnimated:animated];
  });
}

RCT_EXPORT_METHOD(popToRootViewControllerAnimated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[self rootNavigationController] popToRootViewControllerAnimated:animated];
  });
}

@end
