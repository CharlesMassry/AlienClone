//
//  NSString+CellDimensions.m
//  CharlieMassry
//
//  Created by Charlie Massry on 8/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "NSString+CellDimensions.h"

@implementation NSString (CellDimensions)
-(CGFloat)cellHeight {
    CGRect textRect = [self cellRect];
    
    return textRect.size.height;
}

-(CGFloat)cellWidth {
    CGRect textRect = [self cellRect];
    return textRect.size.width;
}

-(CGRect)cellRect {
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGRect textRect = [self boundingRectWithSize:maximumLabelSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}
                                         context:nil];
    return textRect;
}
@end
