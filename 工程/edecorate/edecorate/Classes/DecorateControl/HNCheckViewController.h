//
//  HNCheckViewController.h
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import <UIKit/UIKit.h>

@interface HNCheckViewController : UIViewController
@property (nonatomic, strong) NSArray *contentArr;
@property (nonatomic, strong) NSString *declaretime;
@property (strong, nonatomic) NSString *shopreason;
@property (strong, nonatomic) NSString *shopaccessory;
@property (strong, nonatomic) NSString *manageAssessor;
@property (strong, nonatomic) NSString *manageckreason;
@property (strong, nonatomic) NSString *managecktime;
@property (strong, nonatomic) NSString *manageraccessory;
@property (strong, nonatomic) NSString *owneraccessory;
@property (strong, nonatomic) NSString *ownerAssessor;
@property (strong, nonatomic) NSString *ownerckreason;
@property (strong, nonatomic) NSString *ownercktime;
@property (strong, nonatomic) NSString *processname;
@property (assign, nonatomic) NSInteger state;
@end
