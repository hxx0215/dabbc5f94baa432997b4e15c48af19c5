//
//  HNOfficePassesDetailsViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-21.
//
//

#import "HNOfficePassesDetailsViewController.h"
#import "UIView+AHKit.h"

@interface HNOfficePassesDetailsViewController ()

@property (nonatomic,strong) IBOutlet UIScrollView *mainView;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoMain;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoTitle;
@property (nonatomic,strong) IBOutlet UILabel *houseInfo;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwer;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwerMobile;

@property (nonatomic,strong) IBOutlet UILabel *decorationCompanyTitle;
@property (nonatomic,strong) IBOutlet UILabel *decorationCompany;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMobile;
/*
@property (nonatomic,strong) IBOutlet UILabel *decortionMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationManMobile;
@property (nonatomic,strong) IBOutlet UILabel *decorationIdCardNo;
@property (nonatomic,strong) IBOutlet UILabel *decorationIdCardPic;
@property (nonatomic,strong) IBOutlet UIButton *QueryDecorationIDCardPic;
@property (nonatomic,strong) IBOutlet UILabel *decorationPic;
@property (nonatomic,strong) IBOutlet UIButton *QueryDecorationPic;
*/
@property (nonatomic,strong) IBOutlet UILabel *personsLabel;

@property (nonatomic,strong) IBOutlet UILabel *passcardPerFee;
@property (nonatomic,strong) IBOutlet UILabel *passcardCount;
@property (nonatomic,strong) IBOutlet UILabel *passcardSumFee;
@property (nonatomic,strong) IBOutlet UILabel *depositPerFee;
@property (nonatomic,strong) IBOutlet UILabel *depositCount;
@property (nonatomic,strong) IBOutlet UILabel *depositSumFee;
@property (nonatomic,strong) IBOutlet UILabel *sumMoney;


@end

@implementation HNOfficePassesDetailsViewController

-(id)initWithModel:(HNPassData *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"Pass Details", nil);
    
    label:self.houseInfoMain.text = NSLocalizedString(@"House Information", nil) ;
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfoTitle];
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.decorationCompanyTitle];
    
    [self labelWithTitle:self.temporaryModel.roomnumber label:self.houseInfo];
    [self labelWithTitle:self.temporaryModel.ownername label:self.houseOnwer];
    [self labelWithTitle:self.temporaryModel.ownerphone label:self.houseOnwerMobile];
    self.houseOnwer.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.houseOnwerMobile.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.houseOnwerMobile sizeToFit ];
    [self.houseOnwer sizeToFit ];
    self.houseOnwerMobile.right = self.view.width - 14;
    self.houseOnwer.right = self.houseOnwerMobile.left-5;
    
    [self labelWithTitle:self.temporaryModel.shopname label:self.decorationCompany];
    [self labelWithTitle:self.temporaryModel.principal label:self.decorationChargeMan];
    [self labelWithTitle:self.temporaryModel.EnterprisePhone label:self.decorationChargeMobile];
    self.decorationChargeMan.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.decorationChargeMobile.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.decorationChargeMobile sizeToFit ];
    [self.decorationChargeMan sizeToFit ];
    self.decorationChargeMobile.right = self.view.width - 14;
    self.decorationChargeMan.right = self.decorationChargeMobile.left-5;
    
    NSString *str = [[NSString alloc]init];
    for (int i=0; i<[self.temporaryModel.proposerItems count];i++) {
        HNPassProposerData* proposerData = self.temporaryModel.proposerItems[i];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@ ",proposerData.name]];
    }
    if ([self.temporaryModel.proposerItems count]) {
        
//        [self labelWithTitle:proposerData.name label:self.decortionMan];
//        [self labelWithTitle:proposerData.phone label:self.decorationManMobile];
//        [self labelWithTitle:proposerData.IDcard  label:self.decorationIdCardNo];
//        [self labelWithTitle:proposerData.Icon label:self.decorationIdCardPic];
//        [self labelWithTitle:proposerData.isTransaction label:self.decorationPic];
    }
    self.personsLabel.text = str;
    
 
    int officepassPerFee=10,depositFee=30;
    int officepassCount=1,depositCount=1;
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassPerFee] label:self.passcardPerFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount] label:self.passcardCount];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount*officepassPerFee] label:self.passcardSumFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositFee] label:self.depositPerFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount] label:self.depositCount];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee] label:self.depositSumFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee+officepassCount*officepassPerFee] label:self.sumMoney];
    // Do any additional setup after loading the view from its nib.
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    //[lab sizeToFit];
    //lab.font = [UIFont systemFontOfSize:12];
    //lab.numberOfLines = 2;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainView.frame = [[UIScreen mainScreen] bounds];
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.sumMoney.bottom+20);
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
