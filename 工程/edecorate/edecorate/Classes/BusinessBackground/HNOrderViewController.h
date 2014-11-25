//
//  HNOrderViewController.h
//  edecorate
//
//  Created by hxx on 9/28/14.
//
//

#import <UIKit/UIKit.h>
typedef enum HNOrderType{
    kWaiting=0,
    kUnsolved,
    kSended,
    kDone
}HNOrderType;
@interface HNOrderViewController : UIViewController
@property (strong, nonatomic) NSString *orderid;
@end
