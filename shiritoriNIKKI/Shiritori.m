//
//  Shiritori.m
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/12.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import "Shiritori.h"
#import "BaseView.h"

@implementation Shiritori {
    BaseView *baseView;
}

- (int)startStringCode:(NSString *)string {
    //    long n=string.length;
    NSString *atama=[string substringToIndex:1];
//    NSLog(@"%@",atama);
    
    NSMutableString *uniString=[[NSMutableString alloc] init];
    unichar code=[atama characterAtIndex:0];
    [uniString appendFormat:@"%04x",code];
    //    NSLog(@"%@",uniString);
    NSScanner *uniStringScanner=[NSScanner scannerWithString:uniString];
    unsigned int stringValue;
    [uniStringScanner scanHexInt:&stringValue];
    
    return stringValue;
    
}

- (int)endStringCode:(NSString *)string {
    long n=string.length;
    NSString *shiri=[string substringFromIndex:n-1];
//    NSLog(@"%@",shiri);
    
    NSMutableString *uniString=[[NSMutableString alloc] init];
    unichar code=[shiri characterAtIndex:0];
    [uniString appendFormat:@"%04x",code];
    //    NSLog(@"%@",uniString);
    NSScanner *uniStringScanner=[NSScanner scannerWithString:uniString];
    unsigned int stringValue;
    [uniStringScanner scanHexInt:&stringValue];
    
    return stringValue;
}

- (BOOL)nextDayTitleExist:(NSString *)string {
    baseView=[[BaseView alloc] init];
    if ([string intValue]==[baseView.todayString intValue]) {
        if ([baseView.titleUD objectForKey:[NSString stringWithFormat:@"%@",baseView.tomorrowString]]) {
            return YES;
        }else {
            return NO;
        }
    }if ([string intValue]==[baseView.yesterdayString intValue]) {
        if ([baseView.titleUD objectForKey:[NSString stringWithFormat:@"%@",baseView.todayString]]) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)backDayTitleExist:(NSString *)string {
    baseView=[[BaseView alloc] init];
    NSLog(@"%d",[baseView.todayString intValue]);
    if ([string intValue]==[baseView.todayString intValue]) {
        if ([baseView.titleUD objectForKey:[NSString stringWithFormat:@"%@",baseView.yesterdayString]]) {
            return YES;
        }else {
            return NO;
        }
    }if ([string intValue]==[baseView.beforeYesterdayString intValue]) {
        if ([baseView.titleUD objectForKey:[NSString stringWithFormat:@"%@",baseView.beforeYesterdayString]]) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}


@end
