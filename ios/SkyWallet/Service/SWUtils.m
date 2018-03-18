//
//  SWUtils.m
//  SkyWallet
//
//  Created by PanYibin on 2018/3/17.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SWUtils.h"

@implementation SWUtils

+ (NSDictionary*)dictionaryFromJsonString:(NSString*)jsonStr {
  NSDictionary *dict;
  NSError *error;
  NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  
  dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
  if(!error) {
    return dict;
  } else {
    return nil;
  }
}

@end
