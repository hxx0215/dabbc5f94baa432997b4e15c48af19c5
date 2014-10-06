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

@interface HNLoginModel: NSObject
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *password;
@end
@implementation HNLoginModel
@end

@interface HNLoginViewController()
@property (nonatomic, strong)UILabel *userLabel;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UITextField *userTextField;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *loginButton;
@end
@implementation HNLoginViewController
- (instancetype)init{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.userLabel = [[UILabel alloc] init];
    self.userLabel.text = NSLocalizedString(@"User :", nil);
    [self.userLabel sizeToFit];
    self.passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.text = NSLocalizedString(@"Password :", nil);
    [self.passwordLabel sizeToFit];
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, self.userLabel.height)];
    self.userTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.userTextField.layer.borderWidth = 1.0;
    self.passwordTextField =[[UITextField alloc] initWithFrame:self.userTextField.bounds];
    self.passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.layer.borderWidth = 1.0;
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.borderWidth = 1.0;
    self.loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    self.userTextField.text = @"admin";
    self.passwordTextField.text = @"123456";
    [self setMyInterface];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setMyInterface];
}

- (void)setMyInterface{
    self.userLabel.top = 0.2 *self.view.height;
    self.userLabel.left = (self.view.width - self.userLabel.width - self.passwordTextField.width) / 2;
    self.userTextField.top = self.userLabel.top;
    self.userTextField.right = self.view.width - self.userLabel.left;
    
    self.passwordLabel.top = self.userLabel.bottom + 20;
    self.passwordLabel.left = self.userLabel.left;
    self.passwordTextField.top = self.passwordLabel.top;
    self.passwordTextField.width = self.userTextField.right - self.passwordLabel.right;
    self.passwordTextField.right = self.userTextField.right;
    
    self.loginButton.width = self.userTextField.right - self.userLabel.left;
    self.loginButton.height = self.userLabel.height + 20;
    self.loginButton.top = self.passwordLabel.bottom + 20;
    self.loginButton.left = self.userLabel.left;
}
- (NSDictionary *)encodeWithLoginModel:(HNLoginModel *)model{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:model.username,@"username",model.password,@"password", nil];
    return dic;
}
- (void)login:(id)sender{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    HNLoginModel *model = [[HNLoginModel alloc] init];
    model.username = self.userTextField.text;
    model.password = self.passwordTextField.text;
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
            if ([[HNLoginData shared] updateData:[[[retJson objectFromJSONString] objectForKey:@"data"] objectAtIndex:0]] && [[HNLoginData shared].msg isEqualToString:@"登录成功"]){//之后需要替换成status
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
    [self presentViewController:nav animated:YES completion:nil];
}
@end
