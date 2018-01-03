//
//  NSString+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString;

- (NSString *)md5String;

+ (BOOL)isEmptyString:(NSString *)string;

+ (BOOL)isNotEmptyString:(NSString *)string;

+ (NSString *)fromInt:(int)value;

+ (NSString *)fromInteger:(NSInteger)value;

+ (NSString *)fromUInteger:(NSUInteger)value;

+ (NSString *)fromFloat:(float)value;

+ (NSString *)fromDouble:(double)value;

+ (NSString *)fromBool:(BOOL)value;

+ (NSString *)deleteBracket:(NSString*)bracketString;

- (CGFloat)getDrawWidthWithFont:(UIFont *)font;
- (CGFloat)getDrawHeightWithFont:(UIFont *)font Width:(CGFloat)width;

- (BOOL)isEmpty;

- (BOOL)isNotEmpty;

- (BOOL)isEmail;

- (BOOL)isMatchesRegularExp:(NSString *)regex;

- (BOOL)isCellPhoneNumber;

- (BOOL)isPhoneNumber;

- (BOOL)isAmericanPhoneNumber;

- (BOOL)isZipCode;

- (BOOL)isAmericanZipcode;
//卡号判断
- (BOOL)isVisaCard;

- (BOOL)isMasterCard;

- (BOOL)isAmericanExpressCard;

- (BOOL)isDiscoverCard;

@end
