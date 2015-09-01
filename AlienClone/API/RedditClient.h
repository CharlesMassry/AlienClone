//
//  RedditClient.h
//  AlienClone
//
//  Created by Charlie Massry on 7/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Post;
typedef void(^PostsSuccessBlock)(NSArray *posts);
typedef void(^FailureBlock)(NSError *error);
typedef void(^ImageProgressBlock)(CGFloat percentDone);
typedef void(^ImageSuccessBlock)(UIImage *image);
typedef void(^PostSuccessBlock)(Post *post, NSArray *comments);

@interface RedditClient : NSObject
+(void)getFeedWithSuccessBlock:(PostsSuccessBlock)block andFailure:(FailureBlock)failure;
+(void)getSubRedditFeed:(NSString *)subReddit withSuccessBlock:(PostsSuccessBlock)block andFailure:(FailureBlock)failure;
+(void)getImageForPost:(Post *)post progress:(ImageProgressBlock)progress success:(ImageSuccessBlock)success failure:(FailureBlock)failure;
+(void)getCommentsForPost:(Post *)post success:(PostSuccessBlock)success failure:(FailureBlock)failure;
@end
