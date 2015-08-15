//
//  NSDate+Formatter.m
//  CharlieMassry
//
//  Created by Charlie Massry on 8/1/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "NSDate+Formatter.h"
#import <DateTools.h>

@implementation NSDate (Formatter)
-(NSString *)toFormattedDate {
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateBySubtractingDays:1];
    
    if ([self isLaterThan:yesterday]) {
        return [self timeAgoSinceNow];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        return [dateFormatter stringFromDate:self];
    }
}
@end
