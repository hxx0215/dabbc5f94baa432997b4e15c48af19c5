//
//  HNDecorateControlViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNDecorateControlViewController.h"
#import "UIView+AHKit.h"
#import "HNDecorateReportViewController.h"
#import "HNTemporaryFireViewController.h"
#import "HNOfficePassesViewController.h"
#import "HNDecorateCheckViewController.h"
#include "HNComplaintTableViewController.h"
#import "HNRefundTableViewController.h"
#import "HNOfficePassesApplyViewController.h"
#import "HNDeliverViewController.h"


/*
 装修报建
 装修验收
 办出入证
 临时用火
 临时用电
 送货安装
 押金退款
 我要投诉
 
 Reported that construction decoration
 Decoration acceptance
 Office passes
 Temporary fire
 Temporary power
 Delivery&Installation
 Deposit refund
 I have a complaint
 */

@interface HNDecorateControlViewController ()

@property (nonatomic, strong)UIButton *decorateReportedConstruction;
@property (nonatomic, strong)UIButton *decorateAcceptance;
@property (nonatomic, strong)UIButton *officePasses;
@property (nonatomic, strong)UIButton *temporaryFire;
@property (nonatomic, strong)UIButton *temporaryPower;
@property (nonatomic, strong)UIButton *deliveryAndInstallation;
@property (nonatomic, strong)UIButton *depositRefund;
@property (nonatomic, strong)UIButton *IHaveAComplaint;
@end


@implementation HNDecorateControlViewController


#define HSPACE 126
#define WLEFT 5
#define WRIGHT 20
#define WSPACE 10
#define TSPACEPER 0.1
#define STARTTOP 266

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.decorateReportedConstruction = [self createButtonWithTitle:NSLocalizedString(@"Reported that construction decoration", nil) selector:@selector(decorateReportedConstructionButton_Clicked:) row:0 coloum:0 image:[UIImage imageNamed:@"装修报建.png"] imageClick:[UIImage imageNamed:@"装修报建点击.png"]];
    
    self.decorateAcceptance = [self createButtonWithTitle:NSLocalizedString(@"Decoration acceptance", nil) selector:@selector(decorateAcceptanceButton_Clicked:) row:0 coloum:1 image:[UIImage imageNamed:@"装修验收.png"] imageClick:[UIImage imageNamed:@"装修验收点击.png"]];
    self.officePasses = [self createButtonWithTitle:NSLocalizedString(@"Office passes", nil) selector:@selector(officePassesButton_Clicked:) row:0 coloum:2 image:[UIImage imageNamed:@"办出入证.png"] imageClick:[UIImage imageNamed:@"办出入证点击.png"]];
    self.temporaryFire = [self createButtonWithTitle:NSLocalizedString(@"Temporary fire", nil) selector:@selector(temporaryFireConstructionButton_Clicked:) row:0 coloum:3 image:[UIImage imageNamed:@"临时用火.png"] imageClick:[UIImage imageNamed:@"临时用火点击.png"]];
    self.temporaryPower = [self createButtonWithTitle:NSLocalizedString(@"Temporary power", nil) selector:@selector(temporaryPowerButton_Clicked:) row:1 coloum:0 image:[UIImage imageNamed:@"临时用电.png"] imageClick:[UIImage imageNamed:@"临时用电点击.png"]];
    self.deliveryAndInstallation = [self createButtonWithTitle:NSLocalizedString(@"Delivery&Installation", nil) selector:@selector(deliveryAndInstallationButton_Clicked:) row:1 coloum:1 image:[UIImage imageNamed:@"送货安装.png"] imageClick:[UIImage imageNamed:@"送货安装点击.png"]];
    self.depositRefund = [self createButtonWithTitle:NSLocalizedString(@"Deposit refund", nil) selector:@selector(depositRefundButton_Clicked:) row:1 coloum:2 image:[UIImage imageNamed:@"押金退款.png"] imageClick:[UIImage imageNamed:@"押金退款点击.png"]];
    self.IHaveAComplaint = [self createButtonWithTitle:NSLocalizedString(@"I have a complaint", nil) selector:@selector(IHaveAComplaintButton_Clicked:) row:1 coloum:3 image:[UIImage imageNamed:@"我要投诉.png"] imageClick:[UIImage imageNamed:@"我要投诉点击.png"]];
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector row:(int)ro coloum:(int)col image:(UIImage* )image imageClick:(UIImage* )imageClick{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn.titleLabel sizeToFit];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:imageClick forState:UIControlStateSelected];
//    [btn.titleLabel setContentMode:UIViewContentModeCenter];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,
//                                              -image.size.width,
//                                              0.0,
//                                              0.0)];
//    
    [btn sizeToFit];
    // get the size of the elements here for readability
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + 4);
    // raise the image and push it right to center it
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    // lower the text and push it left to center it
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - image.size.width, - (totalHeight - titleSize.height),0.0);

    
    //btn.width = (self.view.width - 3 * WSPACE - WLEFT - WRIGHT)/4;
    //btn.height = btn.width;
    btn.left = (image.size.width+WSPACE)*col;
    btn.top = HSPACE+(image.size.width+HSPACE)*ro;
    //btn.layer.borderWidth = 1.0;
    //btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}


- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if (UIInterfaceOrientationIsPortrait(orientation)){
    }
    else{
    }
}

-(void)btnclicked:(UIButton*)btn
{
}

- (void)decorateReportedConstructionButton_Clicked:(id)sender{
    HNDecorateReportViewController *reportViewController = [[HNDecorateReportViewController alloc] init];
    [self.navigationController pushViewController:reportViewController animated:YES];
}

- (void)decorateAcceptanceButton_Clicked:(id)sender{
    HNDecorateCheckViewController *checkViewController = [[HNDecorateCheckViewController alloc] init];
    [self.navigationController pushViewController:checkViewController animated:YES];
}
- (void)officePassesButton_Clicked:(id)sender{
    HNOfficePassesViewController *officePassViewcontroller=[[HNOfficePassesViewController alloc] init];
    [self.navigationController pushViewController:officePassViewcontroller animated:YES];
    
    //HNOfficePassesApplyViewController *officePassApplyViewcontroller=[[HNOfficePassesApplyViewController alloc] init];
    //[self.navigationController pushViewController:officePassApplyViewcontroller animated:YES];
}

- (void)temporaryFireConstructionButton_Clicked:(id)sender{
    HNTemporaryFireViewController *temporaryViewController = [[HNTemporaryFireViewController alloc] initWithTemporaryType:FIRE];
    [self.navigationController pushViewController:temporaryViewController animated:YES];
}

- (void)temporaryPowerButton_Clicked:(id)sender{
    HNTemporaryFireViewController *temporaryViewController = [[HNTemporaryFireViewController alloc] initWithTemporaryType:POWER];
    [self.navigationController pushViewController:temporaryViewController animated:YES];
}

- (void)deliveryAndInstallationButton_Clicked:(id)sender{
    HNDeliverViewController *deliverViewController = [[HNDeliverViewController alloc]init];
    [self.navigationController pushViewController:deliverViewController animated:YES];
}

- (void)depositRefundButton_Clicked:(id)sender{
    HNRefundTableViewController *refundViewcontroller=[[HNRefundTableViewController alloc] init];
    [self.navigationController pushViewController:refundViewcontroller animated:YES];
}

- (void)IHaveAComplaintButton_Clicked:(id)sender{
    HNComplaintTableViewController *complaintViewController = [[HNComplaintTableViewController alloc] init];
    [self.navigationController pushViewController:complaintViewController animated:YES];
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
