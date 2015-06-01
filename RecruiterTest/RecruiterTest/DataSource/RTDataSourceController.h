//
//  RTDataSourceController.h
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
/**
 *  This class acts as the data source for a tableview
 */
@interface RTDataSourceController : NSObject <UITableViewDataSource, UITableViewDelegate>
/**
 *  configuration method to setup a tableview into using the data source
 *
 *  @param tableView that needs to be configured
 */
- (void)setupDataSourceForTableView:(UITableView *)tableView;
/**
 *  Methods that triggers the datasource to retrieve data from a url
 *
 *  @param dataSourceURL   dataSource url
 *  @param completionBlock callback for when we have all the data to be displayed
 */
- (void)retrieveDataSourceFromURL:(NSURL *)dataSourceURL withCompletion:(void(^)(void))completionBlock;

@end
