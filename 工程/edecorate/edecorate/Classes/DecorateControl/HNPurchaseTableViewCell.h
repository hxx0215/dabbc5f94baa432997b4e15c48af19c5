//
//  HNPurchaseTableViewCell.h
//  edecorate
//
//  Created by hxx on 10/24/14.
//
//

#import <UIKit/UIKit.h>

@interface HNPurchaseTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *price;
@property (nonatomic, strong)UILabel *detail;
@property (nonatomic, assign)NSInteger single;
@property (nonatomic, strong)UIButton *checkButton;
@end
