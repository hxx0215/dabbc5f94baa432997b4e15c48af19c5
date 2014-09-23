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
@property (nonatomic,strong) IBOutlet UILabel *houseInfo;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwer;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwerMobile;
@property (nonatomic,strong) IBOutlet UILabel *decorationCompany;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMobile;
@property (nonatomic,strong) IBOutlet UILabel *decortionMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationManMobile;
@property (nonatomic,strong) IBOutlet UILabel *decorationIdCardNo;
@property (nonatomic,strong) IBOutlet UILabel *decorationIdCardPic;
@property (nonatomic,strong) IBOutlet UIButton *QueryDecorationIDCardPic;
@property (nonatomic,strong) IBOutlet UILabel *decorationPic;
@property (nonatomic,strong) IBOutlet UIButton *QueryDecorationPic;
@property (nonatomic,strong) IBOutlet UILabel *passcardPerFee;
@property (nonatomic,strong) IBOutlet UILabel *passcardCount;
@property (nonatomic,strong) IBOutlet UILabel *passcardSumFee;
@property (nonatomic,strong) IBOutlet UILabel *depositPerFee;
@property (nonatomic,strong) IBOutlet UILabel *depositCount;
@property (nonatomic,strong) IBOutlet UILabel *depositSumFee;
@property (nonatomic,strong) IBOutlet UILabel *sumMoney;


@end

@implementation HNOfficePassesDetailsViewController

-(id)initWithModel:(HNTemporaryModel *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"详情";
    [self labelWithTitle:@"深圳南三区么么大厦1层23楼" label:self.houseInfo];
    [self labelWithTitle:@"吴先生" label:self.houseOnwer];
    [self labelWithTitle:@"13888889999" label:self.houseOnwerMobile];
    
    [self labelWithTitle:@"XX装修公司" label:self.decorationCompany];
    [self labelWithTitle:@"李大" label:self.decorationChargeMan];
    [self labelWithTitle:@"13511112222" label:self.decorationChargeMobile];
    
    [self labelWithTitle:@"王二小" label:self.decortionMan];
    [self labelWithTitle:@"18999999999" label:self.decorationManMobile];
    [self labelWithTitle:@"430726198910010522" label:self.decorationIdCardNo];
    [self labelWithTitle:@"已上传" label:self.decorationIdCardPic];
    [self labelWithTitle:@"已上传" label:self.decorationPic];
 
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
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    lab.layer.borderColor = [UIColor blackColor].CGColor;
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
