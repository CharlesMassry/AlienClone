//
//  Comment.h
//  AlienClone
//
//  Created by Charlie Massry on 8/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSAttributedString *bodyHTML;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSString *commentId;
@property (strong, nonatomic) NSString *parentId;
@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSArray *childrenIds;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger gildedCount;
@property (nonatomic) BOOL edited;

+(NSArray *)commentsWithJSON:(NSArray *)JSONArray;
-(instancetype)initWithJSON:(NSDictionary *)JSON;
@end
