//
//  HNPurchaseViewController.h
//  edecorate
//
//  Created by hxx on 10/24/14.
//
//

#import <UIKit/UIKit.h>

@interface HNPurchaseViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *mustPay;
@property (nonatomic, strong) NSMutableArray *optionPay;
@property (nonatomic, strong) NSString *declareid;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSMutableArray *allData;
@end
