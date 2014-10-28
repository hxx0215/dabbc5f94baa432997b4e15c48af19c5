//
//  HNComplaintDetailsViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNComplaintDetailsViewController.h"
#import "UIView+AHKit.h"

@interface HNComplaintDetailsViewController ()
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

@property (nonatomic, strong)IBOutlet UILabel *complaintInformationTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintCategoryTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintObjectTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintIssueTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *evidenceTitleLable;

@property (nonatomic, strong)IBOutlet UILabel *complaintCategoryLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintObjectLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintIssueLable;

@property (nonatomic, strong)IBOutlet UILabel *uploadStatusLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintStatusLable;
@property (nonatomic, strong)IBOutlet UIButton *checkOutButton;
@end

@implementation HNComplaintDetailsViewController

-(id)initWithModel:(HNComplaintData *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfMainLabel];
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfTitleLabel];
    [self labelWithTitle:self.temporaryModel.room label:self.houseInfLabel];
    
    
    [self labelWithTitle:@"laochen"  label:self.constructionPersonLabel];
    [self labelWithTitle:@"13330333033"  label:self.ownersPhoneNumberLabel];
    
    //constructionUnitTitleLabel
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.constructionUnitTitleLabel];
    
    [self labelWithTitle:@"feiniao"  label:self.constructionUnitLabel];
    
    
    [self labelWithTitle:@"laochen"  label:self.ownersLabel];
    
    [self labelWithTitle:@"13330333033"  label:self.constructionPersonPhoneNumberLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Phone number", nil) label:self.constructionPersonPhoneNumberTitleLabel];
    
    [self labelWithTitle:@"13330330300" label:self.constructionPersonPhoneNumberLabel];
    
    //Complaint Information
    [self labelWithTitle:NSLocalizedString(@"Complaint Information", nil) label:self.complaintInformationTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Category", nil) label:self.complaintCategoryTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Object", nil) label:self.complaintObjectTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Issue", nil) label:self.complaintIssueTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Evidence", nil) label:self.evidenceTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Uploaded", nil) label:self.uploadStatusLable];
    
//    [self labelWithTitle:self.temporaryModel.complaintInfo.complaintCategory label:self.complaintCategoryLable];
//    [self labelWithTitle:self.temporaryModel.complaintInfo.complaintObject label:self.complaintObjectLable];
//    [self.complaintIssueLable setText:self.temporaryModel.complaintInfo.complaintIssue];
    self.complaintIssueLable.font = [UIFont systemFontOfSize:12];
    [self.complaintIssueLable sizeToFit];
    self.complaintIssueLable.numberOfLines = 4;

    CGFloat pos = self.complaintIssueLable.bottom>self.complaintIssueTitleLable.bottom?self.complaintIssueLable.bottom:self.complaintIssueTitleLable.bottom;
    self.checkOutButton.top = pos+self.complaintIssueTitleLable.top-self.complaintObjectTitleLable.bottom;
    self.uploadStatusLable.top = self.checkOutButton.top;
    self.evidenceTitleLable.top = self.checkOutButton.top;
    self.complaintStatusLable.top = self.checkOutButton.bottom+2;
    
    [self.checkOutButton setTitle:NSLocalizedString(@"Check Out", nil) forState:UIControlStateNormal];
    self.checkOutButton.layer.borderWidth = 1.0;
    self.checkOutButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.complaintStatusLable setText:NSLocalizedString(@"Processing", nil)];
    [self.complaintStatusLable sizeToFit];
    /*
     "Processing" ＝ "正在处理";*/
    
}

- (IBAction)checkOut:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Check Out", nil) delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag=3;
    [alert show];
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    lab.layer.borderColor = [UIColor blackColor].CGColor;
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
