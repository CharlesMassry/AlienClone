//
//  Comment.m
//  AlienClone
//
//  Created by Charlie Massry on 8/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Comment.h"
#import <UIKit/UIKit.h>

@implementation Comment
+(NSArray *)commentsWithJSON:(NSArray *)JSONArray {
    NSMutableArray *comments = [[NSMutableArray alloc] init];
    for (NSDictionary *JSON in JSONArray) {
        Comment *comment = [[Comment alloc] initWithJSON:JSON];
        [comments addObject:comment];
    }
    return comments;
}

-(instancetype)initWithJSON:(NSDictionary *)JSON {
    self = [super init];

    if (self) {
        _author = JSON[@"author"];
        _body = JSON[@"body"];
        _bodyHTML = [[NSAttributedString alloc] initWithData:[JSON[@"body_html"] dataUsingEncoding:NSUTF8StringEncoding]
                                                     options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                          documentAttributes:nil
                                                       error:nil];
        _createdAt = [NSDate dateWithTimeIntervalSince1970:[JSON[@"created_at"] doubleValue]];
        _childrenIds = JSON[@"children"];
        _parentId = JSON[@"parent_id"];
        _score = [JSON[@"score"] integerValue];
        _gildedCount = [JSON[@"gilded"] integerValue];
        _edited = [JSON[@"edited"] isEqualToString:@"true"] ? YES : NO;
        
    }

    return self;
}
@end
