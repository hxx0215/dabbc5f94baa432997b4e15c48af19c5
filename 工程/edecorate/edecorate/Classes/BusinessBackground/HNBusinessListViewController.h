//
//  HNBusinessListViewController.h
//  edecorate
//
//  Created by hxx on 9/27/14.
//
//

#import <UIKit/UIKit.h>
typedef enum HNBusinessType{
    kGoods = 0,
    kOrder,
    kReturnGoods,
    kComment,
    kProfile,
    kCoupons
}HNBusinessType;
@interface HNBusinessListViewController : UIViewController
- (instancetype)initWithType:(HNBusinessType)type;
@end
