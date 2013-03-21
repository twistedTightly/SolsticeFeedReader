//
//  FRFeedItem.h
//  SolsticeFeedReader
//
//  Edited by: Maribeth Rauh
//  12 Feb 2013

#import <Foundation/Foundation.h>

@interface FRFeedItem : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* author;
//@property (nonatomic, strong) NSString* url; UNUSED
@property (nonatomic, strong) NSURL* imageURL;
@property (nonatomic, strong) NSString* datePublished;

@end