//
//  RTPlayoutTableViewCell.m
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "RTPlayoutTableViewCell.h"

NSString *const kRTPlayoutTableViewCellIdentifier = @"imageCell";
NSString *const kRTPlayoutTableViewCellNibName = @"RTPlayoutTableViewCell";
CGFloat const kRTPlayoutTableViewCellHeight = 81.f;

@implementation RTPlayoutTableViewCell

- (void)awakeFromNib {
    self.artistLabel.text = @"";
    self.titleLabel.text = @"";
    self.albumLabel.text = @"";
    self.urlImageView.imageURL = nil;
}

@end
