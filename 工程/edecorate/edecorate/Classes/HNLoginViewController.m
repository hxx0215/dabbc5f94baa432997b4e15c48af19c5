//
//  HNLoginViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNLoginViewController.h"
#import "UIView+AHKit.h"
#import "HNHomeViewController.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNLoginView.h"
#import "HNDecorateControlViewController.h"
#import "HNBusinessBKControlViewController.h"
#import "HNMessageViewController.h"
#import "HNSettingViewController.h"

@interface HNLoginModel: NSObject
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *password;
@end
@implementation HNLoginModel
@end

@interface HNLoginViewController()<UITabBarControllerDelegate>

@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIImageView *backImage;
@property (nonatomic, strong)HNLoginView *loginView;
@property (nonatomic, strong)UIButton *remember;
@property (nonatomic, strong)UILabel *rememberLabel;
@property (nonatomic, strong)UIButton *forget;
@end
@implementation HNLoginViewController
- (instancetype)init{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Login", nil);
    self.backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginback.png"]];

    self.loginView = [[HNLoginView alloc] initWithFrame:CGRectMake(18, 18, self.view.width - 36, 81)];
    
    self.remember = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.remember setBackgroundImage:[UIImage imageNamed:@"remember.png"] forState:UIControlStateNormal];
    [self.remember setImage:[UIImage imageNamed:@"rememberit.png"] forState:UIControlStateSelected];
    [self.remember addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.remember sizeToFit];
    self.remember.top = self.loginView.bottom + 9;
    self.remember.left = self.loginView.left;
    self.rememberLabel = [[UILabel alloc] init];
    self.rememberLabel.text = NSLocalizedString(@"Remember", nil);
    [self.rememberLabel sizeToFit];
    self.rememberLabel.textColor = [UIColor colorWithWhite:102.0/255.0 alpha:1.0];
    self.rememberLabel.centerY = self.remember.centerY;
    self.rememberLabel.left = self.remember.right;
    
    self.forget = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forget setTitle:NSLocalizedString(@"Forget Password?", nil) forState:UIControlStateNormal];
    [self.forget setTitleColor:[UIColor colorWithRed:45.0/255.0 green:138.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.forget addTarget:self action:@selector(fogetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.forget sizeToFit];
    self.forget.right = self.loginView.right;
    self.forget.centerY = self.rememberLabel.centerY;
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(0, 0, self.view.width - 36, 40);
    self.loginButton.top = self.remember.bottom + 9;
    self.loginButton.centerX = self.view.width / 2;
    [self.loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.cornerRadius = 5.0;
    [self.loginButton setBackgroundColor:[UIColor colorWithRed:0.0 green:152.0/255.0 blue:233.0/255.0 alpha:1.0]];
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.remember];
    [self.view addSubview:self.rememberLabel];
    [self.view addSubview:self.forget];

    [self.view addSubview:self.loginButton];
    self.loginView.userName.text = @"admin";
    self.loginView.password.text = @"123456";
    [self initTabBar];

}
- (void)initTabBar{
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.view.backgroundColor = [UIColor darkGrayColor];
    //HNHomeViewController *vc1 = [[HNHomeViewController alloc] init];
    //vc1.title = NSLocalizedString(@"E Decorate", nil);
    //UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Home", nil) image:[UIImage imageNamed:@"设置_11"] tag:101];
    UITabBar *tabBar = [self.tabBarController tabBar];
    [tabBar setTintColor:[UIColor greenColor]];
    tabBar.barStyle = UIBarStyleBlack;
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"装修管控" image:[UIImage imageNamed:@"Tab2"] tag:102];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"商务后台" image:[UIImage imageNamed:@"Tab3"] tag:103];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"Tab4"] tag:104];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"Tab5"] tag:105];
    //vc1.tabBarItem = item1;
    HNDecorateControlViewController *vc2 = [[HNDecorateControlViewController alloc] init];
    vc2.tabBarItem = item2;
    HNBusinessBKControlViewController *vc3 = [[HNBusinessBKControlViewController alloc] init];
    vc3.tabBarItem = item3;
    HNMessageViewController *vc4 = [[HNMessageViewController alloc] init];
    vc4.tabBarItem = item4;
    HNSettingViewController *vc5 = [[HNSettingViewController alloc]init];
    vc5.tabBarItem = item5;
    //UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    //nav1.navigationBar.translucent = NO;
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.navigationBar.translucent = NO;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav3.navigationBar.translucent = NO;
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    nav4.navigationBar.translucent = NO;
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    nav5.navigationBar.translucent = NO;
    self.tabBarController.viewControllers = @[nav2,nav3,nav4,nav5];
    self.tabBarController.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.view insertSubview:self.backImage atIndex:100];
    [self.view insertSubview:self.backImage belowSubview:self.loginView];

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.backImage removeFromSuperview];
}

- (NSDictionary *)encodeWithLoginModel:(HNLoginModel *)model{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:model.username,@"username",model.password,@"password", nil];
    return dic;
}

- (void)fogetPassword:(id)sender{
    NSLog(@"foget password");
}
- (void)rememberPassword:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)login:(id)sender{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    HNLoginModel *model = [[HNLoginModel alloc] init];
    model.username = self.loginView.userName.text;
    model.password = self.loginView.password.text;
    NSString *jsonStr = [[self encodeWithLoginModel:model] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.user.login" Params:jsonStr]];
    //@"http://113.105.159.115:5030/?Method=get.user.login&Params=CB914058227D8DE180A6D6145A791286164DFFDDB57719A1E68895C3772AC876B0B17A8CFFF97DE7DE1B8AED2ADD23B2E1CB9BA1646FBDA3680BADAA3985BE7F6506613E479DB992&Sign=352121BF8C4788B877FF6A5FF34380C4"
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//    NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];同步调用

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            if ([[HNLoginData shared] updateData:[[[retJson objectFromJSONString] objectForKey:@"data"] objectAtIndex:0]] && [[HNLoginData shared].state isEqualToString:@"1"]){//之后需要替换成status
                [self loginSuccess];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Fail", nil) message:NSLocalizedString(@"Please input correct username and password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
        
    }];
//    NSLog(@"end%@",retStr);
//    NSString *str =[NSString encodeToPercentEscapeString:@"{\"username\":\"admin\",\"password\":\"123456\"}"];
//    NSLog(@"%@",[str encryptWithDES]);
//    NSLog(@"sign:%@",[NSString createSignWithMethod:@"get.user.login" Params:[str encryptWithDES]]);
//    
//    NSLog(@"%@",[@"{\"username\":\"admin\",\"password\":\"123456\"}" isEqualToString:[NSString decodeFromPercentEscapeString:[[str encryptWithDES] decryptWithDES]]]? @"Yes":@"NO");
    
//    NSLog(@"%@",[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]]);
//    NSLog(@"%@",[[[[retJson objectFromJSONString] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"msg"]);

}

- (void)loginSuccess{
    HNHomeViewController *homeViewController = [[HNHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    nav.navigationBar.translucent = NO;
    [self presentViewController:self.tabBarController animated:YES completion:nil];

}

- (void)changeViewControlelr:(id)sender{
    
}


- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    NSLog(@"willBeginCustomizingViewControllers: %@", viewControllers);
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"viewcontrollers: %@, ischanged: %d", viewControllers, changed);
}


- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"didEndCustomizingViewController!");
    NSLog(@"didEndCustomizingViewController: %@, ischanged: %d", viewControllers, changed);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    NSLog(@"didSelectViewController!");
}

@end
