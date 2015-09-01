//
//  PostCell.h
//  AlienClone
//
//  Created by Charlie Massry on 7/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Post;


@protocol PostCellDelegate <NSObject>

@required
- (void) didSelectTitleLabelForPost:(Post *)post;
- (void) didSelectThumbnailViewForPost:(Post *)post;
- (void) didSelectCommentsLabelForPost:(Post *)post;
- (void) didSelectAuthorLabelForPost:(Post *)post;
- (void) didSelectSubRedditLabelForPost:(Post *)post;
@end


@interface PostCell : UITableViewCell
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (nonatomic, assign) id <PostCellDelegate> delegate;
@end

