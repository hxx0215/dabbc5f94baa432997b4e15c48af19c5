//
//  HNHomeViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNHomeViewController.h"
#import "UIView+AHKit.h"
#import "HNDecorateControlViewController.h"
#import "HNMessageViewController.h"
#include "HNBusinessBKControlViewController.h"

#define hSpace 40
#define tSpacePer 0.1
#define decorTop 50
#define btnHeight 50
#define busiTop 120
#define messTop 190

@interface HNHomeViewController ()
@property (nonatomic, strong)UIButton *decorateControlButton;
@property (nonatomic, strong)UIButton *businessBackgroundButton;
@property (nonatomic, strong)UIButton *messageButton;
@property (nonatomic, strong)UIBarButtonItem *settingButton;
@property (nonatomic, strong)HNMessageViewController *messageViewController;
@end


@implementation HNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"E Decorate", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.decorateControlButton = [self createButtonWithTitle:NSLocalizedString(@"Decorate Control", nil) selector:@selector(decorateControlButton_Clicked:)];
    
    self.businessBackgroundButton = [self createButtonWithTitle:NSLocalizedString(@"Business Background", nil) selector:@selector(businessBackgroundButton_Clicked:)];
    self.businessBackgroundButton.top = busiTop;
    [self.view addSubview:self.decorateControlButton];
    [self.view addSubview:self.businessBackgroundButton];
    self.messageButton = [self createButtonWithTitle:NSLocalizedString(@"Message", nil) selector:@selector(messageButton_Clicked:)];
    [self.view addSubview:self.messageButton];
    
    self.settingButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Setting", nil) style:UIBarButtonItemStylePlain target:self action:@selector(settingButton_Clicked:)];
    self.navigationItem.rightBarButtonItem = self.settingButton;
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.width = self.view.width - 2 * hSpace;
    btn.height = btnHeight;
    btn.left = hSpace;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setMyInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if (UIInterfaceOrientationIsPortrait(orientation)){
        self.decorateControlButton.top = decorTop;
        self.businessBackgroundButton.top = busiTop;
        self.messageButton.top = messTop;
    }
    else{
    }
}

- (void)decorateControlButton_Clicked:(id)sender{
    NSLog(@"decor");
    HNDecorateControlViewController* DC = [[HNDecorateControlViewController alloc]init];
//    [self presentViewController:DC animated:YES completion:^{}];
    [self.navigationController pushViewController:DC animated:YES];
}

- (void)businessBackgroundButton_Clicked:(id)sender{
    HNBusinessBKControlViewController* bc = [[HNBusinessBKControlViewController alloc]init];
    [self.navigationController pushViewController:bc animated:YES];
    NSLog(@"busi");
}
- (void)messageButton_Clicked:(id)sender{
    if (!self.messageViewController){
        self.messageViewController = [[HNMessageViewController alloc] init];
    }
    [self.navigationController pushViewController:self.messageViewController animated:YES];
}

- (void)settingButton_Clicked:(id)sender{
    NSLog(@"setting");
}
@end
