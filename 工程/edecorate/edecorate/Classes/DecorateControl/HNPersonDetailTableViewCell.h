//
//  HNPassPersonDetailTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-11.
//
//

#import <UIKit/UIKit.h>
#import "HNPassData.h"

@interface HNPersonDetailTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton *iconPhoto;
@property (nonatomic, strong)UIButton *cardPhoto;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *cardLabel;
@end
