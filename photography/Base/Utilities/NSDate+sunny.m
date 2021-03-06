//
//  NSDate+sunny.m
//  SpeakOut
//
//  Created by suning on 13-12-10.
//
//

#import "NSDate+sunny.h"

@implementation NSDate (sunny)
- (NSInteger) year {
    
    NSDateComponents* components = [self dateComponents];
    return [components year];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) month {
    NSDateComponents* components = [self dateComponents];
    return [components month];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) day {
    NSDateComponents* components = [self dateComponents];
    return [components day];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) hour {
    NSDateComponents* components = [self dateComponents];
    return [components hour];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) minute {
    NSDateComponents* components = [self dateComponents];
    return [components minute];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) second {
    NSDateComponents* components = [self dateComponents];
    return [components second];
}

- (NSInteger) weekDay {
    NSDateComponents* components = [self dateComponents];
    return [components weekday];
}

- (NSInteger) yearForWeekOfYear {
    NSDateComponents* components = [self dateComponents];
    return [components yearForWeekOfYear];
}

- (NSInteger) weekOfYear {
    NSDateComponents* components = [self dateComponents];
    return [components weekOfYear];
}

- (NSInteger) weekOfMonth {
    NSDateComponents* components = [self dateComponents];
    return [components weekOfMonth];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDateComponents*) dateComponents {
    
    static dispatch_once_t onceToken;
    static NSCalendar *calendar;
    static NSInteger unitFlags;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitYearForWeekOfYear;
    
    });
    
    NSDateComponents *sharedComponents = [calendar components:unitFlags fromDate: self];;
    return sharedComponents;
}

- (BOOL) isTodayDate {
    return [self compareDate: [NSDate date]] == NSOrderedSame;
}



// TODO: 左操作数比右操作数大称为Ascending，不太好
//
// 如果当前的日期比给定的date大，则返回: NSOrderedAscending
//
- (NSComparisonResult) compareDate:(NSDate*) date {
    // 比较两个日期是不是同一天
    
    NSDateComponents *comps1 = [self dateComponents];
    NSDateComponents *comps2 = [date dateComponents];
    NSInteger selfIntValue = [comps1 year]*10000 + [comps1 month]*100 + [comps1 day];
    NSInteger dateIntValue = [comps2 year]*10000 + [comps2 month]*100 + [comps2 day];
    
    if (selfIntValue > dateIntValue) {
        return NSOrderedDescending;
    } else if(selfIntValue < dateIntValue){
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult)compareDate2:(NSDate *)date {
    return [date compareDate:self];
}

- (NSInteger) daysOverLastDate:(NSDate*) date {
    NSDateFormatter* formattor = [[NSDateFormatter alloc] init];
    [formattor setDateFormat: @"yyyy-MM-dd"];
    NSString* dateStr = [NSString stringWithFormat: @"%@ 00:00:00", [formattor stringFromDate: self]];
    NSString* lastDateStr = [NSString stringWithFormat: @"%@ 00:00:00", [formattor stringFromDate: date]];
    
    NSDateFormatter* newFormattor = [[NSDateFormatter alloc] init];
    [newFormattor setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* newDate = [newFormattor dateFromString: dateStr];
    NSDate* lastNewDate = [newFormattor dateFromString: lastDateStr];
    
    NSTimeInterval time = [newDate timeIntervalSinceDate: lastNewDate];
    return (NSInteger)(time+1)/(24*60*60);
}


- (NSDate *)dateAtHour:(NSInteger)hour minute:(NSInteger)minute {
    NSDateComponents *comps = [self dateComponents];
    [comps setHour:hour];
    [comps setMinute:minute];    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [calendar dateFromComponents:comps];
}

- (NSDate *)yesterday {
    return [NSDate dateWithTimeInterval:-24*3600 sinceDate:self];
}

- (NSDate *)tomorrow {
    return [NSDate dateWithTimeInterval:24*3600 sinceDate:self];
}



@end
