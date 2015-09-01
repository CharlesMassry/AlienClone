//
//  ThumbnailViewController.h
//  AlienClone
//
//  Created by Charlie Massry on 8/17/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Post;

@interface ImageViewController : UIViewController
@property (strong, nonatomic) Post *post;
-(instancetype) initWithPost:(Post *)post;
@end
