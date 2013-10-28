//
//  MoreView.m
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/11.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView {
//    NSString *_todayString;
//    NSString *_yesterdayString;
//    NSString *_pushDayString;
    UIImage *img;
    UIImage *nilImg;
    UIImage *kannryouIng;
    UIImage *hennshuuImg;
    UIImage *krImg;
    UIImage *hsImg;
    UIButton *coverBtn2;
    UIButton *infoBtn;
    UIButton *webBtn;
    UITextView *textView;
    UIView *choiceView;
    UIButton *shiritoriEditBtn;
    UIButton *detailEditBtn;
    UIButton *anotherBtn;
    UIView *accessoryView;
    UIAlertView *alert;
    int shortSize;
    int shortSize2;
    int shortSize3;
}


- (void)awakeFromNib {
    [self todayAndYesterday];
    [super awakeFromNib];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height==480) {
        shortSize=19;
        shortSize2=13;
        shortSize3=88;
    }else {
        shortSize=0;
        shortSize2=0;
        shortSize3=0;
    }
    
    img=[UIImage imageNamed:@"up4.png"];
    nilImg=[UIImage imageNamed:@"nil1.png"];
    kannryouIng=[UIImage imageNamed:@"kr3.png"];
    krImg=[UIImage imageNamed:@"kr4.png"];
    hennshuuImg=[UIImage imageNamed:@"hs5.png"];
    hsImg=[UIImage imageNamed:@"hs6.png"];
    [self.watchBtn setBackgroundImage:img forState:UIControlStateNormal];
//    UIImageView *iv=[[UIImageView alloc] initWithImage:img];
    
    self.helpView=[[UIView alloc] initWithFrame:CGRectMake(0, 390, 320, 178)];
    self.helpView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:0.6 alpha:1];
    [self addSubview:self.helpView];
    
    self.scroller=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 390, 320, 428)];
    self.scroller.contentSize=CGSizeMake(320, 568);
    self.scroller.backgroundColor=[UIColor colorWithRed:0.6 green:1 blue:0.4 alpha:0.9];
//    self.scroller.alpha=0.9;
    [self addSubview:self.scroller];
    
    coverBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn2.frame=CGRectMake(0, 390, 320, 178);
    [coverBtn2 addTarget:self action:@selector(pushWatchBtn:) forControlEvents:UIControlEventTouchUpInside];
//    coverBtn2.backgroundColor=[UIColor blackColor];
    [self addSubview:coverBtn2];
    

    //90
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(-200, 20, 140, 50)];
    self.dateLabel.textAlignment=NSTextAlignmentCenter;
    [_scroller addSubview:self.dateLabel];
    self.dateLabel.hidden=YES;
    
    self.ifNillUD=[NSUserDefaults standardUserDefaults];
    if ([self.ifNillUD objectForKey:@"beforeSelectedDate"]) {
        [self.ifNillUD removeObjectForKey:@"beforeSelectedDate"];
    }
    NSMutableDictionary *defaults=[NSMutableDictionary dictionary];
    [defaults setObject:[NSDate date] forKey:@"beforeSelectedDate"];
    [self.ifNillUD registerDefaults:defaults];
    self.dateLabel.text=[self.dateFormatter stringFromDate:[self.ifNillUD objectForKey:@"beforeSelectedDate"]];

    self.titleField=[[UITextField alloc] initWithFrame:CGRectMake(10, 20-shortSize, 300, 50-shortSize2)];
    self.titleField.borderStyle=UITextBorderStyleBezel;
    self.titleField.textColor=[UIColor blackColor];
    self.titleField.textAlignment=NSTextAlignmentCenter;
    
    self.titleField.returnKeyType=UIReturnKeyDone;
    self.titleField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.titleField addTarget:self action:@selector(finishedEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    self.titleField.delegate=self;
    [self.scroller addSubview:self.titleField];
    
    self.pushDayString=[self.myDateFormatter stringFromDate:[self.ifNillUD objectForKey:@"beforeSelectedDate"]];
//    NSLog(@"%@",self.todayString);
    
    self.titleUD=[NSUserDefaults standardUserDefaults];
    
    self.titleField.enabled=NO;
    
    self.editBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame=CGRectMake(113, 145, 70, 63);
//    [self.editBtn setTitle:@"編集" forState:UIControlStateNormal];
//    [self.editBtn setBackgroundColor:[UIColor blackColor]];
    [self.editBtn setBackgroundImage:hennshuuImg forState:UIControlStateNormal];
    [self.editBtn setBackgroundImage:hsImg forState:UIControlStateHighlighted];
    [self.editBtn addTarget:self action:@selector(pushEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroller addSubview:self.editBtn];
    self.editBtn.hidden=YES;
    
    self.OKBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.OKBtn.frame=CGRectMake(423, 0, 65, 51);
//    [self.OKBtn setTitle:@"完了" forState:UIControlStateNormal];
//    [self.OKBtn setBackgroundColor:[UIColor blackColor]];
    [self.OKBtn setBackgroundImage:kannryouIng forState:UIControlStateNormal];
    [self.OKBtn setBackgroundImage:krImg forState:UIControlStateHighlighted];
    [self.OKBtn addTarget:self action:@selector(pushOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroller addSubview:self.OKBtn];
    self.OKBtn.hidden=YES;
    
//    [self.shiritori startStringCode:@"あいう"];
    
    self.titleField.enabled=NO;
    
    self.goonUD=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *def=[NSMutableDictionary dictionary];
    [def setObject:[NSNumber numberWithInt:0] forKey:@"goon"];
    [def setObject:[NSNumber numberWithInt:0] forKey:@"maxGoon"];
    [self.goonUD registerDefaults:def];
    
    self.goonLbl.text=[NSString stringWithFormat:@"継続日数：%ld日",(long)[self firstCount]];
    
    self.titleField.text=[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.todayString]];
    
    self.coverBtn.hidden=YES;
    
    self.coverBtn.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    [self.coverBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    infoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame=CGRectMake(10, 20-shortSize, 140, 50-shortSize2);
    [infoBtn addTarget:self action:@selector(pushInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
    infoBtn.backgroundColor=[UIColor colorWithRed:0.85 green:1 blue:0.5 alpha:1];
    [infoBtn setTitle:@"使い方" forState:UIControlStateNormal];
    infoBtn.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    [infoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.helpView addSubview:infoBtn];
    
    webBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    webBtn.frame=CGRectMake(170, 20-shortSize, 140, 50-shortSize2);
    [webBtn addTarget:self action:@selector(pushWebBtn:) forControlEvents:UIControlEventTouchUpInside];
    webBtn.backgroundColor=[UIColor colorWithRed:0.85 green:1 blue:0.5 alpha:1];
    [webBtn setTitle:@"他のアプリ" forState:UIControlStateNormal];
    webBtn.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    [webBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    webBtn.titleLabel.textColor=[UIColor ]
    [self.helpView addSubview:webBtn];
    
    self.frontView.hidden=YES;
    
    infoBtn.hidden=YES;
    webBtn.hidden=YES;
    
    [self.helpBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.6 alpha:1]];
    
    
    accessoryView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//    [accessoryView setBackgroundColor:[UIColor whiteColor]];
    self.titleField.inputAccessoryView=accessoryView;
    
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame=CGRectMake(320-40, 40-40, 40, 40);
    [closeBtn setBackgroundColor:[UIColor grayColor]];
    [closeBtn setTitle:@"▼" forState:UIControlStateNormal];
    closeBtn.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    closeBtn.titleLabel.textColor=[UIColor whiteColor];
    [closeBtn addTarget:self action:@selector(closeBtnPushed:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:closeBtn];
    
    if ([self.titleUD objectForKey:self.yesterdayString]) {
        NSString *yesterdayStr=[self.titleUD objectForKey:self.yesterdayString];
        self.titleField.placeholder=[NSString stringWithFormat:@"先頭の文字は・・・[%@]",[yesterdayStr substringFromIndex:yesterdayStr.length-1]];
    }else {
        self.titleField.placeholder=@"自由に入力してください";
    }
    
    self.maxLbl.hidden=YES;
    
    textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 150, 300, 350-shortSize3)];
    textView.backgroundColor=[UIColor colorWithRed:0.6 green:1 blue:0.5 alpha:0.85];
    textView.font=[UIFont fontWithName:@"Helvetica" size:16];
    textView.editable=NO;
    [self.scroller addSubview:textView];
    
    accessoryView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    textView.inputAccessoryView=accessoryView;
    closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame=CGRectMake(320-40, 40-40, 40, 40);
    [closeBtn setBackgroundColor:[UIColor grayColor]];
    [closeBtn setTitle:@"▼" forState:UIControlStateNormal];
    closeBtn.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    closeBtn.titleLabel.textColor=[UIColor whiteColor];
    [closeBtn addTarget:self action:@selector(textViewsKeyClose:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:closeBtn];
    
    self.detileUD=[NSUserDefaults standardUserDefaults];
    
    if ([self.detileUD objectForKey:[NSString stringWithFormat:@"a%@",self.todayString]]) {
        textView.text=[self.detileUD objectForKey:[NSString stringWithFormat:@"a%@",self.todayString]];
    }
    
    choiceView=[[UIView alloc] initWithFrame:CGRectMake(30, 120, 260, 50)];
    [choiceView setBackgroundColor:[UIColor greenColor]];
    [self.scroller addSubview:choiceView];
    choiceView.hidden=YES;
    choiceView.transform=CGAffineTransformMakeScale(0.1, 0.1);
    choiceView.center=CGPointMake(50, 44);
    
    shiritoriEditBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shiritoriEditBtn.frame=CGRectMake(10, 10, 110, 30);
    [shiritoriEditBtn setBackgroundColor:[UIColor whiteColor]];
    [shiritoriEditBtn setTitle:@"しりとり編集" forState:UIControlStateNormal];
    [shiritoriEditBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shiritoriEditBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [shiritoriEditBtn addTarget:self action:@selector(writeTitle:) forControlEvents:UIControlEventTouchUpInside];
    [choiceView addSubview:shiritoriEditBtn];
    
    detailEditBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    detailEditBtn.frame=CGRectMake(140, 10, 110, 30);
    [detailEditBtn setBackgroundColor:[UIColor whiteColor]];
    [detailEditBtn setTitle:@"詳細編集" forState:UIControlStateNormal];
    [detailEditBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    detailEditBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [detailEditBtn addTarget:self action:@selector(writeText:) forControlEvents:UIControlEventTouchUpInside];
    [choiceView addSubview:detailEditBtn];
    
    anotherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    anotherBtn.frame=CGRectMake(0, 130, 320, 438);
//    [anotherBtn setBackgroundColor:[UIColor redColor]];
    [anotherBtn addTarget:self action:@selector(another:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroller addSubview:anotherBtn];
    anotherBtn.hidden=YES;
    
    accessoryView.hidden=YES;
    
//    stringMes=@"aaa";
    _nadView = [[NADView alloc] initWithFrame:CGRectMake(0.f, rect.size.height-50, NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
    // apiKey, spotID をセットする
    [_nadView setNendID:@"4bae65b7a0e8be7953defab3d16e13a4c4498a9f" spotID:@"101651"];
    // デリゲートオブジェクトの指定
    [_nadView setDelegate:self];
    // 広告のロードを開始
    [_nadView load];

    [self bringSubviewToFront:_nadView];
}

//----------------------------------------------------------------------------------------------------------------//

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    [super calendar:calendar didSelectDate:date];
    if (date==nil) {
        date=[self.ifNillUD objectForKey:@"beforeSelectedDate"];
    }else {
        [self.ifNillUD setObject:date forKey:@"beforeSelectedDate"];
    }
    self.pushDayString=[self pushDayString:date];
//    [self pushIsTodayOrYesterday];
    self.titleField.text=[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
    [self holder:self.pushDayString];
    if ([self.detileUD objectForKey:[NSString stringWithFormat:@"a%@",self.pushDayString]]) {
        textView.text=[self.detileUD objectForKey:[NSString stringWithFormat:@"a%@",self.pushDayString]];
    }else {
        textView.text=nil;
    }
}

- (NSString *)pushDayString:(NSDate *)pushDate {
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags=NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    comps=[calendar components:flags fromDate:pushDate];
    
    NSInteger year=comps.year;
    NSInteger month=comps.month;
    NSInteger day=comps.day;
    NSString *str;
    if (month>=10 && day>=10) {
        str=[NSString stringWithFormat:@"%ld%ld%ld",(long)year,(long)month,(long)day];
    }else if (month>=10) {
        str=[NSString stringWithFormat:@"%ld%ld0%ld",(long)year,(long)month,(long)day];
    }else if (day>=10) {
        str=[NSString stringWithFormat:@"%ld0%ld%ld",(long)year,(long)month,(long)day];
    }else {
        str=[NSString stringWithFormat:@"%ld0%ld0%ld",(long)year,(long)month,(long)day];
    }
    return str;
}

- (void)todayAndYesterday {
    self.myDateFormatter=[[NSDateFormatter alloc] init];
    self.myDateFormatter.dateFormat=@"yyyyMMdd";
    self.todayString=[self.myDateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"%@",todayString);
    
//    NSDateFormatter *yesterdayDf=[[NSDateFormatter alloc] init];
//    yesterdayDf.dateFormat=@"yyyyMMdd";
    self.yesterdayString=[self.myDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600*24]];
//    NSLog(@"%@",yesterdayString);
    self.beforeYesterdayString=[self.myDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600*48]];
    self.tomorrowString=[self.myDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:3600*24]];
    
//    self.todayString=todayString;
//    self.yesterdayString=yesterdayString;
    
//    NSLog(@"%@",self.beforeYesterdayString);
}

- (BOOL)pushIsTodayOrYesterday {
    if ([self.pushDayString intValue]==[self.todayString intValue] || [self.pushDayString intValue]==[self.yesterdayString intValue]){
        return YES;
    }else {
        return NO;
    }
}

- (IBAction)pushWatchBtn:(id)sender {
//    self.dateLabel.hidden=NO;
    coverBtn2.hidden=YES;
    self.OKBtn.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
//        _scroller.center=CGPointMake(_scCenterX, _scCenterY-300);
        _scroller.frame=CGRectMake(0, 0, 320, 568);
        self.titleField.center=CGPointMake(160, 105);
        self.dateLabel.hidden=NO;
        self.dateLabel.center=CGPointMake(160, 42.5);
        self.editBtn.center=CGPointMake(50, 44);
        self.OKBtn.center=CGPointMake(270, 42.5);
        
    }completion:^(BOOL finished){
//        self.dateLabel.hidden=NO;
    }];
    if ([self pushIsTodayOrYesterday]) {
//        NSLog(@"編集可能");
//        self.titleField.enabled=YES;
        self.editBtn.hidden=NO;
        if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.yesterdayString]] && [self.yesterdayString intValue]!=[self.pushDayString intValue]) {
            //昨日の日記から入力させる
            self.titleField.enabled=NO;
        }
    }else {
//        NSLog(@"編集不可能");
        self.titleField.enabled=NO;
        self.editBtn.hidden=YES;
    }
}

- (IBAction)pushHelpBtn:(id)sender {
    [self bringSubviewToFront:self.helpView];
    [self bringSubviewToFront:_nadView];
    self.coverBtn.hidden=NO;
    [self.watchBtn setBackgroundImage:nilImg forState:UIControlStateNormal];
    [self.coverBtn setTitle:@"日記" forState:UIControlStateNormal];
    infoBtn.hidden=NO;
    webBtn.hidden=NO;
    self.maxLbl.hidden=YES;
    self.helpView.hidden=NO;
}

- (IBAction)pushCoverBtn:(id)sender {
    [self bringSubviewToFront:self.scroller];
    [self bringSubviewToFront:_nadView];
    self.coverBtn.hidden=YES;
    [self.watchBtn setBackgroundImage:img forState:UIControlStateNormal];
    coverBtn2.hidden=NO;
    [self bringSubviewToFront:coverBtn2];
    [self bringSubviewToFront:_nadView];
    infoBtn.hidden=YES;
    webBtn.hidden=YES;
    self.scroller.hidden=NO;
    self.maxLbl.hidden=YES;
}

//- (void)pushCover2Btn:(UIButton *)btn {
//    
//}

- (BOOL)finishedEdit:(UITextField *)textField {
    self.editBtn.hidden=NO;
    self.OKBtn.hidden=NO;
    self.titleField.enabled=NO;
    textField.text=[self textCheck:textField.text];
    if ([textField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]==0) {
        return NO;
    }
    if ([textField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]>30) {
        textField.text=[self missShiritori:textField.text];
        return NO;
    }
    NSString *yourString=textField.text;
    int startCode=[self.shiritori startStringCode:yourString];
    int endCode=[self.shiritori endStringCode:yourString];
    //今日の日記を入力するとき
    if ([self.pushDayString intValue]==[self.todayString intValue]) {
        if (startCode==[self.shiritori endStringCode:[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.yesterdayString]]] && [self useUnicode:yourString]) {
//NSLog(@"今日の編集完了");
            self.goonLbl.text=[NSString stringWithFormat:@"継続日数：%ld日",(long)[self goonDate]];
//            [self.titleUD setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
            [self.titleUD setObject:[NSString stringWithFormat:@"%@",[self textCheck:textField.text]] forKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
        }else {
//NSLog(@"しりとり失敗");
            [self showAlert:@"しりとりができません"];
            textField.text=[self missShiritori:yourString];
            return NO;
        }
    }
    //昨日の日記を入力するとき
    if ([self.pushDayString intValue]==[self.yesterdayString intValue]) {
        if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.todayString]]) {
//NSLog(@"今日の日記は未記入");
            if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.beforeYesterdayString]] && [self useUnicode:yourString]) {
//NSLog(@"しりとり１日目（昨日の編集完了）");
                self.goonLbl.text=[NSString stringWithFormat:@"継続日数：%ld日",(long)[self goonDate]];
                [self.titleUD setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
            }else {
//NSLog(@"昨日の前の日記は記入されている");
                if (startCode==[self.shiritori endStringCode:[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.beforeYesterdayString]]] && [self useUnicode:yourString]) {
//NSLog(@"昨日の編集完了");
                    self.goonLbl.text=[NSString stringWithFormat:@"継続日数：%ld日",(long)[self goonDate]];
                    [self.titleUD setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
                }else {
//NSLog(@"しりとり失敗");
                    [self showAlert:@"しりとりができません"];
                    textField.text=[self missShiritori:yourString];
                    return NO;
                }
            }
        }else {
//NSLog(@"今日の日記は記入済み");
            if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.beforeYesterdayString]]) {
                if (endCode==[self.shiritori startStringCode:[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.todayString]]] && [self useUnicode:yourString]) {
//NSLog(@"昨日の編集完了（昨日の前の日記無し）");
                    self.goonLbl.text=[NSString stringWithFormat:@"継続日数%ld日",(long)[self goonDate]];
                    [self.titleUD setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
                }else {
//NSLog(@"しりとり失敗（昨日の前の日記無し）");
                    [self showAlert:@"しりとりができません"];
                    textField.text=[self missShiritori:yourString];
                    return NO;
                }
            }else {
                if (startCode==[self.shiritori endStringCode:[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.beforeYesterdayString]]] && endCode==[self.shiritori startStringCode:[self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.todayString]]] && [self useUnicode:yourString]) {
//NSLog(@"昨日の編集完了（昨日の前の日記有り）");
                    self.goonLbl.text=[NSString stringWithFormat:@"継続日数%ld日",(long)[self goonDate]];
                    [self.titleUD setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
                }else {
//NSLog(@"しりとり失敗（昨日の前の日記有り）");
                    [self showAlert:@"しりとりができません"];
                    textField.text=[self missShiritori:yourString];
                    return NO;
                }
            }
        }
    }
    [self.titleUD synchronize];
    return YES;
}

- (void)pushEditBtn:(UIButton *)btn {
    if (![self.titleUD objectForKey:self.yesterdayString] && [self.pushDayString intValue]==[self.todayString intValue]) {
        [self showAlert:@"昨日の日記が入力されていないので、まずカレンダーで昨日の日にちを選んで昨日のしりとりから入力しましょう"];
    }else {
        self.editBtn.hidden=YES;
        choiceView.hidden=NO;
        anotherBtn.hidden=NO;
        self.OKBtn.hidden=YES;
        [UIView animateWithDuration:0.4 animations:^{
            choiceView.transform=CGAffineTransformMakeScale(1, 1.2);
            choiceView.center=CGPointMake(160, 100);
        }completion:nil];
    }
}

- (void)pushOKBtn:(UIButton *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        self.scroller.frame=CGRectMake(0, 390, 320, 428);
        self.editBtn.center=CGPointMake(150, 250);
        self.OKBtn.center=CGPointMake(430, 20);
        self.dateLabel.center=CGPointMake(-130, 33);
        self.titleField.center=CGPointMake(160, 46-shortSize2-shortSize2);
    }completion:^(BOOL finished){
        self.editBtn.hidden=YES;
        self.OKBtn.hidden=YES;
        self.dateLabel.hidden=YES;
    }];
    self.titleField.enabled=NO;
    coverBtn2.hidden=NO;
    [self bringSubviewToFront:coverBtn2];
    [self bringSubviewToFront:_nadView];
    
}

- (NSInteger)goonDate {
    if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.pushDayString]]) {
        NSInteger goonNum=[self.goonUD integerForKey:@"goon"];
        goonNum++;
        [self.goonUD setInteger:goonNum forKey:@"goon"];
        if (goonNum>=[self.goonUD integerForKey:@"maxGoon"]) {
            [self.goonUD setInteger:goonNum forKey:@"maxGoon"];
        }
        self.maxLbl.text=[NSString stringWithFormat:@"最高継続日数：%ld日",(long)[self.goonUD integerForKey:@"maxGoon"]];
        [self.goonUD synchronize];
    }
    return [self.goonUD integerForKey:@"goon"];
}

- (NSInteger)deleteNIKKI {
    NSInteger goonNum=[self.goonUD integerForKey:@"goon"];
    goonNum--;
    [self.goonUD setInteger:goonNum forKey:@"goon"];
    [self.goonUD synchronize];
    return [self.goonUD integerForKey:@"goon"];
}

- (NSInteger)firstCount {
    NSInteger goonNum;
    if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.beforeYesterdayString]]) {
        if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.yesterdayString]]) {
            if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.todayString]]) {
                goonNum=0;
                [self.goonUD integerForKey:@"goon"];
                self.maxLbl.text=[NSString stringWithFormat:@"最高継続日数：%ld",(long)[self.goonUD integerForKey:@"maxGoon"]];
                return goonNum;
            }else {
                goonNum=[self.goonUD integerForKey:@"goon"];
            }
        }else {
            goonNum=[self.goonUD integerForKey:@"goon"];
        }
    }else {
        goonNum=[self.goonUD integerForKey:@"goon"];
    }
    self.maxLbl.text=[NSString stringWithFormat:@"最高継続日数：%ld日",(long)[self.goonUD integerForKey:@"maxGoon"]];
    return goonNum;
}

- (NSString *)textCheck:(NSString *)text {
//    NSString *string;
    if ([text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]==0) {
        //0
        if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.pushDayString]]) {
            return nil;
        }else {
            return [self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
        }
    }else {
        return text;
    }
}

- (NSString *)missShiritori:(NSString *)text {
    if ([self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.pushDayString]]) {
        return [self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.pushDayString]];
    }else {
        return nil;
    }
}

- (IBAction)pushClose:(id)sender {
    self.frontView.hidden=YES;
}

- (void)pushInfoBtn:(UIButton *)btn {
    [self bringSubviewToFront:self.frontView];
    [self bringSubviewToFront:_nadView];
    self.frontView.hidden=NO;
}

- (void)pushWebBtn:(UIButton *)btn {
    NSString *urlString=@"http://yoodev.web.fc2.com/app.html";
    NSURL *url=[NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)closeBtnPushed:(UIButton *)btn {
    [self.titleField resignFirstResponder];
    [self finishedEdit:self.titleField];
    accessoryView.hidden=YES;
}

- (void)holder:(NSString *)string {
    if ([string intValue]==[self.todayString intValue]) {
        if ([self.titleUD objectForKey:self.yesterdayString]) {
            NSString *yesterdayStr=[self.titleUD objectForKey:self.yesterdayString];
            self.titleField.placeholder=[NSString stringWithFormat:@"先頭の文字は・・・[%@]",[yesterdayStr substringFromIndex:yesterdayStr.length-1]];
        }else {
            self.titleField.placeholder=@"自由に入力してください";
        }
    }else if ([string intValue]==[self.yesterdayString intValue]) {
        if ([self.titleUD objectForKey:self.beforeYesterdayString]) {
            NSString *befYesterdayStr=[self.titleUD objectForKey:self.beforeYesterdayString];
            self.titleField.placeholder=[NSString stringWithFormat:@"先頭の文字は・・・[%@]",[befYesterdayStr substringFromIndex:befYesterdayStr.length-1]];
        }else {
            self.titleField.placeholder=@"自由に入力してください";
        }
    }else {
        self.titleField.placeholder=@"入力不可";
    }
}

- (IBAction)maxPush:(id)sender {
    self.helpView.hidden=YES;
    self.scroller.hidden=YES;
    self.maxLbl.hidden=NO;
    self.coverBtn.hidden=NO;
    [self.watchBtn setBackgroundImage:nilImg forState:UIControlStateNormal];
    [self.coverBtn setTitle:@"日記" forState:UIControlStateNormal];
    coverBtn2.hidden=YES;
}


- (void)writeText:(UIButton *)btn {
    if (![self.titleUD objectForKey:self.pushDayString]) {
        [self showAlert:@"しりとりから入力してください"];
    }else {
        anotherBtn.hidden=YES;
        textView.editable=YES;
        [UIView animateWithDuration:0.3 animations:^{
            textView.frame=CGRectMake(10, 65, 300, 230-shortSize3);
        }completion:nil];
        accessoryView.hidden=NO;
        [textView becomeFirstResponder];
        self.OKBtn.hidden=YES;
        [UIView animateWithDuration:0.4 animations:^{
            choiceView.center=self.editBtn.center;
            choiceView.transform=CGAffineTransformMakeScale(0.1, 0.1);
        }completion:^(BOOL finished){
            choiceView.hidden=YES;
        }];
    }
}

- (void)writeTitle:(UIButton *)btn {
    anotherBtn.hidden=YES;
    if (![self.titleUD objectForKey:[NSString stringWithFormat:@"%@",self.yesterdayString]] && [self.yesterdayString intValue]!=[self.pushDayString intValue]) {
        //前日の日記から入力させる。
        NSLog(@"昨日の日記を入力してください");
        //アラートビュー
    }else {
        self.titleField.enabled=YES;
        accessoryView.hidden=NO;
        [self.titleField becomeFirstResponder];
        self.OKBtn.hidden=YES;
    }
    [UIView animateWithDuration:0.4 animations:^{
        choiceView.center=self.editBtn.center;
        choiceView.transform=CGAffineTransformMakeScale(0.1, 0.1);
    }completion:^(BOOL finished){
        choiceView.hidden=YES;
    }];
}

- (void)another:(UIButton *)btn {
    anotherBtn.hidden=YES;
    [UIView animateWithDuration:0.4 animations:^{
        choiceView.center=self.editBtn.center;
        choiceView.transform=CGAffineTransformMakeScale(0.1, 0.1);
    }completion:^(BOOL finished){
        choiceView.hidden=YES;
        self.editBtn.hidden=NO;
        self.OKBtn.hidden=NO;
    }];
}

- (void)textViewsKeyClose:(UIButton *)btn {
    [textView resignFirstResponder];
    if ([textView hasText]) {
        [self.detileUD setObject:textView.text forKey:[NSString stringWithFormat:@"a%@",self.pushDayString]];
    }
    if ([self.detileUD objectForKey:[NSString stringWithFormat:@"a%@",self.pushDayString]]) {
        textView.text=[self.detileUD objectForKey:[NSString stringWithFormat:@"a%@",self.pushDayString]];
    }
    accessoryView.hidden=YES;
    textView.editable=NO;
    [UIView animateWithDuration:0.3 animations:^{
        textView.frame=CGRectMake(10, 150, 300, 350-shortSize3);
    }completion:^(BOOL finished){
        self.OKBtn.hidden=NO;
        self.editBtn.hidden=NO;
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

- (void)showAlert:(NSString *)str {
    alert=[[UIAlertView alloc] initWithTitle:@"しりとり日記" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [alert show];
}

- (BOOL)useUnicode:(NSString *)str {
    int endNumber=[self.shiritori endStringCode:str];
//    NSLog(@"%d",endNumber);
    if (endNumber>=12353 && endNumber<=12436) {
        //ひらがな
        return YES;
    }
    if (endNumber>=12449 && endNumber<=12538) {
        //カタカナ
        return YES;
    }
    if (endNumber>=19968 && endNumber<=40959) {
        //漢字
        return YES;
    }
    if ((endNumber>=65 && endNumber<=90) || (endNumber>=97 && endNumber<=122)) {
        //アルファベット
        return YES;
    }
    return NO;
}

//日記を書いた後に消してしまうとバグる
//前日の日記を変更するとバグる。前日の日記の編集時には当日の先頭の文字との合致が必要
//昨日の前が抜けた時点でカウントを０にする。OK?


//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}


//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    [adView setHidden:NO];
//    //    NSLog(@"show");
//}
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    [adView setHidden:YES];
//    //    NSLog(@"hidden");
//}


- (void)dealloc {
    [_nadView setDelegate:nil];
    _nadView=nil;
}

- (void)nadViewDidFinishLoad:(NADView *)adView
{
    // NADView を貼り付ける
    [self addSubview:_nadView];
}


@end
