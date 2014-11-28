//
//  HNReturnCategoriesViewController.h
//  edecorate
//
//  Created by hxx on 11/28/14.
//
//

#import <UIKit/UIKit.h>
@class HNReturnCategoriesViewController;
@protocol HNReturnCategoriesDelegate <NSObject>

@optional
- (void)didSelectType:(NSString *)type name:(NSString *)title;

@end
@interface HNReturnCategoriesViewController : UIViewController
@property (nonatomic, weak)id<HNReturnCategoriesDelegate> cateDelegate;
@end
