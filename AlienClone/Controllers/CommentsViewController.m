//
//  CommentsViewController.m
//  AlienClone
//
//  Created by Charlie Massry on 8/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "CommentsViewController.h"
#import "Post.h"
#import "Comment.h"

@interface CommentsViewController ()
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) NSArray *comments;
@end

@implementation CommentsViewController

- (instancetype)initWithPost:(Post *)post {
    self = [super initWithStyle:UITableViewStyleGrouped];

    if (self) {
        self.post = post;
        self.comments = @[@"foo",@"bar"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

static NSInteger PostSection = 0;
static NSInteger CommentsSection = 1;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numberOfRows;
    NSLog(@"%lu", section);
    if (section == PostSection) {
        numberOfRows = 1;
    } else if (section == CommentsSection) {
        numberOfRows = self.comments.count;
    } else {
        numberOfRows = 0;
    }
    
    return numberOfRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.comments[indexPath.row]];
    return cell;
}

@end
