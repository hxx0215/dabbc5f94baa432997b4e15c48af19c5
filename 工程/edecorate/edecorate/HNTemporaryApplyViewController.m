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
@property (nonatomic, strong)IBOutlet UILabel *houseInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersPhoneNumberTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersPhoneNumberLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionUnitTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionUnitLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonPhoneNumberTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonPhoneNumberLabel;
@end

#define HSPACE 10
#define WSPACE 5
#define TSPACEPER 0.1
#define LABELHEIGHT 20
#define STARTTOP 10

@implementation HNTemporaryApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.houseInfMainLabel setText:NSLocalizedString(@"House Information", nil)];
    
    [self.houseInfTitleLabel setText:NSLocalizedString(@"House Information", nil)];
    
    NSString* houseiformation = @"深圳南三区么么大厦1层23楼";
    [self.houseInfLabel setText:houseiformation];
    
    [self.ownersTitleLabel setText:NSLocalizedString(@"Owners", nil)];
    
    houseiformation = @"李大木";
    [self.constructionPersonLabel setText:houseiformation];
    
    [self.ownersPhoneNumberTitleLabel setText:NSLocalizedString(@"Phone number", nil)];
    
    houseiformation = @"13560731432";
    [self.ownersPhoneNumberTitleLabel setText:houseiformation];
    
    
    //constructionUnitTitleLabel
    [self.constructionUnitTitleLabel setText:NSLocalizedString(@"Construction unit", nil)];
    
    houseiformation = @"深圳装修公司";
    [self.constructionUnitLabel setText:houseiformation];
    
    [self.constructionPersonTitleLabel setText:NSLocalizedString(@"Person in charge of construction", nil)];
    
    houseiformation = @"李大木";
    [self.ownersLabel setText:houseiformation];
    
    [self.constructionPersonPhoneNumberTitleLabel setText:NSLocalizedString(@"Phone number", nil)];
    
    houseiformation = @"13560731432";
    [self.constructionPersonPhoneNumberLabel setText:houseiformation];
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
