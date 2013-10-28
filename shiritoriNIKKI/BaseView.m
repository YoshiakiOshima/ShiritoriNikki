//
//  BaseView.m
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/10.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView


- (void)awakeFromNib {
    //    self = [super init];
    if (self) {
        self.shiritori=[[Shiritori alloc] init];
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        self.calendar = calendar;
        calendar.delegate = self;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
//        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [self.dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        self.minimumDate = [self.dateFormatter dateFromString:@"2013年01月01日"];
        
//        self.disabledDates = @[
//                               [self.dateFormatter dateFromString:@"2013年01月05日"],
//                               [self.dateFormatter dateFromString:@"2013年01月06日"],
//                               [self.dateFormatter dateFromString:@"2013年01月07日"]
//                               ];
        
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        
        calendar.frame = CGRectMake(10, 20, 300, 320);
        [self addSubview:calendar];
        
//        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.bounds.size.width, 24)];
//        [self addSubview:self.dateLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
    //    return self;
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        //なんか最初に設定してた日にち。タッチ不能っぽい。
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    //追加
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendar.backgroundColor = [UIColor magentaColor];
        return YES;
    } else {
        self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
//    co(@"calendar layout: %@", NSStringFromCGRect(frame));
}

@end
