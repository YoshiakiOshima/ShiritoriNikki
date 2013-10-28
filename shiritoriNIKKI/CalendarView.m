//
//  CalenderView.m
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/09.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView {
    CKCalendarView *_calendar;
    NSMutableArray *_chosenDates;
//    CalendarView *calendarView;
    NSDateFormatter *_dateFormatter;
    NSDate *_minimumDate;
    UILabel *_dateLabel;
}

- (id)init {
    NSLog(@"CalendarView");
    _calendar=[[CKCalendarView alloc] init];
    _calendar.frame = CGRectMake(10, 20, 300, 320);
    
    _calendar.onlyShowCurrentMonth=NO;
    _calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    _calendar.delegate=self;

    [self addSubview:_calendar];
    
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"dd/MM/yyyy"];
    _minimumDate = [_dateFormatter dateFromString:@"01/10/2013"];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_calendar.frame) + 4, self.bounds.size.width, 24)];
    [self addSubview:_dateLabel];
    
    self.backgroundColor = [UIColor whiteColor];
    
    _chosenDates=[NSMutableArray array];
    
//    _calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    return self;
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return  [calendar dateIsInCurrentMonth:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    [_chosenDates addObject:date];
}

- (void)calendar:(CKCalendarView *)calendar didDeselectDate:(NSDate *)date {
    NSLog(@"User didn't like date %@", date);
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    // Of course we want to let users change months...
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didChangeToMonth:(NSDate *)date {
    NSLog(@"Hurray, the user changed months!");
}

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // If the date has been chosen by the user, go ahead and style it differently
    if ([_chosenDates containsObject:date]) {
        dateItem.backgroundColor = [UIColor greenColor];
    }
}

@end
