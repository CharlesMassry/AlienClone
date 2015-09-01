//
//  LinkViewController.m
//  AlienClone
//
//  Created by Charlie Massry on 8/20/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "LinkViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "CommentsViewController.h"
#import "UIColor+Reddit.h"

@interface LinkViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commentsButton;
@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.tintColor = [UIColor redditOrange];
    self.forwardButton.tintColor = [UIColor redditOrange];
    self.commentsButton.tintColor = [UIColor redditOrange];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.post.linkURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading Feed", nil)];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardButtonPressed:(id)sender {
    [self.webView goForward];
}

- (IBAction)commentsButtonPressed:(id)sender {
    CommentsViewController *commentsViewController = [[CommentsViewController alloc] init];
    [self.navigationController pushViewController:commentsViewController animated:YES];
}

@end
