//
//  RedditClient.m
//  AlienClone
//
//  Created by Charlie Massry on 7/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "RedditClient.h"
#import <AFNetworking/AFNetworking.h>
#import "Post.h"

static NSString *BASE_URL = @"http://api.reddit.com";

@implementation RedditClient

+ (void)getFeedWithSuccessBlock:(SuccessBlock)successBlock andFailure:(FailureBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:BASE_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *posts = [Post postsWithJSON:responseObject[@"data"][@"children"]];
        successBlock(posts);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void) getImageFromURL:(NSURL *)url withSuccess:(SuccessBlock)successBlock andFailure:(FailureBlock)failureBlock {
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    [requestOperation start];
}

@end
