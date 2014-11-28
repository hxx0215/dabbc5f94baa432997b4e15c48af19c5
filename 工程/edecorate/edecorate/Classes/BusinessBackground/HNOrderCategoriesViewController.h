//
//  HNOrderCategoriesViewController.h
//  edecorate
//
//  Created by hxx on 11/27/14.
//
//

#import <UIKit/UIKit.h>
@class HNOrderCategoriesViewController;
@protocol HNOrderCategoriesDelegate <NSObject>

@optional
- (void)didSelect:(NSString *)orderState name:(NSString *)title;

@end
@interface HNOrderCategoriesViewController : UIViewController
@property (nonatomic, weak)id<HNOrderCategoriesDelegate> cateDelegate;
@end
