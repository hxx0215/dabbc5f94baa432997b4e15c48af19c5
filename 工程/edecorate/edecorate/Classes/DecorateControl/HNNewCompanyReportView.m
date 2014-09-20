//
//  HNNewCompanyReportView.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNNewCompanyReportView.h"
#import "UIView+AHKit.h"


@interface HNNewCompanyReportView()
@property (nonatomic, strong)UILabel *companyDataLabel;
@property (nonatomic, strong)NSMutableArray *companyDataLabels;
@property (nonatomic, strong)UILabel *ownerDataLabel;
@property (nonatomic, strong)UILabel *roomNameLabel;
@property (nonatomic, strong)UILabel *areaLabel;
@property (nonatomic, strong)UILabel *communityLabel;
@property (nonatomic, strong)UILabel *ownerLabel;
@property (nonatomic, strong)UILabel *mobileLabel;
@property (nonatomic, strong)NSMutableArray *ownerDataLabels;
@property (nonatomic, strong)UILabel *uploadedLabel;
@property (nonatomic, strong)NSMutableArray *companyDatas;
@property (nonatomic, strong)NSMutableArray *ownerDatas;
@property (nonatomic, strong)NSMutableArray *companyDataButtons;
@property (nonatomic, strong)NSMutableArray *ownerDataButtons;
@property (nonatomic, strong)UIButton *areaButton;
@property (nonatomic, strong)UIButton *communityButton;

@end
@implementation HNNewCompanyReportView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.companyDataLabel = [self createLabelWithString:NSLocalizedString(@"Company Data", nil)];
        self.companyDatas = [@[NSLocalizedString(@"Company Certificate", nil),NSLocalizedString(@"tax Certificate", nil),NSLocalizedString(@"Organization Certificate", nil),NSLocalizedString(@"Qualification Certificate", nil),NSLocalizedString(@"Electrician Certificate", nil),NSLocalizedString(@"Power of attorney and Corporate identity", nil),NSLocalizedString(@"Charge of Construction's Identify", nil)] mutableCopy];
        [self initCompanyLabels];
        self.ownerDataLabel = [self createLabelWithString:NSLocalizedString(@"Owner Data", nil)];
        self.roomNameLabel = [self createLabelWithString:NSLocalizedString(@"Construction Room No.", nil)];
        self.areaLabel = [self createLabelWithString:NSLocalizedString(@"Area", nil)];
        self.communityLabel = [self createLabelWithString:NSLocalizedString(@"Community", nil)];
        self.ownerLabel = [self createLabelWithString:NSLocalizedString(@"Owner", nil)];
        self.mobileLabel = [self createLabelWithString:NSLocalizedString(@"Mobile", nil)];
        
        self.ownerDatas = [@[NSLocalizedString(@"Planar Structure", nil),NSLocalizedString(@"Floor Plan", nil),NSLocalizedString(@"Wall transformation diagram", nil),NSLocalizedString(@"The ceiling layout", nil),NSLocalizedString(@"Water layout", nil),NSLocalizedString(@"Circuit layout", nil)] mutableCopy];
        [self initOwnerLabels];
        
        self.areaButton = [self createButtonWithTag:101];
        self.communityButton = [self createButtonWithTag:102];
        
        self.purchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.purchaseButton.frame = CGRectMake(100, 0, 160, 35);
        
        [self.purchaseButton setTitle:NSLocalizedString(@"Go to Purchase", nil) forState:UIControlStateNormal];
        [self.purchaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.purchaseButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.purchaseButton.layer.borderWidth = 1.0;
        [self addSubview:self.purchaseButton];
        [self setMyInterface];
    }
    return self;
}

- (UILabel *)createLabelWithString:(NSString *)content{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
    label.text = content;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 2;
//    [label sizeToFit];
    [self addSubview:label];
    return label;
}
- (UIButton *)createButtonWithTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(230, 0, 70, 25);
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1.0;
    btn.tag = tag;
    [btn addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)initCompanyLabels{
    self.companyDataLabels = [[NSMutableArray alloc] init];
    self.companyDataButtons = [[NSMutableArray alloc] init];
    [self.companyDatas enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
        [self.companyDataLabels addObject:[self createLabelWithString:[NSString stringWithFormat:@"%lu、 %@",idx + 1,obj]]];
        [self.companyDataButtons addObject:[self createButtonWithTag:idx + 10]];
    }];
}
- (void)initOwnerLabels{
    self.ownerDataLabels = [[NSMutableArray alloc] init];
    self.ownerDataButtons = [[NSMutableArray alloc] init];
    [self.ownerDatas enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
        [self.ownerDataLabels addObject:[self createLabelWithString:[NSString stringWithFormat:@"%lu、%@",idx + 1, obj]]];
        [self.ownerDataButtons addObject:[self createButtonWithTag:idx + 50]];
    }];
}
- (void)setMyInterface{
    self.companyDataLabel.top = 0;
    __block CGFloat top = self.companyDataLabel.bottom;
    [self.companyDataLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop){
        UIButton *btn = (UIButton *)self.companyDataButtons[idx];
        top = [self setView:label Top:top];
        btn.centerY = label.centerY;
//        [label sizeToFit];
    }];
    
    top = [self setView:self.ownerDataLabel Top:top];
    top = [self setView:self.roomNameLabel Top:top];
    top = [self setView:self.areaLabel Top:top];
    top = [self setView:self.communityLabel Top:top];
    top = [self setView:self.ownerLabel Top:top];
    top = [self setView:self.mobileLabel Top:top];
    self.areaButton.centerY = self.areaLabel.centerY;
    self.communityButton.centerY = self.communityLabel.centerY;
    
    [self.ownerDataLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop){
        UIButton *btn = (UIButton *)self.ownerDataButtons[idx];
        btn.top = top;
        top = [self setView:label Top:top];
        btn.centerY = label.centerY;
//        [label sizeToFit];
    }];
    self.purchaseButton.top = top + 10;
    self.height = self.purchaseButton.bottom + 10;
}

- (CGFloat)setView:(UIView *)view Top:(CGFloat)top{
    view.top =top;
    return view.bottom;
}

- (void)upload:(id)sedner{
    
}


@end
