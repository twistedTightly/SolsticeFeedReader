//
//  FRFeedTableViewController.m
//  SolsticeFeedReader
//
//  Edited by: Maribeth Rauh
//  12 Feb 2013

/*
 PLEASE NOTE:
    I saw Objective-C syntax for the first time when I received this code. While I do have limited experience in Java, I chose not to
 complete the project in Java after spending hours attempting to get Eclipse working without any sign of progress.
    Doing significant research using iTunesU videos, online forums, and Apple documentation throughout my development, I was able to get
 most of the application working.  My hope is that this modest app will demonstrate, above all, my adaptability and drive.  I made slow but
 steady progress thoughout the 48 hours allowed and am confident that, given more time, I could have accomplished any number of features to
 enhance the app.
    If this project does not seem to sufficiently represnt my technical skills due to the limits of my background going into its development,
 I am open to another option in a language I am more familiar with, a possibility that Robin had suggested may be available. Regardless, this
 has been an exciting and invaluable learning experience which has only motivated me to want to teach myself more on my own time.
 */

#import "FRFeedTableViewController.h"
#import "FRFeedItem.h"
#import "SolsticeParser.h"

#define kFeedURL @"http://blog.solstice-mobile.com/feeds/posts/default"

@interface FRFeedTableViewController ()

@property (nonatomic, strong) SolsticeParser* parser;
@property (nonatomic, strong) NSMutableArray* feedDataFromParser;
@property (nonatomic, strong) NSURL* url;

@end

@implementation FRFeedTableViewController

// synthesize automatically done by Xcode v4.6

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.parser = [[SolsticeParser alloc] init]; // initialize parser by allocating memory on the heap
    [self loadItems]; // automatically loads data to be displayed upon opening the app
}

- (void)viewDidAppear:(BOOL)animated
{
    // Parser is not called until the view has appeared so that the user will see that the application has opened
    [super viewDidAppear:YES];
    
}

- (void)loadItems
{
    // information parsed from Solstice Mobile blog stored to a mutable array
    self.feedDataFromParser = [self.parser parseFeedWithResults:[NSURL URLWithString:kFeedURL]];
}

#pragma mark - UITableViewDataSource

/* Commented out because sections not used (only 1)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the (1) section
    return [self.feedDataFromParser count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // string is name of prototype cell
    static NSString *CellIdentifier = @"Blog Entry";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier /*forIndexPath:indexPath*/];
    
    // stops program from crashing if cell identifier string not matched, creates default cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell from data stored in mutable array of FRFeedItem objects
    cell.textLabel.text = [[self.feedDataFromParser objectAtIndex:indexPath.row] title];
    cell.textLabel.textColor = [UIColor orangeColor];
    
    NSString *subtitle = [[[@"By: " stringByAppendingString:[[self.feedDataFromParser objectAtIndex:indexPath.row] author]]
                           stringByAppendingString:@", "]
                          stringByAppendingString:[[self.feedDataFromParser objectAtIndex:indexPath.row] datePublished]];
    
    cell.detailTextLabel.text = subtitle;
    
    // Since not every entry has an image, a default Solstice Mobile image is used
    if ([[self.feedDataFromParser objectAtIndex:indexPath.row] imageURL] == nil) {
        _url = [NSURL URLWithString:@"https://twimg0-a.akamaihd.net/profile_images/2624989235/vu91lbomoutm56on2ed9.png"];
    }else{
        // BUG: the imageURL is always set to nil so no unique images from the blog end up being used
        _url = [[self.feedDataFromParser objectAtIndex:indexPath.row] imageURL];
    }
    NSData *image = [[NSData alloc] initWithContentsOfURL:_url];
    cell.imageView.image = [UIImage imageWithData:image];
      
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Next major step I had hoped to take if I had more time would be to push a UIWebView that opens to the selected
    // article when the user touches a cell
    // A back button in the tool bar of the UIWebView would return the user to the FRFeedTableView, without updating it
    
    // If developing a separate iPad app, I would have used the split view to keep the list to the left side, updating the
    // right side with the article selected
}

@end
