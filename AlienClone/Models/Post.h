//
//  Post.h
//  AlienClone
//
//  Created by Charlie Massry on 7/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Post : NSObject
@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSString *subreddit;
@property (strong, nonatomic) NSString *subredditId;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *createdAt;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSUInteger commentsCount;
@property (strong, nonatomic) NSString *thumbnailURLString;
@property (strong, nonatomic) NSURL *thumbnailURL;

+(NSArray *)postsWithJSON:(NSArray *)JSONArray;
@end
