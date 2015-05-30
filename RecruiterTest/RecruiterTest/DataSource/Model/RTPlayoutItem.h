//
//  RTPlayoutItem.h
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPlayoutItem : NSObject

@property (nonatomic, copy, readonly) NSString *playoutTitle;
@property (nonatomic, copy, readonly) NSString *playoutArtist;
@property (nonatomic, copy, readonly) NSString *playoutAlbum;
@property (nonatomic, copy, readonly) NSURL *playoutImageURL;

+ (instancetype)playoutItemWithAttributes:(NSDictionary *)attributes;

@end
