//
//  SolsticeParser.m
//  SolsticeFeedReader
//
//  Edited by: Maribeth Rauh
//  12 Feb 2013

#import "SolsticeParser.h"
#import "FRFeedItem.h"

@interface SolsticeParser()

//This property holds the blog objects that were parsed
@property (nonatomic, strong) NSMutableArray *parsedResults;

//This property holds the current element content being parsed
@property (nonatomic, strong) NSString *currentElement;

@property (nonatomic, strong) FRFeedItem *blogEntry;

@end


@implementation SolsticeParser

@synthesize parsedResults = _parsedResults;
@synthesize currentElement = _currentElement;

// Will be used to truncate data parsed from publish tag so that it will only store the YYYY-MM-DD to self.blogEntry.datepublished
NSRange dateOnly = {0, 10};

//This method initializes the parser, sets the delegate, starts parsing, and returns the results.
- (NSMutableArray *)parseFeedWithResults:(NSURL *)URL
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    parser.delegate = self;
    self.parsedResults = [[NSMutableArray alloc] init];
    [parser parse];             // Everything parsed here
    return self.parsedResults;
}


#pragma mark - Parser delegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    // Custom blog object initialized here
    if ([elementName isEqualToString:@"entry"]) {
        self.blogEntry = [[FRFeedItem alloc] init];
    }
    
    // Parse image URL that accompanies some blog entries
    self.blogEntry.imageURL = [NSURL URLWithString:[attributeDict objectForKey:@"url"]];
    
    // This always prints "converted to a url" and "property of object is url"
    
    if ([elementName isEqualToString:@"media:thumbnail"]) { // Added by StackOverflow suggestion
    
        if ([[NSURL URLWithString:[attributeDict objectForKey:@"url"]] isKindOfClass:[NSURL class]]) {
            NSLog( @"converted to a url" );
    
            if ([self.blogEntry.imageURL isKindOfClass:[NSURL class]]) {
                NSLog(@"property of object is url");
            }else if (!self.blogEntry.imageURL) {
                NSLog(@"url becomes nil");
            }else{
                NSLog(@"property of object is NOT url");
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    self.currentElement = string;
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"title"]) {
        // self.currentElement will hold the title of the blog here
        self.blogEntry.title = self.currentElement;
        
    } else if([elementName isEqualToString:@"published"]) {
        // Given more time, I would use string manipulation to display the date in a more appealing format (EX: Month DD, YYYY or MM/DD/YYYY)
        self.blogEntry.datePublished = [self.currentElement substringWithRange:dateOnly];
    
	}else if([elementName isEqualToString:@"name"]) {
        self.blogEntry.author = self.currentElement;
    
    }else if([elementName isEqualToString:@"entry"]) {
        // An individual blog has been parsed and a pointer to it is added to the parsedResults array
        
        // BUG: this always prints "is nil"...I was unable to resolve this issue in time
        /*
        if ([self.blogEntry.imageURL isKindOfClass:[NSURL class]]) {
            NSLog( @"URL passed" );
        }else if (!self.blogEntry.imageURL) {
            NSLog( @"is nil" );
        }else{
            NSLog(@"no luck");
        }
        */
        
        [self.parsedResults  addObject:self.blogEntry];

    }
}




@end