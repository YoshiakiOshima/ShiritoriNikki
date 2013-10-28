//
//  Shiritori.h
//  shiritoriNIKKI
//
//  Created by OSHIMAYOSHIAKI on 2013/10/12.
//  Copyright (c) 2013年 OSHIMAYOSHIAKI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shiritori : NSObject


- (int)startStringCode:(NSString *)string;
- (int)endStringCode:(NSString *)string;
- (BOOL)nextDayTitleExist:(NSString *)string;
- (BOOL)backDayTitleExist:(NSString *)string;


@end
