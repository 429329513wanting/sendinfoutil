//
//  NSString+val.h
//  WTInternship
//
//  Created by gh on 13-7-9.
//  Copyright (c) 2013年 Wanting3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(val)
//手机号是否有效
+ (BOOL)phoneValidate:(NSString *)phoneNum;
//密码是否有效
+ (BOOL)passwordValidate:(NSString *)password;
//学号是否有效
+ (BOOL)studentNumberValidate:(NSString *)number;
//判断是否为空
+ (BOOL)stringLeng:(NSString *)str;
//判断姓名的输入正确性
+ (BOOL)userNameValidate:(NSString *)name;
//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
//邮箱
+ (BOOL)emailValidate:(NSString *)email;
+ (NSString *)stringFromHtml:(NSString*)htm;
//金额只能是数字和小数点
+(BOOL)numValidate:(NSString *)num;

+(BOOL)chineseChracterValidate:(NSString *)chracter;

+ (BOOL)onlyDotTwoNumber:(NSString *)num;
//银行卡
+ (BOOL)bankCardNumber:(NSString *)cardNo;
+ (BOOL)postCode:(NSString*)code;

//拼接字符串
+ (NSString*)catStringTitle:(NSString*)title value:(NSString*)value;


//验证数字
+(BOOL)onlyNumValidate:(NSString *)num;
+(NSUInteger)chineseLength:(NSString*)text;

/**
 *  获得ip地址
 */
+ (NSString*)getIPAddress;
@end
