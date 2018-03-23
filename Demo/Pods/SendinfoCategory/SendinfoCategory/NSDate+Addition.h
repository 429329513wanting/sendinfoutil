//
//  NSDate+Addition.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)
+ (NSString *)currentDateStringWithFormat:(NSString *)format;
- (NSString *)dateWithFormat:(NSString *)format;
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;



+ (NSDate*)getDate:(NSString *)date;
+ (NSDate*)anotherGetDate:(NSString *)date;

@end
