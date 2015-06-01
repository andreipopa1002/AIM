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
/**
 *  Class method that creates and populates the properties of the playout object
 *
 *  @param attributes dictionary obtained from the XML
 *
 *  @return RTPlayoutItem object already populated with the data received from the XML
 */
+ (instancetype)playoutItemWithAttributes:(NSDictionary *)attributes;

@end
