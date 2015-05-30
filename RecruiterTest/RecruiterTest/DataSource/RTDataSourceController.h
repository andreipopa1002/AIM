//
//  RTDataSourceController.h
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface RTDataSourceController : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)setupDataSourceForTableView:(UITableView *)tableView;
- (void)retrieveDataSourceFromURL:(NSURL *)dataSourceURL withCompletion:(void(^)(void))completionBlock;

@end
