//
//  ThumbnailViewController.m
//  AlienClone
//
//  Created by Charlie Massry on 8/17/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "ImageViewController.h"
#import "Post.h"
#import "RedditClient.h"
#import "UIColor+Reddit.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ImageViewController

-(instancetype)initWithPost:(Post *)post {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.post = post;
        self.scrollView.delegate = self;
        self.scrollView.minimumZoomScale = 0.5;
        self.scrollView.maximumZoomScale = 4.0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading Image", nil)];
    [RedditClient getImageForPost:self.post
                         progress:^(CGFloat percentDone) {
                             self.progressView.progress = percentDone;
                        } success:^(UIImage *image) {
                            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                            self.scrollView.contentSize = image.size;
                            [self.scrollView addSubview:imageView];
                            [self.progressView removeFromSuperview];
                            [SVProgressHUD dismiss];
                        } failure:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                        }];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView.subviews firstObject];
}

@end
