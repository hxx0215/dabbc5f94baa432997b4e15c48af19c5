//
//  HNReimburseViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-28.
//
//

#import "HNReimburseViewController.h"
#include "UIView+AHKit.h"
#include "HNAcceptReturnGoodViewController.h"
#import "CustomIOS7AlertView.h"

@interface HNReimburseViewController ()<CustomIOS7AlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UIButton *rejectButton;

@property (strong, nonatomic) IBOutlet UILabel *orderNumberTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundNumberTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundTimeTitlesLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundTypeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundStatusTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyersTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundAmountTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundReasonTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundDescriptionTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyersLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundReasonLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundDescriptionLabel;

@property (strong, nonatomic) IBOutlet UILabel *productInformationTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundRecordTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *refundFlagLabel;
@property (strong, nonatomic) IBOutlet UILabel *tipsLabel;

@property (strong, nonatomic) UIView *alertContent;
@property (strong, nonatomic) UITextView *cancelMemo;
@property (strong, nonatomic) UILabel *cancelLabel;

/*
"Order details" = "订单详情";
"Order number" = "订单单号";
"Refund number" = "退款单号";
"Refund Type" = "退款申请类型";
"Refund status" = "退款状态";
"Buyers" = "买家";
"Refund Amount" = "退款金额";
"Refund Reason" = "退款原因";
"Refund Description" = "退款说明";
"Product Information" = "商品信息";
"Refund Record" = "退款记录";
"Agree to a refund" = "同意退款";
"Refused to refund" = "拒绝退款";
"Product Name" = "商品名称";
"Refund" = "退款";
"Returns" = "退货";
"Repair" = "报修";
"Replacement" = "换货";
 */

@end

@implementation HNReimburseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self labelWithTitle:NSLocalizedString(@"Order number", nil) label:self.orderNumberTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund number", nil) label:self.refundNumberTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Time to apply for a refund", nil) label:self.refundTimeTitlesLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund Type", nil) label:self.refundTypeTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund status", nil) label:self.refundStatusTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Buyers", nil) label:self.buyersTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund Amount", nil) label:self.refundAmountTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund Reason", nil) label:self.refundReasonTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund Description", nil) label:self.refundDescriptionTitleLabel];
    
    //[self labelWithTitle:NSLocalizedString(@"Product Information", nil) label:self.productInformationTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Refund Record", nil) label:self.refundRecordTitleLabel];
    self.tipsLabel.font = [UIFont systemFontOfSize:12];
    
    self.acceptButton.layer.borderWidth = 1.0;
    self.acceptButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.acceptButton setTitle:NSLocalizedString(@"Agree to a refund", nil) forState:UIControlStateNormal];
    self.rejectButton.layer.borderWidth = 1.0;
    self.rejectButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.rejectButton setTitle:NSLocalizedString(@"Refused to refund", nil) forState:UIControlStateNormal];
    
    self.navigationItem.title = NSLocalizedString(@"Order details", nil);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateData];
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.acceptButton.bottom+20);
}

-(void)updateData
{
    [self labelWithTitle:@"123" leftLabel:self.orderNumberTitleLabel label:self.orderNumberLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundNumberTitleLabel label:self.refundNumberLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundTimeTitlesLabel label:self.refundTimeLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundTypeTitleLabel label:self.refundTypeLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundStatusTitleLabel label:self.refundStatusLabel];
    [self labelWithTitle:@"123" leftLabel:self.buyersTitleLabel label:self.buyersLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundAmountTitleLabel label:self.refundAmountLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundReasonTitleLabel label:self.refundReasonLabel];
    [self labelWithTitle:@"123" leftLabel:self.refundDescriptionTitleLabel label:self.refundDescriptionLabel];
}


- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)labelWithTitle:(NSString *)title leftLabel:(UILabel*)leftlab label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:11];
    lab.numberOfLines = 2;
    lab.left = leftlab.left+leftlab.width;
    lab.top = leftlab.top;
    lab.height = leftlab.height;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (IBAction)acceptButtonClick:(id)sender
{
    HNAcceptReturnGoodViewController *ac = [[HNAcceptReturnGoodViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
}

- (IBAction)rejectButtonClick:(id)sender
{
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    alertView.delegate = self;
    alertView.parentView = self.navigationController.view;
    alertView.containerView  = self.alertContent;
    [alertView setButtonTitles:@[NSLocalizedString(@"OK", nil),NSLocalizedString(@"Cancel", nil)]];
    [alertView show];
    
    //[self.navigationController popViewControllerAnimated:YES];
    
}
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    };
}

- (UIView *)alertContent{
    if (!_alertContent){
        _alertContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
        self.cancelLabel = [[UILabel alloc] init];
        self.cancelLabel.text = NSLocalizedString(@"Refused to refund", nil);
        [self.cancelLabel sizeToFit];
        [_alertContent addSubview:self.cancelLabel];
        self.cancelMemo = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, 260, 160)];
        [_alertContent addSubview:self.cancelMemo];
    }
    return _alertContent;
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
