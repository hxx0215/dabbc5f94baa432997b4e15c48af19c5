//
//  HNPurchaseViewController.h
//  edecorate
//
//  Created by hxx on 10/24/14.
//
//

#import <UIKit/UIKit.h>

@interface HNPurchaseViewController : UIViewController
@property (nonatomic, strong) NSArray *mustPay;
@property (nonatomic, strong) NSArray *optionPay;
@property (nonatomic, strong) NSString *declareid;
@property (nonatomic, assign) NSInteger type;
@end
