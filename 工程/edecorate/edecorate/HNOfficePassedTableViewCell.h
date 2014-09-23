//
//  HNOfficePassedTableViewCell.h
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import <UIKit/UIKit.h>
#import "HNTemporaryModel.h"

@interface HNOfficePassedTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNTemporaryModel*)model;
-(void)updateMyCell;
@end
