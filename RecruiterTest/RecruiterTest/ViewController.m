//
//  ViewController.m
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "ViewController.h"
#import "RTDataSourceController.h"

static NSString *const kDataSourceURL = @"http://apps.aim-data.com/data/abc/triplej/onair.xml";

@interface ViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readwrite) RTDataSourceController *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
}

# pragma mark - Internal Methods

- (void)setupDataSource {
    self.dataSource = [[RTDataSourceController alloc] init];
    typeof(self) __weak weakSelf = self;
    [self showLoadingIndicator];
    [self.dataSource setupDataSourceForTableView:self.tableView];
    [self.dataSource retrieveDataSourceFromURL:[NSURL URLWithString:kDataSourceURL] withCompletion:^{
        [weakSelf hideLoadingIndicator];
        [weakSelf.tableView reloadData];
    }];
}

@end
