//
//  NSString+AT.h
//  AsiaTravel
//
//  Created by hujianghua on 12/30/15.
//  Copyright © 2015 asiatravel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AT)


/**
 *  Check a string whether empty
 *
 *  @return when nil retun YES，not nil retun NO
 */
- (BOOL)isEmpty;

/**
 *  Validate a email address
 *
 *  email type string
 *
 *  @return valid email return YES，otherwise return NO
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *  Validate a phone number
 *
 *
 *  @return valid phone number return YES，otherwise return NO
 */
- (BOOL)isValidateMobileNumber;
- (BOOL)validateMobileNumberOfCountryCode:(NSString *)countryCode;

/**
 *  Validate an English user name
 *
 *
 *  @return valid name return YES，otherwise return NO
 */
- (BOOL)isValidateEnglishUserName;

/**
 *  Validate a Chinese user name
 *
 *
 *  @return valid name return YES，otherwise return NO
 */
- (BOOL)isValidateChineseUserName;

/**
 *  Trim and keep a float value string to less than two dot
 *
 *  @param floatString  a float value string
 *
 *  @return trimed string
 */
+ (NSString *)trimStringWithLessThanTwoDot:(NSString *)floatString;

/**
 *  Check a string whether a string format number
 *
 *  @param number a string
 *
 *  @return if string is a number string return YES,otherwise return NO
 */
- (BOOL)isValidateNumber;
/**
 * Check  is whether a valid name confirm "4-20" charaters and first character must be chinese or english
 */
- (BOOL)isValidateNickname;
/**
 * Check  is whether a valid name confirm "1-20" charaters and first character must be chinese or english
 */
- (BOOL)isValidateUserName;

- (BOOL)isValidateIdentifyCardNumber;

- (BOOL)isValidatePassportNumber;

/**
 *  Check if the string contains any chinese character, if exist, return YES.
 */
- (BOOL)containsChineseCharacter;

/**
 * Check common traveller page chinese name
 */

- (BOOL)isValidateTravellerChineseUserName;

/**
 *  substring to ? sign
 *
 *  @return a string without ? and string behind ?
 */
- (NSString *)substringToQuestionSign;

/**
 *  parse json string to dictionary
 *
 *  @return dictionary
 */
- (NSDictionary *)dictionaryWithJsonString;

/**
 *  if string conntain blank ,it will delete blank
 *
 *  @return a string
 */
- (NSString *)deleteBlank;

- (NSString *)normalNumToBankNum;

- (NSString *)bankNumToNormalNum;


@end
