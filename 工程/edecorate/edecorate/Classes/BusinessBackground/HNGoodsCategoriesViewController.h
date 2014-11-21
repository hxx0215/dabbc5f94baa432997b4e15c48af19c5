//
//  HNGoodsCategoriesViewController.h
//  edecorate
//
//  Created by hxx on 11/21/14.
//
//

#import <UIKit/UIKit.h>
@protocol HNGoodsCategoriesDelegate <NSObject>
- (void)didSelectGoods:(NSString *)classid;
@end
@interface HNGoodsCategoriesViewController : UIViewController
@property (nonatomic,strong) NSString *headid;
@property (nonatomic,weak) id<HNGoodsCategoriesDelegate> goodsDelegate;
@property (nonatomic, weak) UIViewController *root;
@end
