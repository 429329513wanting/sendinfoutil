//
//  NSDate+Utilities.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSDate+Utilities.h"

#pragma mark - ---------------------------NSCalendar---------------------------
@implementation NSCalendar (Custom)

+ (NSCalendar *)timezoneCalendar
{
    static NSCalendar *timezoneCalendar;
    if(!timezoneCalendar)
    {
        timezoneCalendar = [NSCalendar currentCalendar];
    }
    return timezoneCalendar;
}
+ (NSCalendar *)localCalendar
{
    static NSCalendar *localCalendar;
    if(!localCalendar)
    {
        localCalendar = [NSCalendar currentCalendar];
    }
    return localCalendar;
}
+ (NSCalendar *)GMTCalendar
{
    static NSCalendar *GMTCalendar;
    if(!GMTCalendar)
    {
        GMTCalendar = [NSCalendar currentCalendar];
        [GMTCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
    return GMTCalendar;
}
@end
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
@implementation NSDate (Utilities)
#pragma mark Relative Dates
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}
+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}
+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
#pragma mark Comparing Dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}
- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}
- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}
// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    // Must have a time interval under 1 week. Thanks @aclark
    return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}
- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}
- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}
- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}
// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}
- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}
- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}
- (BOOL) isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}
- (BOOL) isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    return (components1.year == (components2.year + 1));
}
- (BOOL) isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    return (components1.year == (components2.year - 1));
}
- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}
- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}
// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}
// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}
#pragma mark Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}
- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}
#pragma mark Adjusting Dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}
- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}
- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}
- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}
#pragma mark Retrieving Intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}
- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}
- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}
- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}
- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}
- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}
// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}
#pragma mark Decomposing Dates
- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    return components.hour;
}
- (NSInteger) hour
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}
- (NSInteger) minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}
- (NSInteger) seconds
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.second;
}
- (NSInteger) day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.day;
}
- (NSInteger) month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}
- (NSInteger) week
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekOfYear;
}
- (NSInteger) weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}
- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}
- (NSInteger) year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}





+ (NSDateFormatter *)localDateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    return dateFormatter;
}
+ (NSDateFormatter *)timezoneDateFormatter
{
    static NSDateFormatter *timezoneDateFormatter;
    if(!timezoneDateFormatter)
    {
        timezoneDateFormatter = [[NSDateFormatter alloc] init];
    }
    return timezoneDateFormatter;
}
+ (NSDateFormatter *)GMTDateFormatter
{
    static NSDateFormatter *GMTDateFormatter;
    if(!GMTDateFormatter)
    {
        GMTDateFormatter = [[NSDateFormatter alloc] init];
        [GMTDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
    return GMTDateFormatter;
}
+ (NSLocale *)locale
{
    static NSLocale *locale;
    if(!locale)
    {
        locale = [NSLocale currentLocale];
    }
    return locale;
}









- (NSString *)formatterStyle:(NSString *)style styleType:(DateFormatterType)styleType calendarType:(NSCalendarType)calendarType
{
    NSDateFormatter *formatter = nil;
    switch (calendarType)
    {
        case NSCalendarTypeLocal:
            formatter = [NSDate localDateFormatter];
            break;
        case NSCalendarTypeTimezone:
            formatter = [NSDate timezoneDateFormatter];
            break;
        case NSCalendarTypeGMT:
            formatter = [NSDate GMTDateFormatter];
            break;
        default:
            formatter = [[NSDateFormatter alloc] init];
            break;
    }
    switch (styleType)
    {
        case DateFormatterTypeLocal:
            [formatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:style options:0 locale:[NSLocale currentLocale]]];
            break;
        case DateFormatterTypeCustom:
            [formatter setDateFormat:style];
            break;
        default:
            break;
    }
    return [formatter stringFromDate:self];
}


- (NSDate *)getDateByYear:(NSInteger)year
                    month:(NSInteger)month
                      day:(NSInteger)day
                     hour:(NSInteger)hour
                   minute:(NSInteger)min
                   second:(NSInteger)sec
              getDatetype:(GetDateType)getDatetype
             calendarType:(NSCalendarType)calendarType
{
    NSCalendar *calendar = nil;
    switch (calendarType)
    {
        case NSCalendarTypeLocal:
            calendar = [NSCalendar localCalendar];
            break;
        case NSCalendarTypeTimezone:
            calendar = [NSCalendar timezoneCalendar];
            break;
        case NSCalendarTypeGMT:
            calendar = [NSCalendar GMTCalendar];
            break;
        default:
            calendar = [NSCalendar currentCalendar];
            break;
    }
    NSDate *tempDate = [NSDate date];
    switch (getDatetype)
    {
        case GetDateTypeAddSubtract:
        {
            NSDateComponents *dc = [[NSDateComponents alloc] init];
            [dc setYear:year];
            [dc setMonth:month];
            [dc setDay:day];
            [dc setHour:hour];
            [dc setMinute:min];
            [dc setSecond:sec];
            tempDate = [calendar dateByAddingComponents:dc toDate:self options:0];
        }
            break;
        case GetDateTypeModification:
        {
            unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            NSDateComponents *dc = [calendar components:flags fromDate:self];
            if(year != -1)	[dc setYear:year];
            if(month != -1) [dc setMonth:month];
            if(day != -1)	[dc setDay:day];
            if(hour != -1)	[dc setHour:hour];
            if(min != -1)	[dc setMinute:min];
            if(sec != -1)	[dc setSecond:sec];
            
            tempDate = [calendar dateFromComponents:dc];
        }
            break;
        default:
            break;
    }
    return tempDate;
}


/**获取一天开始时间
 *
 **/
- (NSDate*)getStartTimeInDay:(NSCalendarType)calendarType
{
    NSCalendar *calendar = nil;
    switch (calendarType)
    {
        case NSCalendarTypeLocal:
            calendar = [NSCalendar localCalendar];
            break;
        case NSCalendarTypeTimezone:
            calendar = [NSCalendar timezoneCalendar];
            break;
        case NSCalendarTypeGMT:
            calendar = [NSCalendar GMTCalendar];
            break;
        default:
            calendar = [NSCalendar currentCalendar];
            break;
    }
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}



- (NSMutableArray *)getDateWeekArray:(NSCalendarType)calendarType
{
    NSCalendar *calendar = nil;
    switch (calendarType)
    {
        case NSCalendarTypeLocal:
            calendar = [NSCalendar localCalendar];
            break;
        case NSCalendarTypeTimezone:
            calendar = [NSCalendar timezoneCalendar];
            break;
        case NSCalendarTypeGMT:
            calendar = [NSCalendar GMTCalendar];
            break;
        default:
            calendar = [NSCalendar currentCalendar];
            break;
    }
    NSMutableArray *weekList = [NSMutableArray array];
    NSDate *weekFirstDate = nil;
    [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&weekFirstDate interval:NULL forDate:self];
    [weekList addObject:weekFirstDate];
    for(int i = 1; i < 7; i ++)
    {
        NSDate *tempDate = [weekFirstDate getDateByYear:0 month:0 day:i hour:0 minute:0 second:0 getDatetype:GetDateTypeAddSubtract calendarType:calendarType];
        tempDate = [tempDate getStartTimeInDay:calendarType];
        [weekList addObject:tempDate];
    }
    NSArray *sortArray = [weekList sortedArrayUsingSelector:@selector(compare:)];
    [weekList removeAllObjects];
    [weekList addObjectsFromArray:sortArray];
    
    return weekList;
}



-(NSMutableArray *)getDateMonthArray:(NSCalendarType)calendarType
{
    NSCalendar *calendar = nil;
    switch (calendarType)
    {
        case NSCalendarTypeLocal:
            calendar = [NSCalendar localCalendar];
            break;
        case NSCalendarTypeTimezone:
            calendar = [NSCalendar timezoneCalendar];
            break;
        case NSCalendarTypeGMT:
            calendar = [NSCalendar GMTCalendar];
            break;
        default:
            calendar = [NSCalendar currentCalendar];
            break;
    }
    NSMutableArray *monthList = [NSMutableArray array];
    NSDate *monthFirstDate = nil;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&monthFirstDate interval:NULL forDate:self];
    [monthList addObjectsFromArray:[monthFirstDate getDateWeekArray:calendarType]];
    NSInteger int1 = [[monthFirstDate formatterStyle:@"yyyyMM" styleType:DateFormatterTypeCustom calendarType:calendarType] integerValue];
    for(int i = 1; ; i++)
    {
        NSDate *date = [monthFirstDate getDateByYear:0 month:0 day:i*7 hour:0 minute:0 second:0 getDatetype:GetDateTypeAddSubtract calendarType:calendarType];
        NSMutableArray *weekList = [date getDateWeekArray:calendarType];
        NSInteger int2 = [[[weekList objectAtIndex:0] formatterStyle:@"yyyyMM" styleType:DateFormatterTypeCustom calendarType:calendarType] integerValue];
        if(int1 != int2)
        {	break;}
        [monthList addObjectsFromArray:weekList];
    }
    NSArray *sortArray = [monthList sortedArrayUsingSelector:@selector(compare:)];
    [monthList removeAllObjects];
    [monthList addObjectsFromArray:sortArray];
    
    return monthList;
}





@end