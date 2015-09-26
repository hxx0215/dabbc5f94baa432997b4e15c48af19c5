//
//  HNConstructViewController.h
//  edecorate
//
//  Created by hxx on 10/23/14.
//
//

#import <UIKit/UIKit.h>
#define kOriginalSChart @"OriginalSChart"
#define kfloorplan @"floorplan"
#define kwallRemould @"wallRemould"
#define kceilingPlan @"ceilingPlan"
#define kWaterwayPlan @"WaterwayPlan"
#define kBlockDiagram @"BlockDiagram"
#define kshopInfo @"shopInfo"
typedef enum HNConstructType{
    kCompanyNew = 0,
    kCompanyDetail,
    kPersonalNew,
    kPersonalDetail
} HNConstructType;
@interface HNConstructViewController : UIViewController
@property (nonatomic, assign)HNConstructType constructType;
@property (nonatomic, strong)NSString *roomNo;
@property (nonatomic, strong)NSString *ownerName;
@property (nonatomic, strong)NSString *ownerMobile;
@property (nonatomic, strong)NSString *declareid;
@property (nonatomic, strong)NSMutableDictionary *chart;
@property (nonatomic, strong)NSMutableDictionary *shopInfo;
@property (nonatomic, strong)NSString *assessorstate;
@property (nonatomic, strong)NSNumber *paystate;
@property (nonatomic, strong)NSDictionary *allData;
@end
