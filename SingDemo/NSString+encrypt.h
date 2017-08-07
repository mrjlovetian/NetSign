//
//  NSString+encrypt.h
//  TopBroker3
//
//  Created by gaomingzhi on 15/7/9.
//  Copyright (c) 2015年 kakao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(encrypt)
- (NSString *)toMD5;
- (NSString *)getUrlEncode;
- (NSString *)getUrlDecode;
+(NSString*)encodeString:(NSString*)unencodedString;
-(NSString *)decodeString:(NSString*)encodedString;
@end
