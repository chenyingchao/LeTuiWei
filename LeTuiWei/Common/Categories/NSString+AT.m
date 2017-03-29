//
//  NSString+AT.m
//  AsiaTravel
//
//  Created by hujianghua on 12/30/15.
//  Copyright © 2015 asiatravel. All rights reserved.
//

#import "NSString+AT.h"

@implementation NSString (AT)



- (BOOL)isEmpty {

    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    
    if (!self || [self isEqualToString:@""] || self.length == 0 || self == nil) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) validateEmail:(NSString *)email {
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isValidateMobileNumber {
    NSString *mobielNumberRegex = @"^\\d+$";
    NSPredicate *mobielNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobielNumberRegex];
    return [mobielNumber evaluateWithObject:self];
}




- (BOOL)isValidateEnglishUserName {

    NSPredicate *enUserName = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[a-zA-Z][a-zA-Z ]{0,25}'"];
    return [enUserName evaluateWithObject:self];
}

- (BOOL)isValidateChineseUserName {
    
    NSPredicate *cnUserName = [NSPredicate predicateWithFormat:@"SELF MATCHES '[\u2E80-\u9FFF]+$'"];
    return [cnUserName evaluateWithObject:self];
}

- (BOOL)isValidateTravellerChineseUserName {
    
    NSString *idRegx = @"(^[\u2E80-\u9FFF]+$)|(^[\u2E80-\u9FFF]+[a-zA-Z]+$)|(^[a-zA-Z]+$)";
    NSPredicate *cnUserName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idRegx];
    return [cnUserName evaluateWithObject:self];
}

- (BOOL)isValidateIdentifyCardNumber {
    NSString *idRegx = @"^\\d{17}[\\d|x|X]$";
    NSPredicate *idNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idRegx];
    return [idNumber evaluateWithObject:self];
}

- (BOOL)isValidatePassportNumber {
    NSString *idRegx = @"^[a-zA-Z0-9]+$";
    NSPredicate *idNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idRegx];
    return [idNumber evaluateWithObject:self];
}

+ (NSString *)trimStringWithLessThanTwoDot:(NSString *)floatString {
    NSUInteger dotLoc = [floatString rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        // if more than two dot
        if (floatString.length - dotLoc > 3) {
            floatString = [floatString substringToIndex:dotLoc + 3];
        }
    }
    return floatString;
}

- (BOOL)isValidateNumber {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (BOOL)isValidateNickname {
    
    NSPredicate *name = [NSPredicate predicateWithFormat:@"SELF MATCHES '([_A-Za-z0-9\u4e00-\u9fa5]{4,20})|([\u4e00-\u9fa5_]{2,10})|(([\u4E00-\u9FA5])([_A-Za-z0-9]{2,20}))|(([_A-Za-z0-9]{1,2})([\u4E00-\u9FA5]))|(([\u4E00-\u9FA5]{2,2})([_A-Za-z0-9]))'"];
    return [name evaluateWithObject:self];
}

- (BOOL)isValidateUserName {
    
    NSPredicate *name = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[\u4E00-\u9FA5a-zA-Z][\u4E00-\u9FA5a-zA-Z. ]{1,19}'"];
    return [name evaluateWithObject:self];
}

- (BOOL)containsChineseCharacter {
    if (self.length) {
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\\p{Script=Han}" options:NSRegularExpressionCaseInsensitive error:&error];
        NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
        if (result && result.range.location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)substringToQuestionSign {
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        return [self substringToIndex:[self rangeOfString:@"?"].location];
    }
    return self;
}

- (NSDictionary *)dictionaryWithJsonString {
    if (!self) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
  
        return nil;
    }
    return dic;
}

- (NSString *)deleteBlank {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)normalNumToBankNum {
    NSString *tmpStr = [self bankNumToNormalNum];
    
    NSInteger size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++) {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n * 4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size * 4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}

- (NSString *)bankNumToNormalNum {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}



@end
