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

#define HSPACE 50
#define WSPACE 15
#define TSPACEPER 0.1
#define BTNHEIGHT 50
#define STARTTOP 50

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.decorateReportedConstruction = [self createButtonWithTitle:NSLocalizedString(@"Reported that construction decoration", nil) selector:@selector(decorateReportedConstructionButton_Clicked:) row:0 coloum:0];
    self.decorateAcceptance = [self createButtonWithTitle:NSLocalizedString(@"Decoration acceptance", nil) selector:@selector(decorateAcceptanceButton_Clicked:) row:0 coloum:1];
    self.officePasses = [self createButtonWithTitle:NSLocalizedString(@"Office passes", nil) selector:@selector(officePassesButton_Clicked:) row:0 coloum:2];
    self.temporaryFire = [self createButtonWithTitle:NSLocalizedString(@"Temporary fire", nil) selector:@selector(temporaryFireConstructionButton_Clicked:) row:1 coloum:0];
    self.temporaryPower = [self createButtonWithTitle:NSLocalizedString(@"Temporary power", nil) selector:@selector(temporaryPowerButton_Clicked:) row:1 coloum:1];
    self.deliveryAndInstallation = [self createButtonWithTitle:NSLocalizedString(@"Delivery&Installation", nil) selector:@selector(deliveryAndInstallationButton_Clicked:) row:1 coloum:2];
    self.depositRefund = [self createButtonWithTitle:NSLocalizedString(@"Deposit refund", nil) selector:@selector(depositRefundButton_Clicked:) row:2 coloum:0];
    self.IHaveAComplaint = [self createButtonWithTitle:NSLocalizedString(@"I have a complaint", nil) selector:@selector(IHaveAComplaintButton_Clicked:) row:2 coloum:1];
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector row:(int)ro coloum:(int)col{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.width = (self.view.width - 5 * WSPACE)/3;
    btn.height = BTNHEIGHT;
    btn.left = WSPACE+(btn.width+WSPACE)*col;
    btn.top = HSPACE+(BTNHEIGHT+HSPACE)*ro;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
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
    NSLog(@"decorateAcceptance");
}
- (void)officePassesButton_Clicked:(id)sender{
    NSLog(@"officePasses");
}

- (void)temporaryFireConstructionButton_Clicked:(id)sender{
    NSLog(@"temporaryFire");
}

- (void)temporaryPowerButton_Clicked:(id)sender{
    NSLog(@"temporaryPower");
}

- (void)deliveryAndInstallationButton_Clicked:(id)sender{
    NSLog(@"deliveryAndInstallation");
}

- (void)depositRefundButton_Clicked:(id)sender{
    NSLog(@"depositRefund");
}

- (void)IHaveAComplaintButton_Clicked:(id)sender{
    NSLog(@"IHaveAComplaint");
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
