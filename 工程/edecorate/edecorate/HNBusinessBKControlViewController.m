//
//  HNBusinessBKControlViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNBusinessBKControlViewController.h"
#import "UIView+AHKit.h"
#import "HNVolumeViewController.h"

#import "HNBusinessListViewController.h"

#import "HNProfileViewController.h"


@interface HNBusinessBKControlViewController ()
@property (strong, nonatomic) IBOutlet UIButton *messagePayingButton;
@property (strong, nonatomic) IBOutlet UIButton *messageShippingButton;
@property (strong, nonatomic) IBOutlet UIButton *messageShippedButton;
@property (strong, nonatomic) IBOutlet UIButton *messageSuccessfulButton;

@property (strong, nonatomic) IBOutlet UIButton *merchandiseButton;
@property (strong, nonatomic) IBOutlet UIButton *orderButton;
@property (strong, nonatomic) IBOutlet UIButton *returnsButton;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UIButton *volumeButton;


@end

#define HSPACE 126/2
#define WLEFT 30/2
#define WRIGHT 30/2
#define WSPACE 44/2
#define TSPACEPER 0.1
#define STARTTOP 266/2
#define BTNWIDTH 100

@implementation HNBusinessBKControlViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self messageButtonWithTitle:NSLocalizedString(@"Pending payment", nil) button:self.messagePayingButton numMessage:3 index:0];
//    [self messageButtonWithTitle:NSLocalizedString(@"To be shipped", nil) button:self.messageShippingButton numMessage:3 index:1];
//    [self messageButtonWithTitle:NSLocalizedString(@"Shipped", nil) button:self.messageShippedButton numMessage:3 index:2];
//    [self messageButtonWithTitle:NSLocalizedString(@"Successful transaction", nil) button:self.messageSuccessfulButton numMessage:3 index:3];
    
    self.navigationItem.title = NSLocalizedString(@"Business Background", nil);
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    self.merchandiseButton = [self createButtonWithTitle:NSLocalizedString(@"My merchandise", nil) selector:@selector(merchandiseClicked:) row:0 coloum:0 image:[UIImage imageNamed:@"我的商品"] imageClick:[UIImage imageNamed:@"我的商品c"]];
    
    self.orderButton = [self createButtonWithTitle:NSLocalizedString(@"Order Management", nil) selector:@selector(orderClicked:) row:0 coloum:1 image:[UIImage imageNamed:@"订单管理"] imageClick:[UIImage imageNamed:@"订单管理c"]];
    self.returnsButton = [self createButtonWithTitle:NSLocalizedString(@"Returns Management", nil) selector:@selector(returnsClicked:) row:0 coloum:2 image:[UIImage imageNamed:@"退换货管理"] imageClick:[UIImage imageNamed:@"退换货管理c"]];
    self.commentsButton = [self createButtonWithTitle:NSLocalizedString(@"Comments", nil) selector:@selector(commentsClicked:) row:1 coloum:0 image:[UIImage imageNamed:@"评论留言"] imageClick:[UIImage imageNamed:@"评论留言c"]];
    
    self.profileButton = [self createButtonWithTitle:NSLocalizedString(@"My Profile", nil) selector:@selector(profileClicked:) row:1 coloum:1 image:[UIImage imageNamed:@"我的资料"] imageClick:[UIImage imageNamed:@"我的资料c"]];
    self.volumeButton = [self createButtonWithTitle:NSLocalizedString(@"Consumption volume verification", nil) selector:@selector(volumeClicked:) row:1 coloum:2 image:[UIImage imageNamed:@"消费卷验证"] imageClick:[UIImage imageNamed:@"消费卷验证c"]];
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector row:(int)ro coloum:(int)col image:(UIImage* )image imageClick:(UIImage* )imageClick{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.width = (self.view.width-20)/3;
    btn.height = (1.0*btn.width/image.size.width)*image.size.height;
    //    [btn setImage:image forState:UIControlStateNormal];
    //    [btn setImage:imageClick forState:UIControlStateSelected];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:imageClick forState:UIControlStateHighlighted];
    //［btn set
    //[btn.titleLabel setContentMode:UIViewContentModeBottom];
    //[btn sizeToFit];
    CGFloat f = 8;
    btn.left = f+(2+btn.width)*col;
    btn.top = f+(2+btn.height)*ro;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(btn.height-24, 0, 0, 0);
    UILabel* label = btn.titleLabel;
    //    label.text = title;
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [btn bringSubviewToFront:label];
    
    //btn.layer.borderWidth = 1.0;
    //btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

- (UIButton *)messageButtonWithTitle:(NSString *)title button:(UIButton*)btn numMessage:(NSInteger)num index:(NSInteger)colom
{
    NSString *str = [[NSString alloc]initWithFormat:@"%@\n%d",title,num];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.width = self.view.width/4;
    btn.height = 50;
    btn.left = self.view.width/4*colom;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.numberOfLines = 2;
    //btn.font = [UIFont systemFontOfSize:12];
    return btn;
}


- (IBAction)merchandiseClicked:(id)sender {
    HNBusinessListViewController *merchandise = [[HNBusinessListViewController alloc] initWithType:kGoods];
    [self.navigationController pushViewController:merchandise animated:YES];
}
- (IBAction)orderClicked:(id)sender {
    HNBusinessListViewController *order = [[HNBusinessListViewController alloc] initWithType:kOrder];
    [self.navigationController pushViewController:order animated:YES];
}
- (IBAction)returnsClicked:(id)sender {
    HNBusinessListViewController *comment=[[HNBusinessListViewController alloc] initWithType:kReturnGoods];
    [self.navigationController pushViewController:comment animated:YES];

}
- (IBAction)commentsClicked:(id)sender {
    HNBusinessListViewController *comment=[[HNBusinessListViewController alloc] initWithType:kComment];
    //HNCommentsAndMessageViewController* comments=[[HNCommentsAndMessageViewController alloc] init];
    [self.navigationController pushViewController:comment animated:YES];
}
- (IBAction)profileClicked:(id)sender{
    HNProfileViewController* pc = [[HNProfileViewController alloc]init];
    [self.navigationController pushViewController:pc animated:YES];
}
- (IBAction)volumeClicked:(id)sender {
    HNVolumeViewController* vc = [[HNVolumeViewController alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    [self.navigationController.view setUserInteractionEnabled:NO];
    [self presentViewController:nav animated:YES completion:^{
        [self.navigationController.view setUserInteractionEnabled:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
