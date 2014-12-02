//
//  HNSelectChargeTableViewController.h
//  edecorate
//
//  Created by hxx on 12/2/14.
//
//

#import <UIKit/UIKit.h>
@protocol HNSelectChargeTableViewControllerDelegate <NSObject>
- (void)didSelect:(NSString*)roomNumber declareId:(NSString *)declareId data:(NSDictionary *)alldata;
@end
@interface HNSelectChargeTableViewController : UITableViewController
@property (nonatomic, weak)id<HNSelectChargeTableViewControllerDelegate> chargeDelegate;
@end
