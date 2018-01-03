//
//  NSString+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

#endif

@implementation NSString (Extension)

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString
{
    NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
    NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);
    
    NSUInteger offset = 0;
    NSMutableString *raw = [self mutableCopy];
    
    NSInteger prevLength = 0;
    for(NSInteger i = 0; i < [indexes count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[indexes objectAtIndex:i] rangeValue];
            prevLength = range.length;
            
            range.location -= offset;
            [raw replaceCharactersInRange:range withString:aString];
            offset = offset + prevLength - [aString length];
        }
    }
    
    return raw;
}

- (NSString *)md5String
{
    if (!self) {
        return nil;
    }
    const char* original_str=[self UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, strlen(original_str), digist);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString];
}

+ (BOOL)isEmptyString:(NSString *)string {
    if (string != nil && (id)string != [NSNull null]) {
        return [string isEmpty];
    }
    return YES;
}

+ (BOOL)isNotEmptyString:(NSString *)string {
    return ![NSString isEmptyString:string];
}

+ (NSString *)fromInt:(int)value {
	return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)fromInteger:(NSInteger)value {
	return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)fromUInteger:(NSUInteger)value {
	return [NSString stringWithFormat:@"%lu", (unsigned long)value];
}

+ (NSString *)fromFloat:(float)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromDouble:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromBool:(BOOL)value {
	return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)deleteBracket:(NSString*)bracketString{
    NSRange rang = [bracketString rangeOfString:@"("];
    NSMutableString *deleteString = [NSMutableString stringWithString:bracketString];
    NSRange deleRan = NSMakeRange(rang.location, bracketString.length-rang.location);
    [deleteString deleteCharactersInRange:deleRan];
    return deleteString;
}

- (CGFloat)getDrawWidthWithFont:(UIFont *)font
{
    CGFloat width = 0.f;
    
    CGSize textSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    if (IOS7_OR_LATER) {
        CGRect sizeWithFont = [self boundingRectWithSize:textSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:tdic
                                             context:nil];
    
#if defined(__LP64__) && __LP64__
        width = ceil(CGRectGetWidth(sizeWithFont));
#else
        width = ceilf(CGRectGetWidth(sizeWithFont));
#endif
    }else{
        CGSize ios6textSize = [self sizeWithFont:font constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
        
#if defined(__LP64__) && __LP64__
        width = ceil(ios6textSize.width);
#else
        width = ceilf(ios6textSize.width);
#endif
        
    }
    return width;
}

- (CGFloat)getDrawHeightWithFont:(UIFont *)font Width:(CGFloat)width
{
    CGFloat height = 0.f;
    
    CGSize textSize = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    if (IOS7_OR_LATER)
    {
        CGRect sizeWithFont = [self boundingRectWithSize:textSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:tdic
                                                 context:nil];
        
#if defined(__LP64__) && __LP64__
        height = ceil(CGRectGetHeight(sizeWithFont));
#else
        height = ceilf(CGRectGetHeight(sizeWithFont));
#endif
    }
    else
    {
        CGSize ios6textSize = [self sizeWithFont:font constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
        
#if defined(__LP64__) && __LP64__
        height = ceil(ios6textSize.height);
#else
        height = ceilf(ios6textSize.height);
#endif
        
    }
    return height;
}

- (BOOL)isEmpty {
    return ![self isNotEmpty];
}

- (BOOL)isNotEmpty {
    if (self != nil
        && ![self isKindOfClass:[NSNull class]]
        && (id)self != [NSNull null]
        && [[self trimWhitespace] length]>0) {
        return YES;
    }
    return NO;
}


- (NSInteger)actualLength {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self dataUsingEncoding:encoding];
    return [data length];
}

- (NSString *)trimWhitespace {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimLeftAndRightWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimHTMLTag {
    NSString *html = self;
    
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return [html trimWhitespace];
}

- (BOOL)isWhitespace {
    return [self isEmpty];
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)URLRegularExp {
    static NSString *urlRegEx = @"((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\.&]*)";;
    return urlRegEx;
}

- (BOOL)isURL {
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [self URLRegularExp]];
    return [urlTest evaluateWithObject:self];
}

- (NSArray *)URLList {
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:[self URLRegularExp]
                                                                         options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionDotMatchesLineSeparators
                                                                           error:nil];
    NSArray *matches = [reg matchesInString:self
                                    options:NSMatchingReportCompletion
                                      range:NSMakeRange(0, self.length)];
    
    NSMutableArray *URLs = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *result in matches) {
        [URLs addObject:[self substringWithRange:result.range]];
    }
    return URLs;
}

//- (BOOL)isIP {
//    NSString *ipRegex = @"((^1([0-9]\\d{0,2}))|(^2([0-5\\d{0,2}])))";
//    NSPredicate *ipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipRegex];
//    return [ipTest evaluateWithObject:self];
//}

- (BOOL)isCellPhoneNumber {
    NSString *cellPhoneRegEx = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9])\\d{8}$";
    NSPredicate *cellPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cellPhoneRegEx];
    return [cellPhoneTest evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
    NSString *phoneRegEx= @"((^0(10|2[0-9]|\\d{2,3})){0,1}-{0,1}(\\d{6,8}|\\d{6,8})$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isAmericanPhoneNumber
{
    if (self.length >= 10 && self.length < 30)
    {
        return YES;
    }
    return NO;
    
//    NSString *cellPhoneRegEx = @"^\\d{10,}$";//@"^[0-9]{3}[0-9]{3}[0-9]{4}$";
//    NSPredicate *cellPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cellPhoneRegEx];
//    return [cellPhoneTest evaluateWithObject:self];
}

- (BOOL)isZipCode {
    NSString *zipCodeRegEx = @"[1-9]\\d{5}$";
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegEx];
    return [zipCodeTest evaluateWithObject:self];
}

- (BOOL)isAmericanZipcode
{
    NSString *zipCodeRegEx = @"(^[0-9]{5}(-[0-9]{4})?$)";
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegEx];
    return [zipCodeTest evaluateWithObject:self];
}

- (id)jsonObject:(NSError **)error {
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableContainers
                                             error:error];
}

- (BOOL)isVisaCard
{
    NSString *visaRegEx = @"^4[0-9]{12}(?:[0-9]{3})?$";
    NSPredicate *visaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", visaRegEx];
    return [visaTest evaluateWithObject:self];
}

- (BOOL)isMasterCard
{
    NSString *masterRegEx = @"^5[1-5][0-9]{14}$";
    NSPredicate *masterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", masterRegEx];
    return [masterTest evaluateWithObject:self];
}

- (BOOL)isAmericanExpressCard
{
    NSString *ameRegEx = @"^3[47][0-9]{13}$";
    NSPredicate *ameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ameRegEx];
    return [ameTest evaluateWithObject:self];
}

- (BOOL)isDiscoverCard
{
    NSString *discoverRegEx = @"^6(?:011|5[0-9]{2})[0-9]{12}$";
    NSPredicate *discoverTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", discoverRegEx];
    return [discoverTest evaluateWithObject:self];
}

@end
