//
//  DES.h
//  DESDemo
//
//  Created by tekuba.net on 13-7-23.
//  Copyright (c) 2013年 tekuba.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPUDES : NSObject

/*DES encrypt*/
+(Byte *) encryptDES:(Byte *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode;

/*DES decrypt*/
+(Byte *) decryptDES:(Byte *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode;

+(NSString *) encryptDESString:(NSString *)clearString key:(NSString *)key useEBCmode:(BOOL)useEBCmode;

+(NSString *) decryptDESString:(NSString *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode;

@end
