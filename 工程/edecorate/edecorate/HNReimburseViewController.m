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
@property (strong, nonatomic) IBOutlet UILabel *tips2Label;

@property (strong, nonatomic) UIView *alertContent;
@property (strong, nonatomic) UITextView *cancelMemo;
@property (strong, nonatomic) UILabel *cancelLabel;

@property (strong, nonatomic) UITextField *moneyTextField;

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
    self.tips2Label.font = [UIFont systemFontOfSize:12];
    self.tips2Label.text = @"";
    
    self.acceptButton.layer.borderWidth = 1.0;
    self.acceptButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.rejectButton.layer.borderWidth = 1.0;
    self.rejectButton.layer.borderColor = [UIColor blackColor].CGColor;
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
    switch (self.model.returnsType) {
        case kReturnGood:
        {
            [self labelWithTitle:@"买家收到货物，退货且退款" leftLabel:self.refundTypeTitleLabel label:self.refundTypeLabel];
            [self labelWithTitle:@"买家申请退款，等待卖家同意" leftLabel:self.refundStatusTitleLabel label:self.refundStatusLabel];
            
            [self.acceptButton setTitle:NSLocalizedString(@"Agree to a refund", nil) forState:UIControlStateNormal];
            [self.rejectButton setTitle:NSLocalizedString(@"Refused to refund", nil) forState:UIControlStateNormal];
        }
            break;
        case kReturnMoney:
        {
            [self labelWithTitle:@"买家收到货物，退货且退款" leftLabel:self.refundTypeTitleLabel label:self.refundTypeLabel];
            [self labelWithTitle:@"买家申请退款，卖家已收到退货，等待卖家同意" leftLabel:self.refundStatusTitleLabel label:self.refundStatusLabel];
            self.tips2Label.text = @"卖家(XXX)于2014/10/01 11:20:34同意了退款申请";
            [self.tips2Label sizeToFit];
            [self.acceptButton setTitle:NSLocalizedString(@"Receive a return, agree to a refund", nil) forState:UIControlStateNormal];
            [self.rejectButton setTitle:NSLocalizedString(@"Refused to refund Money", nil) forState:UIControlStateNormal];
        }
            
            break;
        case kReplaceGood:
        {
            [self labelWithTitle:@"买家收到货物，换货" leftLabel:self.refundTypeTitleLabel label:self.refundTypeLabel];
            [self labelWithTitle:@"买家申请换货，等待卖家同意" leftLabel:self.refundStatusTitleLabel label:self.refundStatusLabel];
            
            [self.acceptButton setTitle:NSLocalizedString(@"Agree to a refund", nil) forState:UIControlStateNormal];
            [self.rejectButton setTitle:NSLocalizedString(@"Refused to refund", nil) forState:UIControlStateNormal];
        }
            break;
        case kRedeliver:
        {
            [self labelWithTitle:@"买家收到货物，换货" leftLabel:self.refundTypeTitleLabel label:self.refundTypeLabel];
            [self labelWithTitle:@"买家申请换货，卖家已收到退货，等待卖家重新发货" leftLabel:self.refundStatusTitleLabel label:self.refundStatusLabel];
            self.tips2Label.text = @"卖家(XXX)于2014/10/01 11:20:34同意了换货申请";
            [self.tips2Label sizeToFit];
            [self.acceptButton setTitle:NSLocalizedString(@"Receive a return, re-send", nil) forState:UIControlStateNormal];
            [self.rejectButton setTitle:NSLocalizedString(@"Refused to refund", nil) forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }

    [self labelWithTitle:@"12345000000" leftLabel:self.orderNumberTitleLabel label:self.orderNumberLabel];
    [self labelWithTitle:@"12345000012" leftLabel:self.refundNumberTitleLabel label:self.refundNumberLabel];
    [self labelWithTitle:@"2014/10／01 14:20" leftLabel:self.refundTimeTitlesLabel label:self.refundTimeLabel];
    
    [self labelWithTitle:@"熊主管" leftLabel:self.buyersTitleLabel label:self.buyersLabel];
    [self labelWithTitle:@"20" leftLabel:self.refundAmountTitleLabel label:self.refundAmountLabel];
    [self labelWithTitle:@"没钱" leftLabel:self.refundReasonTitleLabel label:self.refundReasonLabel];
    [self labelWithTitle:@"快点" leftLabel:self.refundDescriptionTitleLabel label:self.refundDescriptionLabel];
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
    switch (self.model.returnsType) {
        case kReturnGood:
        {
            HNAcceptReturnGoodViewController *ac = [[HNAcceptReturnGoodViewController alloc]init];
            ac.model = self.model;
            //[self.navigationController pushViewController:ac animated:YES];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ac];
            nav.navigationBar.translucent = NO;
            [self.navigationController.view setUserInteractionEnabled:NO];
            [self presentViewController:nav animated:YES completion:^{
                [self.navigationController.view setUserInteractionEnabled:YES];
            }];
        }
            break;
        case kReturnMoney:
        {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
            self.cancelLabel = [[UILabel alloc] init];
            self.cancelLabel.text = NSLocalizedString(@"退款金额", nil);
            [self.cancelLabel sizeToFit];
            [view addSubview:self.cancelLabel];
            self.moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 260, 60)];
            self.moneyTextField.backgroundColor = [UIColor whiteColor];
            [view addSubview:self.moneyTextField];
            
            CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
            alertView.delegate = self;
            alertView.parentView = self.navigationController.view;
            alertView.containerView  = view;
            [alertView setButtonTitles:@[NSLocalizedString(@"OK", nil),NSLocalizedString(@"Cancel", nil)]];
            [alertView show];
        }
            break;
        case kReplaceGood:
        {
            self.model.returnsType = kRedeliver;
            [self updateData];
        }
            break;
        case kRedeliver:
        {
        }
            break;
            
        default:
            break;
    }
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
        switch (self.model.returnsType) {
            case kReturnGood:
            {
                self.cancelLabel.text = NSLocalizedString(@"拒绝退货说明", nil);
            }
                break;
            case kReturnMoney:
            {
                self.cancelLabel.text = NSLocalizedString(@"拒绝退款说明", nil);
            }
                break;
            case kReplaceGood:
            {
                self.cancelLabel.text = NSLocalizedString(@"拒绝换货说明", nil);
            }
                break;
            case kRedeliver:
            {
                self.cancelLabel.text = NSLocalizedString(@"拒绝重发说明", nil);
            }
                break;
                
            default:
                break;
        }

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
