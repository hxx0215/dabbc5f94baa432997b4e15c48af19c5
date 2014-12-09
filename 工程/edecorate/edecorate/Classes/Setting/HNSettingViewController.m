//
//  HNSettingViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-5.
//
//

#import "HNSettingViewController.h"
#import "HNModfiypwdViewController.h"
#import "HNImageData.h"

@interface HNSettingViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *switchCheckVersion;
@property(nonatomic,strong) IBOutlet UIButton* btnClear;
@property(nonatomic,strong) IBOutlet UIButton* btnModifPW;
@property(nonatomic,strong) IBOutlet UIButton* btnLogOut;
@property(nonatomic,strong) IBOutlet UIView* viewCheckVersion;
@end

@implementation HNSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置";
    //[HNUIStyleSet UIStyleSetRoundView:self.btnLogOut];
    
    [self btnWithTitle:@"清除缓存" button:self.btnClear];
    [self.btnClear addTarget:self action:@selector(btnClearClick:) forControlEvents:UIControlEventTouchUpInside];
    [self btnWithTitle:@"修改密码" button:self.btnModifPW];
    [self.btnModifPW addTarget:self action:@selector(btnModifPWClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"检查更新";
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    [self.viewCheckVersion addSubview:label];
    label.centerY = self.viewCheckVersion.height/2;
    [self.viewCheckVersion bringSubviewToFront:label];
    label.left = 24;
    
}

-(void)btnWithTitle:(NSString*)title button:(UIButton*)btn
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    UILabel* label = btn.titleLabel;
    label.font = [UIFont systemFontOfSize:17];
    //[btn bringSubviewToFront:label];
    CGRect rect = CGRectMake(0, 0, btn.width, btn.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [btn setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkVersonClick:(id)sender {
}

- (IBAction)logOut:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)btnClearClick:(UIButton *)sender {
    [[HNImageData shared] clearCatch ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"清除缓存成功", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    [alert show];
}

- (IBAction)btnModifPWClick:(UIButton *)sender {
    HNModfiypwdViewController *order = [[HNModfiypwdViewController alloc]init];
    order.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:order animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
