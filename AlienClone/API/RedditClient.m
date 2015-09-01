//
//  RedditClient.m
//  AlienClone
//
//  Created by Charlie Massry on 7/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "RedditClient.h"
#import "Post.h"
#import "Comment.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDWebImageManager.h>

static NSString *BASE_URL = @"https://www.reddit.com/";

@implementation RedditClient

+ (void)getFeedWithSuccessBlock:(PostsSuccessBlock)successBlock andFailure:(FailureBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@/.json", BASE_URL];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *posts = [Post postsWithJSON:responseObject[@"data"][@"children"]];
        successBlock(posts);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getSubRedditFeed:(NSString *)subReddit withSuccessBlock:(PostsSuccessBlock)successBlock andFailure:(FailureBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@/r/%@.json", BASE_URL, subReddit];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *posts = [Post postsWithJSON:responseObject[@"data"][@"children"]];
        successBlock(posts);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}

+(void)getImageForPost:(Post *)post progress:(ImageProgressBlock)progress success:(ImageSuccessBlock)success failure:(FailureBlock)failure {
    [[SDWebImageManager sharedManager] downloadImageWithURL:post.imageURL
                                                    options:0
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       CGFloat percentDone = ((CGFloat)receivedSize / (CGFloat)expectedSize);
                                                       progress(percentDone);
                                                   } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                       if (finished) {
                                                           if (error) {
                                                               failure(error);
                                                           } else {
                                                               success(image);
                                                           }
                                                       }
                                                   }];
}

+(void)getCommentsForPost:(Post *)post success:(PostSuccessBlock)success failure:(FailureBlock)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@.json", BASE_URL, post.postId];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Post *post = [[Post alloc] initWithJSON:responseObject[@"data"][@"children"][0][@"data"]];
        NSArray *comments = [Comment commentsWithJSON:responseObject[@"data"][@"something_else"]];
        success(post, comments);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
