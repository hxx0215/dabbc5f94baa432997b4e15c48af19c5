//
//  HNConstructViewController.h
//  edecorate
//
//  Created by hxx on 10/23/14.
//
//

#import <UIKit/UIKit.h>
typedef enum HNConstructType{
    kCompanyNew = 0,
    kCompanyDetail,
    kPersonalNew,
    kPersonalDetail
} HNConstructType;
@interface HNConstructViewController : UIViewController
@property (nonatomic, assign)HNConstructType constructType;
@end
