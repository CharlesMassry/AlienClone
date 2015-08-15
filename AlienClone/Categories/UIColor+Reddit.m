//
//  UIColor+Reddit.m
//  AlienClone
//
//  Created by Charlie Massry on 8/15/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "UIColor+Reddit.h"

@implementation UIColor (Reddit)
+(instancetype)redditBlue {
    return [self.class colorWithRed:(206/255.0) green:(227/255.0) blue:(248/255.0) alpha:1];
}

+(instancetype)redditOrange {
    return [self.class colorWithRed:(255/255.0) green:(69/255.0) blue:(0/255.0) alpha:1];
}
@end
