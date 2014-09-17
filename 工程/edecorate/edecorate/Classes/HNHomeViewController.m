//
//  HNHomeViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNHomeViewController.h"
#import "UIView+AHKit.h"

@interface HNHomeViewController ()
@property (nonatomic, strong)UIButton *decorateControlButton;
@property (nonatomic, strong)UIButton *businessBackgroundButton;
@property (nonatomic, strong)UIBarButtonItem *messageButton;
@end

const CGFloat hSpace = 40;
const CGFloat tSpacePer = 0.1;

const CGFloat btnHeight = 50;
const CGFloat decorTop = 50;
const CGFloat busiTop = 120;

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
    self.messageButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Message", nil) style:UIBarButtonItemStylePlain target:self action:@selector(messageButton_Clicked:)];
    self.navigationItem.rightBarButtonItem = self.messageButton;
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
    }
    else{
    }
}

- (void)decorateControlButton_Clicked:(id)sender{
    NSLog(@"decor");
}

- (void)businessBackgroundButton_Clicked:(id)sender{
    NSLog(@"busi");
}
- (void)messageButton_Clicked:(id)sender{
    NSLog(@"message");
}
@end
