//
//  HNComplaintTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import <UIKit/UIKit.h>
#include "HNTemporaryModel.h"

@interface HNComplaintTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNTemporaryModel*)model;
-(void)updateMyCell;
@end
