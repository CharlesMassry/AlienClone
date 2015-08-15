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

@interface AlienFeedViewController ()
@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) NSDate *lastUpdated;
@end

@implementation AlienFeedViewController

static NSString *PostCellIdentifier = @"PostCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AlienClone";
    
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
    [self refreshFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFeed {
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading Feed", nil)];
    [RedditClient getFeedWithSuccessBlock:^(NSArray *posts) {
        self.posts = posts;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        self.lastUpdated = [NSDate date];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Last Updated: %@", [self.lastUpdated toFormattedDate]]];
    } andFailure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell;
    NSUInteger nodeCount = self.posts.count;
    
    if (nodeCount == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceholderCellIdentifier"
                                               forIndexPath:indexPath];
        cell.titleLabel.text = @"Loading...";
    } else {
        Post *post = self.posts[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:PostCellIdentifier
                                               forIndexPath:indexPath];
        cell.post = post;
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

@end
