//
//  CommentsViewController.h
//  AlienClone
//
//  Created by Charlie Massry on 8/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Post;

@interface CommentsViewController : UITableViewController
-(instancetype)initWithPost:(Post *)post;
@end
