//
//  RTDataSourceXMLParser.h
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPlayoutItem.h"

typedef void(^RTDataSourceXMLParserCompletion)(NSArray *playoutItems);

@interface RTDataSourceXMLParser : NSObject

+ (instancetype)dataSourceXMLParserFromURL:(NSURL *)xmlURL completionBlock:(RTDataSourceXMLParserCompletion)completionBlock;

@end
