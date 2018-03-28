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
  if (!data) {
    return nil;
  }
  
  dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
  if(!error) {
    return dict;
  } else {
    return nil;
  }
}

+ (UIImage*)qrCodeImageWithString:(NSString*)str width:(CGFloat)width height:(CGFloat)height {
  NSData *stringData = [str dataUsingEncoding: NSUTF8StringEncoding];
  
  CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
  [qrFilter setValue:stringData forKey:@"inputMessage"];
  [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
  
  CIImage *qrImage = qrFilter.outputImage;
  float scaleX = width / qrImage.extent.size.width;
  float scaleY = height / qrImage.extent.size.height;
  
  qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];
  
  return [UIImage imageWithCIImage:qrImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];

}

@end
