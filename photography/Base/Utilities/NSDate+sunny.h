//
//  NSDate+sunny.h
//  SpeakOut
//
//  Created by suning on 13-12-10.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (sunny)
- (NSInteger) year;
- (NSInteger) month;
- (NSInteger) day;
- (NSInteger) hour;
- (NSInteger) minute;
- (NSInteger) second;
- (NSInteger) weekDay;
- (NSInteger) yearForWeekOfYear;
- (NSInteger) weekOfYear;
- (NSInteger) weekOfMonth;

- (NSDateComponents*) dateComponents;

// 两个日期之间的比较，精确到 年 月 日
- (NSComparisonResult) compareDate:(NSDate*) date;
// 和上一个比较结果相反，与compare一致
- (NSComparisonResult) compareDate2: (NSDate *)date;
- (BOOL) isTodayDate;

// 两个日期之间的天数差，>0表示现在的时间在lastDate之后
- (NSInteger) daysOverLastDate:(NSDate*) date;

- (NSDate *)dateAtHour:(NSInteger)hour minute:(NSInteger)minute;

- (NSDate *)yesterday;

- (NSDate *)tomorrow;


@end
