//
//  AppDelegate.m
//  edecorate
//
//  Created by hxx on 9/16/14.
//
//

#import "AppDelegate.h"
#import "HNHomeViewController.h"
#import "HNLoginViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self configureNavigationAppearance];
    HNLoginViewController *loginViewController = [[HNLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = nav;
    nav.navigationBar.translucent = NO;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configureNavigationAppearance{
    UIImage *arrowImage = [[UIImage  imageNamed:@"arrowBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 27, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:arrowImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0]];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0],
//                                                           NSFontAttributeName : [UIFont systemFontOfSize:18]
//                                                           }];
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
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
#endif

#pragma mark -

@end
