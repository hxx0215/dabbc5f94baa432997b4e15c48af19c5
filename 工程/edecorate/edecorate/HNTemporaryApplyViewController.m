//
//  HNTemporaryApplyViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import "HNTemporaryApplyViewController.h"
#import "UIView+AHKit.h"
/*
 "House Information" = "房屋信息";
 "Owners" = "业主";
 "Phone number" = "手机号";
 "Construction unit" = "施工单位";
 "Person in charge of construction" = "施工负责人";
 "Notice the use of fire" = "用火须知";
 "Fire units" = "用火单位";
 "Use of fire by" = "用火是由";
 "Fire tools" = "用火工具";
 "Fire load" = "用火负荷";
 "Start Time" = "开始时间";
 "End Time" = "结束时间";
 "Operator" = "操作人";
 "Phone" = "联系电话";
 "Valid documents" = "有效证件";
 "Upload" = "上传";
 "Submission" = "提交申请";
 */
@interface HNTemporaryApplyViewController ()
@property (nonatomic, strong)UILabel *houseInfMainLabel;
@property (nonatomic, strong)UILabel *houseInfTitleLabel;
@property (nonatomic, strong)UILabel *houseInfLabel;
@property (nonatomic, strong)UILabel *ownersTitleLabel;
@property (nonatomic, strong)UILabel *ownersLabel;
@property (nonatomic, strong)UILabel *ownersPhoneNumberTitleLabel;
@property (nonatomic, strong)UILabel *ownersPhoneNumberLabel;
@property (nonatomic, strong)UILabel *constructionUnitTitleLabel;
@property (nonatomic, strong)UILabel *constructionUnitLabel;
@property (nonatomic, strong)UILabel *constructionPersonTitleLabel;
@property (nonatomic, strong)UILabel *constructionPersonLabel;
@property (nonatomic, strong)UILabel *constructionPersonPhoneNumberTitleLabel;
@property (nonatomic, strong)UILabel *constructionPersonPhoneNumberLabel;
@end

#define HSPACE 10
#define WSPACE 5
#define TSPACEPER 0.1
#define LABELHEIGHT 20
#define STARTTOP 10

@implementation HNTemporaryApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger width = self.view.width;
    NSInteger height = self.view.height;
    self.view.backgroundColor = [UIColor whiteColor];
    self.houseInfMainLabel = [self createLabelWithTitle:NSLocalizedString(@"House Information", nil)];
    self.houseInfMainLabel.top = STARTTOP;
    self.houseInfMainLabel.left = WSPACE;
    self.houseInfMainLabel.width = width - 2*WSPACE;
    self.houseInfMainLabel.textColor = [UIColor greenColor];
    
    self.houseInfTitleLabel = [self createLabelWithTitle:NSLocalizedString(@"House Information", nil)];
    self.houseInfTitleLabel.top = STARTTOP+LABELHEIGHT;
    self.houseInfTitleLabel.left = WSPACE;
    
    NSInteger lableWidth = self.houseInfTitleLabel.width;
    NSInteger lableLeft = self.houseInfTitleLabel.width+2*WSPACE;
    
    NSString* houseiformation = @"深圳南三区么么大厦1层23楼";
    self.houseInfLabel = [self createLabelWithTitle:houseiformation];
    self.houseInfLabel.top = STARTTOP+LABELHEIGHT;
    self.houseInfLabel.left = lableLeft;
    
    self.ownersTitleLabel = [self createLabelWithTitle:NSLocalizedString(@"Owners", nil)];
    self.ownersTitleLabel.top = STARTTOP+2*LABELHEIGHT;
    self.ownersTitleLabel.left = WSPACE;
    self.ownersTitleLabel.width = lableWidth;
    
    houseiformation = @"李大木";
    self.constructionPersonLabel = [self createLabelWithTitle:houseiformation];
    self.constructionPersonLabel.top = STARTTOP+2*LABELHEIGHT;
    self.constructionPersonLabel.left = lableLeft;
    self.constructionPersonLabel.width = width/2-lableLeft-HSPACE;
    
    self.ownersPhoneNumberTitleLabel = [self createLabelWithTitle:NSLocalizedString(@"Phone number", nil)];
    self.ownersPhoneNumberTitleLabel.top = STARTTOP+2*LABELHEIGHT;
    self.ownersPhoneNumberTitleLabel.left = width/2-HSPACE;
    self.ownersPhoneNumberTitleLabel.width = lableWidth;
    
    houseiformation = @"13560731432";
    self.ownersPhoneNumberTitleLabel = [self createLabelWithTitle:houseiformation];
    self.ownersPhoneNumberTitleLabel.top = STARTTOP+2*LABELHEIGHT;
    self.ownersPhoneNumberTitleLabel.left = width - self.ownersPhoneNumberTitleLabel.right;
    
    
    //constructionUnitTitleLabel
    self.constructionUnitTitleLabel = [self createLabelWithTitle:NSLocalizedString(@"Construction unit", nil)];
    self.constructionUnitTitleLabel.top = STARTTOP+3*LABELHEIGHT;
    self.constructionUnitTitleLabel.left = WSPACE;
    
    houseiformation = @"深圳装修公司";
    self.constructionUnitLabel = [self createLabelWithTitle:houseiformation];
    self.constructionUnitLabel.top = STARTTOP+3*LABELHEIGHT;
    self.constructionUnitLabel.left = lableLeft;
    
    self.constructionPersonTitleLabel = [self createLabelWithTitle:NSLocalizedString(@"Person in charge of construction", nil)];
    self.constructionPersonTitleLabel.top = STARTTOP+4*LABELHEIGHT;
    self.constructionPersonTitleLabel.left = WSPACE;
    self.constructionPersonTitleLabel.width = lableWidth;
    
    houseiformation = @"李大木";
    self.ownersLabel = [self createLabelWithTitle:houseiformation];
    self.ownersLabel.top = STARTTOP+4*LABELHEIGHT;
    self.ownersLabel.left = lableLeft;
    self.ownersLabel.width = width/2-lableLeft-HSPACE;
    
    self.constructionPersonPhoneNumberTitleLabel = [self createLabelWithTitle:NSLocalizedString(@"Phone number", nil)];
    self.constructionPersonPhoneNumberTitleLabel.top = STARTTOP+4*LABELHEIGHT;
    self.constructionPersonPhoneNumberTitleLabel.left = width/2-HSPACE;
    self.constructionPersonPhoneNumberTitleLabel.width = lableWidth;
    
    houseiformation = @"13560731432";
    self.constructionPersonPhoneNumberLabel = [self createLabelWithTitle:houseiformation];
    self.constructionPersonPhoneNumberLabel.top = STARTTOP+4*LABELHEIGHT;
    self.constructionPersonPhoneNumberLabel.left = self.ownersPhoneNumberTitleLabel.left;
    // Do any additional setup after loading the view.
}

- (UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:title];
    [lab setTextColor:[UIColor blackColor]];
    [lab sizeToFit];
    lab.height = LABELHEIGHT;
    lab.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:lab];
    return lab;
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
