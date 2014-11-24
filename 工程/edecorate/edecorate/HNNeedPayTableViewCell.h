//
//  HNNeedPayTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-24.
//
//

#import <UIKit/UIKit.h>

@interface HNNeedPayTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *price;
@property (nonatomic, strong)UILabel *detail;
@property (nonatomic, assign)NSInteger single;
@property (nonatomic, strong)UIButton *checkButton;

@end
