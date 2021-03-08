//
//  NSString+Adapter.m
//  eia
//
//  Created by JimmyYue on 2020/7/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "NSString+Adapter.h"

@implementation NSString (Adapter)

- (NSString *)timeToyyyy_MM_dd {
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
     NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}


- (NSString *)timeToyyyyMMddHHmmssString {
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat =  @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}

@end
