//
//  Post.m
//  AlienClone
//
//  Created by Charlie Massry on 7/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Post.h"
#import "RedditClient.h"
#import <RegExCategories.h>

@implementation Post
+(NSArray *)postsWithJSON:(NSArray *)JSONArray {
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *JSON in JSONArray) {
        Post *post = [[Post alloc] initWithJSON:JSON[@"data"]];
        [posts addObject:post];
    }
    
    return posts;
}

-(instancetype)initWithJSON:(NSDictionary *)JSON {
    self = [super init];
    
    if (self) {
        _postId = JSON[@"id"];
        _domain = JSON[@"domain"];
        _subreddit = JSON[@"subreddit"];
        _subredditId = JSON[@"subreddit_id"];
        _author = JSON[@"author"];
        _title = JSON[@"title"];
        _isSelfPost = JSON[@"is_self"];
        _createdAt = [NSDate dateWithTimeIntervalSince1970:[JSON[@"created"] doubleValue]];
        _score = [JSON[@"score"] integerValue];
        _commentsCount = [JSON[@"num_comments"] integerValue];
        _imageURLString = [JSON[@"preview"][@"images"] firstObject][@"source"][@"url"];
        _imageURL = [NSURL URLWithString:_imageURLString];
        _thumbnailURLString = JSON[@"thumbnail"];
        _thumbnailURL = [NSURL URLWithString:_thumbnailURLString];
        _linkURLString = JSON[@"url"];
        _linkURL = [NSURL URLWithString:_linkURLString];
        _isSelfPost = JSON[@"is_self"];
    }
    
    return self;
}
@end
