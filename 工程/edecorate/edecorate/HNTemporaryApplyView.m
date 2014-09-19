//
//  HNTemporaryApplyView.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNTemporaryApplyView.h"
@interface HNTemporaryApplyView ()
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
@property (strong, nonatomic) IBOutlet UILabel *temporaryApplyMainLable;
@property (strong, nonatomic) IBOutlet UILabel *fireunitsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *useOfFireByTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *fireToolsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireLoadTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *validDocumentsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploadTitleLabel;
@end

@implementation HNTemporaryApplyView

- (id)init
{
    self = [super init];
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfMainLabel];
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfTitleLabel];
    NSString* houseiformation = @"深圳南三区么么大厦1层23楼";
    [self labelWithTitle:houseiformation label:self.houseInfLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Owners", nil) label:self.ownersTitleLabel];
    houseiformation = @"李大木";
    [self labelWithTitle:houseiformation label:self.constructionPersonLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone number", nil) label:self.ownersPhoneNumberTitleLabel];
    houseiformation = @"13560731432";
    [self.ownersPhoneNumberLabel setText:houseiformation];
    [self labelWithTitle:houseiformation label:self.ownersPhoneNumberLabel];
    
    //constructionUnitTitleLabel
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.constructionUnitTitleLabel];
    
    houseiformation = @"深圳装修公司";
    [self labelWithTitle:houseiformation label:self.constructionUnitLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Person in charge of construction", nil) label:self.constructionPersonTitleLabel];
    
    houseiformation = @"李大木";
    [self labelWithTitle:houseiformation label:self.ownersLabel];
    
    [self labelWithTitle:NSLocalizedString(@"Phone number", nil) label:self.constructionPersonPhoneNumberTitleLabel];
    
    houseiformation = @"13560731432";
    [self labelWithTitle:houseiformation label:self.constructionPersonPhoneNumberLabel];
    
    
    return self;
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
