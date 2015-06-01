//
//  RTDataSourceController.m
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "RTDataSourceController.h"
#import "RTXMLParser.h"
#import "RTPlayoutTableViewCell.h"

@interface RTDataSourceController()

@property (nonatomic, copy, readwrite) void (^completionBlock)(void);
@property (nonatomic, strong, readwrite) RTXMLParser *xmlParser;
@property (nonatomic, strong, readwrite) NSArray *elements;

@end

@implementation RTDataSourceController

- (void)setupDataSourceForTableView:(UITableView *)tableView {
    tableView = tableView;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:kRTPlayoutTableViewCellNibName bundle:nil] forCellReuseIdentifier:kRTPlayoutTableViewCellIdentifier];
    tableView.delegate = self;
}

- (void)retrieveDataSourceFromURL:(NSURL *)dataSourceURL withCompletion:(void(^)(void))completionBlock {
    self.completionBlock = completionBlock;
    
    typeof(self) __weak weakSelf = self;
    self.xmlParser = [RTXMLParser dataSourceXMLParserFromURL:dataSourceURL completionBlock:^(NSArray *playoutItems) {
        if (weakSelf.completionBlock) {
            weakSelf.elements = playoutItems;
            weakSelf.completionBlock();
        }
    }];
}

# pragma mark - Internal Methods

- (void)populateCell:(RTPlayoutTableViewCell *)cell forPlayoutItem:(RTPlayoutItem *)playoutItem {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.artistLabel.text = playoutItem.playoutArtist;
    cell.titleLabel.text = playoutItem.playoutTitle;
    cell.albumLabel.text = playoutItem.playoutAlbum;
    cell.urlImageView.imageURL = playoutItem.playoutImageURL;
}

# pragma mark - UITableViewDataSource Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
    return self.elements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTPlayoutTableViewCell *cell = (RTPlayoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kRTPlayoutTableViewCellIdentifier forIndexPath:indexPath];
    [self populateCell:cell forPlayoutItem:self.elements[indexPath.row]];
    return cell;
}

# pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRTPlayoutTableViewCellHeight;
}

@end
