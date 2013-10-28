//
//  BaseView.h
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/10.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "Shiritori.h"

@interface BaseView : UIView<CKCalendarDelegate>

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

//追加
@property Shiritori *shiritori;

@property NSString *todayString;
@property NSString *yesterdayString;
@property NSString *tomorrowString;
@property NSString *beforeYesterdayString;
@property NSString *pushDayString;
@property NSUserDefaults *ifNillUD;
@property NSUserDefaults *titleUD;
@property NSUserDefaults *detileUD;
@property NSUserDefaults *goonUD;
@property UIButton *OKBtn;
@property UIButton *editBtn;


@end
