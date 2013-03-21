//
//  SolsticeParser.h
//  SolsticeFeedReader
//
//  Edited by: Maribeth Rauh
//  12 Feb 2013

//  This class uses the NSXMLParserDelegate Protocol to parse blog entries from the feed.
//  Please refer to Apple's documentation about the NSXMLParser and the NSXMLParserDelegate,
//  and make any needed additions or adjustments to suit your needs.

#import <Foundation/Foundation.h>

@interface SolsticeParser : NSObject <NSXMLParserDelegate>

//This method will parse the feed and return a mutable array of results
- (NSMutableArray *)parseFeedWithResults:(NSURL *)URL;

@end
