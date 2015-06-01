//
//  RTDataSourceXMLParser.h
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPlayoutItem.h"
/**
 *  This class takes care of parsing a XML file from a specific URL
 *
 */
typedef void(^RTXMLParserCompletion)(NSArray *playoutItems);

@interface RTXMLParser : NSObject
/**
 *  Class method that initializes the RTDataSourceXMLParser and also takes a completion block to be executed when the parsing is done
 *
 *  @param xmlURL          URL that points the the xml file
 *  @param completionBlock block of code that is executed after the parsing is done
 *
 *  @return RTDataSourceXMLParser object that takes care of parsing the xml
 */
+ (instancetype)dataSourceXMLParserFromURL:(NSURL *)xmlURL completionBlock:(RTXMLParserCompletion)completionBlock;

@end
