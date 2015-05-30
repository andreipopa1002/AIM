//
//  RTPlayoutTableViewCell.h
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTURLImageView.h"

extern NSString *const kRTPlayoutTableViewCellIdentifier;
extern NSString *const kRTPlayoutTableViewCellNibName;
extern CGFloat const kRTPlayoutTableViewCellHeight;

@interface RTPlayoutTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) IBOutlet UILabel *artistLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *albumLabel;
@property (nonatomic, weak, readwrite) IBOutlet RTURLImageView *urlImageView;


@end
