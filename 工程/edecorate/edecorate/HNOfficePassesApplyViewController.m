//
//  HNOfficePassesApplyViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import "HNOfficePassesApplyViewController.h"
#import "HNOfficePassesViewController.h"
#import "UIView+AHKit.h"

@interface HNOfficePassesApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) IBOutlet UIScrollView *mainView;
@property (nonatomic,strong) IBOutlet UILabel *houseInfo;
@property (nonatomic,strong) IBOutlet UILabel *houseOwner;
@property (nonatomic,strong) IBOutlet UILabel *houseOwnerMobile;
@property (nonatomic,strong) IBOutlet UILabel *decorationCompany;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMobile;
@property (nonatomic,strong) IBOutlet UILabel *PasscardInfo;
@property (nonatomic,strong) IBOutlet UILabel *passcardsum;
@property (nonatomic,strong) IBOutlet UILabel *passcardManList;
@property (nonatomic,strong) IBOutlet UITextField *passcardName;
@property (nonatomic,strong) IBOutlet UITextField *passcardMobile;
@property (nonatomic,strong) IBOutlet UITextField *passcardIdcardNo;

@property (nonatomic,strong) IBOutlet UIButton *AddPassCardMan;

@property (nonatomic,strong) IBOutlet UILabel *passcardPerFee;
@property (nonatomic,strong) IBOutlet UILabel *passcardCount;
@property (nonatomic,strong) IBOutlet UILabel *passcardSumFee;
@property (nonatomic,strong) IBOutlet UILabel *depositPerFee;
@property (nonatomic,strong) IBOutlet UILabel *depositCount;
@property (nonatomic,strong) IBOutlet UILabel *depositSumFee;
@property (nonatomic,strong) IBOutlet UILabel *sumMoney;


@property (nonatomic,strong) IBOutlet UIButton *uploadIdCardPic;
@property (nonatomic,strong) IBOutlet UIButton *uploadPic;
@property (nonatomic,strong) IBOutlet UIButton *submit;

@end

@implementation HNOfficePassesApplyViewController

-(id)initWithModel:(HNTemporaryModel *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"申请";
    [self labelWithTitle:@"深圳南三区么么大厦1层23楼" label:self.houseInfo];
    [self labelWithTitle:@"王木" label:self.houseOwner];
    [self labelWithTitle:@"13811112222" label:self.houseOwnerMobile];
    
    [self labelWithTitle:@"深圳装修公司" label:self.decorationCompany];
    [self labelWithTitle:@"王二" label:self.decorationChargeMan];
    [self labelWithTitle:@"18999999999" label:self.decorationChargeMobile];
    
    [self labelWithTitle:@"已提交10人，剩余1人" label:self.PasscardInfo];
    [self labelWithTitle:@"1" label:self.passcardsum];
    [self labelWithTitle:@"王五，李四，张三" label:self.passcardManList];
    
    int officepassPerFee=10,depositFee=30;
    int officepassCount=1,depositCount=1;
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassPerFee] label:self.passcardPerFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount] label:self.passcardCount];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount*officepassPerFee] label:self.passcardSumFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositFee] label:self.depositPerFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount] label:self.depositCount];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee] label:self.depositSumFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee+officepassCount*officepassPerFee] label:self.sumMoney];
    
    [self.AddPassCardMan sizeToFit];
    self.AddPassCardMan.layer.borderWidth = 1.0;
    self.AddPassCardMan.layer.borderColor = [UIColor blackColor].CGColor;
    [self.uploadIdCardPic sizeToFit];
    self.uploadIdCardPic.layer.borderWidth = 1.0;
    self.uploadIdCardPic.layer.borderColor = [UIColor blackColor].CGColor;
    [self.uploadPic sizeToFit];
    self.uploadPic.layer.borderWidth = 1.0;
    self.uploadPic.layer.borderColor = [UIColor blackColor].CGColor;
    [self.submit sizeToFit];
    self.submit.layer.borderWidth = 1.0;
    self.submit.layer.borderColor = [UIColor blackColor].CGColor;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainView.frame = [[UIScreen mainScreen] bounds];
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.submit.bottom+20);
}

- (IBAction)checkOut:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"支付成功，您的申请已提交审核，请在审核通过够到物业管理处领取证件", nil) delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil,nil];
    alert.tag=1;
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
        self.temporaryModel.status = TemporaryStatusApplying;
        [self.navigationController popViewControllerAnimated:YES];
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
