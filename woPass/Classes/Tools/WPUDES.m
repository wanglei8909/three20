//
//  DES.m
//  DESDemo
//
//  Created by tekuba.net on 13-7-23.
//  Copyright (c) 2013年 tekuba.net. All rights reserved.
//  
//  DES algorithm has two modes:CBC and EBC. It is EBC mode if CCCrypt function used kCCOptionECBMode Parameter.Otherwise,It's CBC mode.
//  In ECB mode, you can encrypti and decrypt only 8 bytes data  each time。If the data extra 8 bytes, you need to call encryptDES/decryptDES multiple times.
//  

#import "WPUDES.h"
#import <CommonCrypto/CommonCryptor.h>

static Byte iv[] = {'c','u','w','o','p','l','u','s'};//only Used for Cipher Block Chaining (CBC) mode,This is ignored if ECB mode is used

@implementation WPUDES

/*DES encrypt*/
+(Byte *) encryptDES:(Byte *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode
{
    NSUInteger dataLength = strlen((const char*)srcBytes);
    Byte *encryptBytes = malloc(1024);
    memset(encryptBytes, 0, 1024);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          useEBCmode ? (kCCOptionPKCS7Padding | kCCOptionECBMode):kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          srcBytes	, dataLength,
                                          encryptBytes, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSLog(@"DES加密成功");
        return encryptBytes;
    }
    else
    {
        NSLog(@"DES加密失败");
        return nil;
    }
}

+ (NSString *)encryptDESString:(NSString *)clearString key:(NSString *)key useEBCmode:(BOOL)useEBCmode {
    
    Byte *clearBytes = (Byte *)clearString.UTF8String;
    Byte *enBytes = [self encryptDES:clearBytes key:key useEBCmode:useEBCmode];
    NSData *enData = [NSData dataWithBytes:enBytes length:strlen((const char *)enBytes)];
    NSString *enString = [enData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    Byte *deByte = [self decryptDES:enBytes key:key useEBCmode:useEBCmode];
    return enString;
}

//+ (NSString *)decryptDESString:(NSString *)enString key:(NSString *)key useEBCmode:(BOOL)useEBCmode {
//    
//    
//    Byte *deBytes = [self decryptDES:enBytes key:key useEBCmode:useEBCmode];
//    NSData *deData = [NSData dataWithBytes:deBytes length:strlen((const char *)deBytes)];
//    NSString *deString = [deData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    return deString;
//}

/*DES decrypt*/
+(Byte *) decryptDES:(Byte *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode
{
    NSUInteger dataLength = strlen((const char*)srcBytes);
    Byte *decryptBytes = malloc(1024);
    memset(decryptBytes, 0, 1024);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          useEBCmode ? (kCCOptionPKCS7Padding | kCCOptionECBMode):kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          srcBytes	, dataLength,
                                          decryptBytes, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSLog(@"DES解密成功");
        return decryptBytes;
    }
    else
    {
        NSLog(@"DES解密失败");
        return nil;
    }
}




@end
