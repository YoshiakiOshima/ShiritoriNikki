//
//  MoreView.h
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/11.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import "BaseView.h"
#import <iAd/iAd.h>
#import "NADView.h"

@interface MoreView : BaseView<UITextFieldDelegate,UIAlertViewDelegate,ADBannerViewDelegate,NADViewDelegate>

@property (nonatomic, retain) NADView *nadView;
@property (weak, nonatomic) IBOutlet UIButton *watchBtn;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;
@property (weak, nonatomic) IBOutlet UIButton *coverBtn;
@property (weak, nonatomic) IBOutlet UILabel *goonLbl;
@property (weak, nonatomic) IBOutlet UIView *frontView;
@property (weak, nonatomic) IBOutlet UILabel *maxLbl;

@property UIView *helpView;
@property UIScrollView *scroller;
@property UITextField *titleField;
@property NSDateFormatter *myDateFormatter;


- (NSString *)pushDayString:(NSDate *)pushDate;
- (void)todayAndYesterday;
- (BOOL)pushIsTodayOrYesterday;
- (IBAction)pushWatchBtn:(id)sender;
- (IBAction)pushHelpBtn:(id)sender;
- (IBAction)pushCoverBtn:(id)sender;
//- (void)pushCover2Btn:(UIButton *)btn;
- (void)pushInfoBtn:(UIButton *)btn;
- (void)pushWebBtn:(UIButton *)btn;
- (BOOL)finishedEdit:(UITextField *)textField;
- (void)pushEditBtn:(UIButton *)btn;
- (void)pushOKBtn:(UIButton *)btn;
- (NSInteger)goonDate;
- (NSInteger)deleteNIKKI;
- (NSInteger)firstCount;
- (NSString *)textCheck:(NSString *)text;
- (NSString *)missShiritori:(NSString *)text;
- (IBAction)pushClose:(id)sender;
- (void)closeBtnPushed:(UIButton *)btn;
- (void)holder:(NSString *)string;
- (IBAction)maxPush:(id)sender;
- (void)textViewsKeyClose:(UIButton *)btn;
- (void)writeText:(UIButton *)btn;
- (void)writeTitle:(UIButton *)btn;
- (void)another:(UIButton *)btn;
- (void)showAlert:(NSString *)str;
- (BOOL)useUnicode:(NSString *)str;


@end
