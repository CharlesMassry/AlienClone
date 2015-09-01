//
//  PostCell.m
//  AlienClone
//
//  Created by Charlie Massry on 7/6/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import <RegExCategories.h>
#import "NSString+CellDimensions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FontAwesomeKit/FontAwesomeKit.h>


@interface PostCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLeadingConstraint;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *subRedditLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreIcon;
@property (weak, nonatomic) IBOutlet UILabel *commentsIcon;
@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
//}

-(void)setPost:(Post *)post {
    _post = post;
    if (_post) {
        self.titleLabel.text = _post.title;
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, [_post.title cellHeight]);

        FAKFontAwesome *fireIcon = [FAKFontAwesome fireIconWithSize:10];
        FAKFontAwesome *commentIcon = [FAKFontAwesome commentIconWithSize:10];
        self.commentsIcon.attributedText = commentIcon.attributedString;
        self.scoreIcon.attributedText = fireIcon.attributedString;

        self.scoreLabel.text = [NSString stringWithFormat:@"%lu", _post.score];
        self.commentsLabel.text = [NSString stringWithFormat:@"%lu", _post.commentsCount];

        self.authorLabel.text = _post.author;
        self.authorLabel.frame = CGRectMake(self.authorLabel.frame.origin.x, self.authorLabel.frame.origin.y, [_post.author cellWidth], self.authorLabel.frame.size.height);

        self.subRedditLabel.text = _post.subreddit;

        CGFloat constantConstraint = 79;

        self.thumbnailView.image = nil;
        if ([_post.thumbnailURLString isMatch:RX(@"^http")]) {
            [self.thumbnailView sd_setImageWithURL:_post.thumbnailURL];
            self.detailLeadingConstraint.constant = constantConstraint + 10;
            self.titleLeadingConstraint.constant = constantConstraint;
        } else {
            self.thumbnailView.image = nil;
            self.detailLeadingConstraint.constant = 10;
            self.titleLeadingConstraint.constant = 0;
        }
    }
}

- (IBAction)thumbnailTapped:(id)sender {
    [self.delegate didSelectThumbnailViewForPost:self.post];
}

- (IBAction)titleLabelTapped:(id)sender {
    [self.delegate didSelectTitleLabelForPost:self.post];
}

- (IBAction)commentsLabelTapped:(id)sender {
    [self.delegate didSelectCommentsLabelForPost:self.post];
}

- (IBAction)authorLabelTapped:(id)sender {
    [self.delegate didSelectAuthorLabelForPost:self.post];
}

- (IBAction)subRedditLabel:(id)sender {
    [self.delegate didSelectSubRedditLabelForPost:self.post];
}

@end
