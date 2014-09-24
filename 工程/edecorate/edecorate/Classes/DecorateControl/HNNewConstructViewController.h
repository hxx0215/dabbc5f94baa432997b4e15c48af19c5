//
//  HNNewConstructViewController.h
//  edecorate
//
//  Created by hxx on 9/23/14.
//
//

#import <UIKit/UIKit.h>
typedef enum HNConstructType{
    kCompanyNew = 0,
    kPersonalNew,
    kCompanyDetail,
    kPersonalDetail
} HNConstructType;
@interface HNNewConstructViewController : UIViewController
@property (nonatomic, assign)HNConstructType constructType;
- (instancetype)initWithConstructType:(HNConstructType)constructType;
@end
