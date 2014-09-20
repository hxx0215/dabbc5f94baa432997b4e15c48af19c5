//
//  HNComplaintDetailsViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNComplaintDetailsViewController.h"

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
@end

@implementation HNComplaintDetailsViewController

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
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfMainLabel];
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfTitleLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.houseInf label:self.houseInfLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Owners", nil) label:self.ownersTitleLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionPerson  label:self.constructionPersonLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone number", nil) label:self.ownersPhoneNumberTitleLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.ownersPhoneNumber  label:self.ownersPhoneNumberLabel];
    
    //constructionUnitTitleLabel
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.constructionUnitTitleLabel];
    
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionUnit  label:self.constructionUnitLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Person in charge of construction", nil) label:self.constructionPersonTitleLabel];
    
    [self labelWithTitle:self.temporaryModel.huseInfo.owners  label:self.ownersLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Phone number", nil) label:self.constructionPersonPhoneNumberTitleLabel];
    
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionPersonPhoneNumber  label:self.constructionPersonPhoneNumberLabel];
    

}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
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
