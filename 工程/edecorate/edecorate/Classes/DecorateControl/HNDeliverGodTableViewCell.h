//
//  HNDeliverGodTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-13.
//
//

#import <UIKit/UIKit.h>

@interface HNDeliverGodTableViewCell : UITableViewCell
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *bTimeTextField;
@property (strong, nonatomic) UITextField *endTimeTextField;

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *bTimeLabel;
@property (nonatomic, strong)UILabel *endTimeLabel;
@end
