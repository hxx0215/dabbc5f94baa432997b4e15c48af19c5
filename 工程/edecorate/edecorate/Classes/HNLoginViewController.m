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

- (void)login:(id)sender{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:@"http://113.105.159.115:5030/?Method=get.user.login&Params=CB914058227D8DE180A6D6145A791286164DFFDDB57719A1E68895C3772AC876B0B17A8CFFF97DE7DE1B8AED2ADD23B2E1CB9BA1646FBDA3680BADAA3985BE7F6506613E479DB992&Sign=352121BF8C4788B877FF6A5FF34380C4"];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *retStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"end%@",retStr);
    NSString *str =[NSString encodeToPercentEscapeString:@"{\"username\":\"admin\",\"password\":\"123456\"}"];
    NSLog(@"%@",[str encryptWithDES]);
    NSLog(@"sign:%@",[NSString createSignWithMethod:@"get.user.login" Params:[str encryptWithDES]]);
    NSLog(@"%@",[[str encryptWithDES] decryptWithDES]);
    [self loginSuccess];
}

- (void)loginSuccess{
    HNHomeViewController *homeViewController = [[HNHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
}
@end
