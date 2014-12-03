//
//  HNNewReportChargeTableViewController.h
//  edecorate
//
//  Created by hxx on 12/3/14.
//
//

#import <UIKit/UIKit.h>
@class HNNewReportChargeTableViewController;
@protocol HNNewReportChargeDelegate<NSObject>
- (void)didSelectCharge:(NSDictionary *)charge;
@end
@interface HNNewReportChargeTableViewController : UITableViewController
@property (nonatomic, weak)id<HNNewReportChargeDelegate> chargeDelegate;
@end
