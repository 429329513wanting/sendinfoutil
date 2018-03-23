//
//  NSString+val.m
//  WTInternship
//
//  Created by gh on 13-7-9.
//  Copyright (c) 2013年 Wanting3. All rights reserved.
//

#import "NSString+val.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation NSString(val)
+ (BOOL)phoneValidate:(NSString *)phoneNum{
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *mobile = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    
    return [regextestmobile evaluateWithObject:phoneNum];


}
//以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~20
+ (BOOL)passwordValidate:(NSString *)password{
    
    NSString *pwdRegex = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,20}$";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pwdRegex];

    return [pwdTest evaluateWithObject:password];
}
//数字开头，长度7~11
+ (BOOL)studentNumberValidate:(NSString *)number{
    
    NSString *numberRe = @"^[0-9]{6,19}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",numberRe];
    return [numberTest evaluateWithObject:number];
}
//判断是否为空
+ (BOOL)stringLeng:(NSString *)str{
    
    if (str.length == 0 || str == nil) {
        return NO;
    }
    return YES;
}

+ (BOOL)userNameValidate:(NSString *)name{
    
    NSString *nameRegex = @"^[A-Za-z]+([A-Za-z]*|[0-9]*){6,20}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",nameRegex];
    return [nameTest evaluateWithObject:name];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//邮箱
+ (BOOL)emailValidate:(NSString *)email{
    
    BOOL flag;
    if (email.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [emailCardPredicate evaluateWithObject:email];


}
//验证数字小数点
 +(BOOL)numValidate:(NSString *)num
{
    BOOL flag;
    if (num.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    NSPredicate *numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [numPredicate evaluateWithObject:num];
 }


//验证数字
+(BOOL)onlyNumValidate:(NSString *)num
{
    BOOL flag;
    if (num.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^[0-9]*$";
    NSPredicate *numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [numPredicate evaluateWithObject:num];
}

//验证汉字
+(BOOL)chineseChracterValidate:(NSString *)chracter
{
    BOOL flag;
    if (chracter.length <= 0) {
        flag = NO;
        return flag;
    }
    
  NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z\u4e00-\u9fa5]+";
    NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [Predicate evaluateWithObject:chracter];
}
+ (BOOL)postCode:(NSString *)code{
    
    BOOL flag;
    if (code.length <= 0) {
        
        flag = NO;
        return flag;
    }
    NSString *regex = @"[1-9]\\d{5}(?!\d)";
    NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [Predicate evaluateWithObject:code];
}
#pragma mark - 计算汉字长度
+(NSUInteger)chineseLength:(NSString *)text{
    
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    
    return unicodeLength;
    
}

+ (BOOL)onlyDotTwoNumber:(NSString *)num{

    BOOL flag;
    if (num.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex = @"^[0-9]+(\\.[0-9]{2})?$";
    NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [Predicate evaluateWithObject:num];
    
}

+ (BOOL)bankCardNumber:(NSString *)cardNo{
    
    
    int oddsum = 0;    //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}

+ (NSString*)catStringTitle:(NSString*)title value:(NSString*)value{
    
    return [NSString stringWithFormat:@"%@:%@",title,value];
}

+ (NSString *)stringFromHtml:(NSString*)htm{
    
    return [[self class] filterHTML:htm];
    
}
+ (NSString *)filterHTML:(NSString *)html{
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * charText = nil;
    while([scanner isAtEnd]==NO)
    {
        
        
        [scanner scanUpToString:@"&" intoString:nil];
        [scanner scanUpToString:@";" intoString:&charText];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;",charText] withString:@""];
        
    }
    
    html = [[self class] filterMark:html];
    return html;
    
}
+ (NSString *)filterMark:(NSString *)html{
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while ([scanner isAtEnd]==NO) {
        
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    return html;
}

@end
