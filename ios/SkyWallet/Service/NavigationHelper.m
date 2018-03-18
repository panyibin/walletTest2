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
#import "WalletDetailViewController.h"
#import "PayCoinViewController.h"

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

RCT_EXPORT_METHOD(showWalletGeneratorViewControllerWithGenerateSeedButton:(BOOL)showGenerateSeedButton animated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    WalletGeneratorViewController *vc = [[WalletGeneratorViewController alloc] initWithNibName:@"WalletGeneratorViewController" bundle:nil];
    vc.showGenerateSeedButton = showGenerateSeedButton;
    
    [[self rootNavigationController] pushViewController:vc animated:animated];
  });
}

RCT_EXPORT_METHOD(showWalletDetailViewControllerWithWalletModelDict:(NSDictionary*)walletModelDict animated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    WalletDetailViewController *vc = [[WalletDetailViewController alloc] initWithNibName:@"WalletDetailViewController" bundle:nil];
    
    vc.walletModelDict = walletModelDict;
    
    [[self rootNavigationController] pushViewController:vc animated:animated];
  });
}

RCT_EXPORT_METHOD(showPayCoinViewControllerWithWalletModelDict:(NSDictionary*)walletModelDict animated:(BOOL)animated) {
  dispatch_async(dispatch_get_main_queue(), ^{
    PayCoinViewController *vc = [[PayCoinViewController alloc] initWithNibName:@"PayCoinViewController" bundle:nil];
    
    vc.walletModelDict = walletModelDict;
    
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
