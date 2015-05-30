//
//  RTPlayoutItem.m
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "RTPlayoutItem.h"

@interface RTPlayoutItem()

@property (nonatomic, copy, readwrite) NSString *playoutTitle;
@property (nonatomic, copy, readwrite) NSString *playoutArtist;
@property (nonatomic, copy, readwrite) NSString *playoutAlbum;
@property (nonatomic, copy, readwrite) NSURL *playoutImageURL;

@end

@implementation RTPlayoutItem

+ (instancetype)playoutItemWithAttributes:(NSDictionary *)attributes {
    return [[RTPlayoutItem alloc] initWithAttributes:attributes];
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _playoutTitle = attributes[@"title"];
        _playoutArtist = attributes[@"artist"];
        _playoutAlbum = attributes[@"album"];
        if (![attributes[@"imageUrl"] isEqualToString:@"None"]) {
            _playoutImageURL = [NSURL URLWithString:attributes[@"imageUrl"]];
        }
    }
    return self;
}

@end
