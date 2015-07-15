//
//  AppDelegate.m
//  edecorate
//
//  Created by hxx on 9/16/14.
//
//

#import "AppDelegate.h"
#import "APService.h"
#import "HNHomeViewController.h"
#import "HNLoginViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
//    [_window release];
//    [_infoLabel release];
//    [_udidLabel release];
//    
//    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
//    HNHomeViewController *homeViewController = [[HNHomeViewController alloc] init];
    [self configureNavigationAppearance];
    HNLoginViewController *loginViewController = [[HNLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = nav;
    nav.navigationBar.translucent = NO;
//    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 320, 200)];
//    [_infoLabel setBackgroundColor:[UIColor clearColor]];
//    [_infoLabel setTextColor:[UIColor colorWithRed:0.5 green:0.65 blue:0.75 alpha:1]];
//    [_infoLabel setFont:[UIFont boldSystemFontOfSize:20]];
//    [_infoLabel setTextAlignment:NSTextAlignmentCenter];
//    [_infoLabel setNumberOfLines:0];
//    [_infoLabel setText:@"未连接。。。"];
//    [self.window addSubview:_infoLabel];
//    
//    NSLog(@"中文日志");
//    
//    _udidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 320, 80)];
//    [_udidLabel setBackgroundColor:[UIColor clearColor]];
//    [_udidLabel setTextColor:[UIColor colorWithRed:0.5 green:0.7 blue:0.75 alpha:1]];
//    [_udidLabel setFont:[UIFont systemFontOfSize:18]];
//    [_udidLabel setTextAlignment:NSTextAlignmentCenter];
//    [_udidLabel setText:[NSString stringWithFormat:@"UDID: %@", [APService openUDID]]];
//    [self.window addSubview:_udidLabel];
    
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    
//    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)];
//    [APService setupWithOption:launchOptions];
//    
//    [APService setTags:[NSSet setWithObjects:@"tag4",@"tag5",@"tag6",nil] alias:@"别名" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
    
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

- (void)networkDidSetup:(NSNotification *)notification {
//    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    [_infoLabel setText:@"未连接。。。"];
//    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    [_infoLabel setText:@"已注册"];
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    [_infoLabel setText:@"已登录"];
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    
//    [dateFormatter release];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
@end
