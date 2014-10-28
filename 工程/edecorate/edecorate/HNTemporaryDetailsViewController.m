//
//  HNTemporaryDetailsViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNTemporaryDetailsViewController.h"
#import "UIView+AHKit.h"

@interface HNTemporaryDetailsViewController ()
@property (nonatomic, strong)IBOutlet UIScrollView *mainView;
@property (nonatomic, strong)IBOutlet UILabel *houseInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersPhoneNumberLabel;

@property (nonatomic, strong)IBOutlet UILabel *constructionUnitTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionUnitLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonPhoneNumberLabel;

@property (strong, nonatomic) IBOutlet UILabel *temporaryApplyMainLable;
@property (strong, nonatomic) IBOutlet UILabel *fireunitsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *useOfFireByTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireToolsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireLoadTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorTitleUILabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *validDocumentsTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *noticeFireButton;
@property (strong, nonatomic) IBOutlet UILabel *uploadTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkOutButton;

@property (strong, nonatomic) IBOutlet UILabel *fireunitsLabel;
@property (strong, nonatomic) IBOutlet UILabel *useOfFireByLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireToolsLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireLoadLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *validDocumentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploadStatusLable;

@property (strong, nonatomic) IBOutlet UILabel *statusLable;
@end

@implementation HNTemporaryDetailsViewController

-(id)initWithModel:(HNTemporaryModel *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.houseInfMainLabel.text = NSLocalizedString(@"House Information", nil);
    self.houseInfTitleLabel.text = NSLocalizedString(@"House Information", nil);
    self.constructionUnitTitleLabel.text = NSLocalizedString(@"Construction unit", nil);
    
    [self labelWithTitle:self.temporaryModel.huseInfo.houseInf label:self.houseInfLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionPerson label:self.constructionPersonLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.ownersPhoneNumber label:self.ownersPhoneNumberLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.owners label:self.ownersLabel];
    self.ownersLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.ownersPhoneNumberLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.ownersPhoneNumberLabel sizeToFit ];
    [self.ownersLabel sizeToFit ];
    self.ownersPhoneNumberLabel.right = self.view.width - 14;
    self.ownersLabel.right = self.ownersPhoneNumberLabel.left-5;
    
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionUnit label:self.constructionUnitLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionPersonPhoneNumber label:self.constructionPersonPhoneNumberLabel];
    self.constructionPersonLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.constructionPersonPhoneNumberLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.constructionPersonPhoneNumberLabel sizeToFit ];
    [self.constructionPersonLabel sizeToFit ];
    self.constructionPersonPhoneNumberLabel.right = self.view.width - 14;
    self.constructionPersonLabel.right = self.constructionPersonPhoneNumberLabel.left-5;
    
    
    [self labelWithTitle:NSLocalizedString(@"Start Time", nil) label:self.startTimeTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"End Time", nil) label:self.endTimeTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Operator", nil) label:self.operatorTitleUILabel];
    [self labelWithTitle:NSLocalizedString(@"Phone", nil) label:self.phoneTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Valid documents", nil) label:self.validDocumentsTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Upload", nil) label:self.uploadTitleLabel];
    
    if (self.temporaryModel.type==FIRE) {
        HNTemporaryFireModel* fmodel = (HNTemporaryFireModel*)self.temporaryModel;
        
        [self labelWithTitle:NSLocalizedString(@"Fire Apply", nil) label:self.temporaryApplyMainLable];
        [self labelWithTitle:NSLocalizedString(@"Fire units", nil) label:self.fireunitsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Use of fire by", nil) label:self.useOfFireByTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Fire tools", nil) label:self.fireToolsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Fire load", nil) label:self.fireLoadTitleLabel];
        [self.noticeFireButton setTitle:NSLocalizedString(@"Notice the use of fire", nil) forState:UIControlStateNormal];
        
        
        [self labelWithTitle:fmodel.dataInfo.fireUnits label:self.fireunitsLabel];
        [self labelWithTitle:fmodel.dataInfo.useOfFireBy label:self.useOfFireByLabel];
        [self labelWithTitle:fmodel.dataInfo.fireTools label:self.fireToolsLabel];
        [self labelWithTitle:fmodel.dataInfo.fireLoad label:self.fireLoadLabel];
        [self labelWithTitle:fmodel.dataInfo.startTime label:self.startTimeLabel];
        [self labelWithTitle:fmodel.dataInfo.endTime label:self.endTimeLabel];
        [self labelWithTitle:fmodel.dataInfo.operatorPerson label:self.operatorLabel];
        [self labelWithTitle:fmodel.dataInfo.phone label:self.phoneLabel];
        [self labelWithTitle:fmodel.dataInfo.validDocuments label:self.validDocumentsLabel];
    }else{
        HNTemporaryElectroModel* emodel = (HNTemporaryElectroModel*)self.temporaryModel;
        
        [self labelWithTitle:NSLocalizedString(@"Electro Apply", nil) label:self.temporaryApplyMainLable];
        [self labelWithTitle:NSLocalizedString(@"Electro units", nil) label:self.fireunitsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Use of electro by", nil) label:self.useOfFireByTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Electro tools", nil) label:self.fireToolsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Electro load", nil) label:self.fireLoadTitleLabel];
        [self.noticeFireButton setTitle:NSLocalizedString(@"Notice the use of electro", nil) forState:UIControlStateNormal];
        
        [self labelWithTitle:emodel.dataInfo.electroEnterprise label:self.fireunitsLabel];
        [self labelWithTitle:emodel.dataInfo.electroCause label:self.useOfFireByLabel];
        [self labelWithTitle:emodel.dataInfo.electroTool label:self.fireToolsLabel];
        [self labelWithTitle:emodel.dataInfo.electroLoad label:self.fireLoadLabel];
        [self labelWithTitle:emodel.dataInfo.electroBTime label:self.startTimeLabel];
        [self labelWithTitle:emodel.dataInfo.electroETime label:self.endTimeLabel];
        [self labelWithTitle:emodel.dataInfo.electroOperator label:self.operatorLabel];
        [self labelWithTitle:emodel.dataInfo.electroPhone label:self.phoneLabel];
        [self labelWithTitle:emodel.dataInfo.PapersImg label:self.validDocumentsLabel];
    }
    
    [self labelWithTitle:@"未上传" label:self.uploadStatusLable];
    
    //@property (strong, nonatomic) IBOutlet UIButton *commitButton;
    
    [self.noticeFireButton sizeToFit];
    
    
    [self.checkOutButton setTitle:NSLocalizedString(@"Check Out", nil) forState:UIControlStateNormal];
    [self.checkOutButton sizeToFit];
    self.checkOutButton.layer.borderWidth = 1.0;
    self.checkOutButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.statusLable setText:@"正在审核"];
    [self.statusLable sizeToFit];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainView.frame = [[UIScreen mainScreen] bounds];
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.statusLable.bottom+20);
}

- (IBAction)checkOut:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Check Out", nil) delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag=3;
    [alert show];
}

- (IBAction)noticeFireClicked:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"用火须知" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag = 2;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
//    [lab sizeToFit];
//    lab.font = [UIFont systemFontOfSize:12];
//    lab.numberOfLines = 2;
//    lab.layer.borderColor = [UIColor blackColor].CGColor;
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
