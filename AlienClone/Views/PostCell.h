//
//  PostCell.h
//  AlienClone
//
//  Created by Charlie Massry on 7/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostCell : UITableViewCell
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@end
