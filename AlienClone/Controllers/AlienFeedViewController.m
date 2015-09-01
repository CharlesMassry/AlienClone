//
//  AlienFeedViewController.m
//  AlienClone
//
//  Created by Charlie Massry on 7/4/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "AlienFeedViewController.h"
#import "RedditClient.h"
#import "NSString+CellDimensions.h"
#import "Post.h"
#import "PostCell.h"
#import "UIColor+Reddit.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSDate+Formatter.h"
#import "ImageViewController.h"
#import "LinkViewController.h"
#import "CommentsViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

@interface AlienFeedViewController () <PostCellDelegate>
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) NSDate *lastUpdated;
@end

@implementation AlienFeedViewController

static NSString *PostCellIdentifier = @"PostCell";

-(instancetype)initWithSubReddit:(NSString *)subReddit {
    self = [super init];
    if (self) {
        self.subReddit = subReddit;
        self.title = subReddit;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIColor *redditColor = [UIColor redditBlue];
    self.tableView.backgroundColor = redditColor;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = redditColor;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshFeed)
                  forControlEvents:UIControlEventValueChanged];
    
    UINib *nib = [UINib nibWithNibName:PostCellIdentifier
                                bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:PostCellIdentifier];
    
    if (!self.subReddit) {
        FAKFontAwesome *hamburgurIcon = [FAKFontAwesome barsIconWithSize:18];
        UIImage *hamburgurPicture = [hamburgurIcon imageWithSize:CGSizeMake(20, 20)];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:hamburgurPicture
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(buttonPressed:)];
        leftBarButtonItem.tintColor = [UIColor redditOrange];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
    [self refreshFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFeed {
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading Feed", nil)];
    if (self.subReddit) {
        [RedditClient getSubRedditFeed:self.subReddit withSuccessBlock:^(NSArray *posts) {
            [self apiSuccessBlockWithPosts:posts];
        } andFailure:^(NSError *error) {
            [self apiFailureBlockWithError:error];
        }];

    } else {
        [RedditClient getFeedWithSuccessBlock:^(NSArray *posts) {
            [self apiSuccessBlockWithPosts:posts];
        } andFailure:^(NSError *error) {
            [self apiFailureBlockWithError:error];
        }];
    }
}

-(void)buttonPressed:(id)sender {
    NSLog(@"foo: %@", sender);
}

-(void)apiSuccessBlockWithPosts:(NSArray *)posts {
    self.posts = [posts mutableCopy];
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    self.lastUpdated = [NSDate date];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Last Updated: %@", [self.lastUpdated toFormattedDate]]];
}

-(void)apiFailureBlockWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellIdentifier
                                                     forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    cell.delegate = self;
    
    if (indexPath.row ==  self.posts.count-1) {
        NSLog(@"load more");
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.posts[indexPath.row];

    return [post.title cellHeight] + 45;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark PostCellDelegate

-(void)didSelectTitleLabelForPost:(Post *)post {
    if (post.isSelfPost) {
        LinkViewController *linkViewController = [[LinkViewController alloc] initWithNibName:@"LinkViewController" bundle:nil];
        linkViewController.post = post;
        [self.navigationController pushViewController:linkViewController animated:YES];
    } else {
        [self didSelectCommentsLabelForPost:post];
    }
}

-(void)didSelectThumbnailViewForPost:(Post *)post {
    ImageViewController *imageViewController = [[ImageViewController alloc] initWithPost:post];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

-(void)didSelectCommentsLabelForPost:(Post *)post {
    CommentsViewController *commentsViewController = [[CommentsViewController alloc] initWithPost:post];
    [self.navigationController pushViewController:commentsViewController animated:YES];
}

-(void)didSelectAuthorLabelForPost:(Post *)post {
    
}

-(void)didSelectSubRedditLabelForPost:(Post *)post {
    AlienFeedViewController *subRedditViewController = [[AlienFeedViewController alloc] initWithSubReddit:post.subreddit];
    [self.navigationController pushViewController:subRedditViewController animated:YES];
}

@end
