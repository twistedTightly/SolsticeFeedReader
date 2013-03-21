//
//  FRAppDelegate.m
//  SolsticeFeedReader
//
//  Edited by: Maribeth Rauh
//  12 Feb 2013

#import "FRAppDelegate.h"

@implementation FRAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* THIS CODE ONLY FOR IPAD - Given more time to learn the frameworks for iOS, I would develop a separate application for the iPad.
     This application would use a popover to show the article contents which would be parsed from the blog.  When the user selected a
     title, the popover would appear or disappear, depending on its current state.
     However, for the sake of time, I have made one app to work on both the iPad and iPhone.
    
     // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    */
    return YES;
    
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // NOTE: I considered saving the data because it may help the app load faster when the user re-opens it. However, if the
    // contents of the feed are not saved, it will force the app to reload them, inherently updating the feed contents if there was a new
    // post.
    
    // The data could be saved using NSUserDefaults and then reloaded by the user
    // EX: When the user swipes from the top of the list downward or presses a button, the parser runs again and re-displays the feed
}

@end
