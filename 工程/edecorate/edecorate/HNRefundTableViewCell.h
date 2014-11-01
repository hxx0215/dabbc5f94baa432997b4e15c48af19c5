//
//  HNRefundTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import <UIKit/UIKit.h>
#import "HNRefundData.h"
@interface HNRefundTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNRefundData*)model;
@end
