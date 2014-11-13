//
//  HNPassAddNewTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import <UIKit/UIKit.h>
#import "HNPassData.h"


@interface HNPersonNewTableViewCell : UITableViewCell
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *cardNOTextField;

@property (nonatomic, strong)UIButton *iconPhoto;
@property (nonatomic, strong)UIButton *cardPhoto;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *cardLabel;
-(void)reSetPohoto;
@end
