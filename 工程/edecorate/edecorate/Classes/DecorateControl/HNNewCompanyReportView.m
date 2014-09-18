//
//  HNNewCompanyReportView.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNNewCompanyReportView.h"
@interface HNNewCompanyReportView()
@property (nonatomic, strong)UILabel *companyDocLabel;
@property (nonatomic, strong)NSMutableArray *docLabels;
@property (nonatomic, strong)UILabel *ownerDocLabel;
@property (nonatomic, strong)UILabel *roomNameLabel;
@property (nonatomic, strong)UILabel *areaLabel;
@property (nonatomic, strong)UILabel *communityLabel;

@end
@implementation HNNewCompanyReportView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



@end
