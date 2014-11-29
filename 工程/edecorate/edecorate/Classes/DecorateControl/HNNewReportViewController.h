//
//  HNNewReportViewController.h
//  edecorate
//
//  Created by hxx on 11/10/14.
//
//

#import <UIKit/UIKit.h>

@interface HNNewReportViewController : UIViewController
@property (nonatomic, assign)NSInteger constructType; //1公司0个人
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *roomNumber;
@property (strong, nonatomic) NSString *ownername;
@property (strong, nonatomic) NSString *ownerphone;
@property (nonatomic, strong)NSDictionary *allData;
@end
