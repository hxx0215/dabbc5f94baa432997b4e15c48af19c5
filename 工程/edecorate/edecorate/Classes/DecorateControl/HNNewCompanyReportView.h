//
//  HNNewCompanyReportView.h
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import <UIKit/UIKit.h>

@class HNNewCompanyReportView;
@protocol HNNewCompanyReportViewDelegate <NSObject>
- (void)companyReportView:(HNNewCompanyReportView *)reportView shouldUpload:(NSInteger)tag;
@end
@interface HNNewCompanyReportView : UIView
@property (nonatomic, strong)UIButton *purchaseButton;
@property (nonatomic, weak)id<HNNewCompanyReportViewDelegate> controller;
- (void)buttonImageSelected:(NSInteger)tag;
@end
