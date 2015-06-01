//
//  RTDataSourceXMLParser.m
//  RecruiterTest
//
//  Created by Popa Andrei on 30/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import "RTXMLParser.h"

static NSString *const kPlayoutDataElementName = @"playoutData";
static NSString *const kPlayoutItemElementName = @"playoutItem";

@interface RTXMLParser() <NSXMLParserDelegate>

@property (nonatomic, copy, readwrite) RTXMLParserCompletion completionBlock;
@property (nonatomic, strong, readwrite) NSXMLParser *parser;
@property (nonatomic, strong, readwrite) NSMutableArray *mutablePlayoutItems;
@property (nonatomic, strong, readwrite) RTPlayoutItem *currentPlayoutItem;

@property (nonatomic, assign, readwrite) BOOL isParsingPlayoutData;

@end

@implementation RTXMLParser

+ (instancetype)dataSourceXMLParserFromURL:(NSURL *)xmlURL completionBlock:(RTXMLParserCompletion)completionBlock {
    RTXMLParser *xmlParser = [[RTXMLParser alloc] init];
    xmlParser.completionBlock = completionBlock;
    xmlParser.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    xmlParser.parser.delegate = xmlParser;
    xmlParser.mutablePlayoutItems = [NSMutableArray new];
    [xmlParser.parser parse];
    
    return xmlParser;
}

# pragma mark - NSXMLParserDelegate Methods
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completionBlock) {
        self.completionBlock([NSArray arrayWithArray:self.mutablePlayoutItems]);
    }
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kPlayoutDataElementName]) {
        self.isParsingPlayoutData = YES;
    } else if ([elementName isEqualToString:kPlayoutItemElementName] && self.isParsingPlayoutData) {
        self.currentPlayoutItem = [RTPlayoutItem playoutItemWithAttributes:attributeDict];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kPlayoutDataElementName]) {
        self.isParsingPlayoutData = NO;
    } else if ([elementName isEqualToString:kPlayoutItemElementName] && self.isParsingPlayoutData) {
        [self.mutablePlayoutItems addObject:self.currentPlayoutItem];
        self.currentPlayoutItem = nil;
    }
}

@end
