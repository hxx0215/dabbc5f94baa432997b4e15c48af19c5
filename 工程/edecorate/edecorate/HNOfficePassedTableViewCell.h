//
//  HNOfficePassedTableViewCell.h
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import <UIKit/UIKit.h>
#import "HNPassData.h"
#import "HNTemporaryModel.h"

@interface HNOfficePassedTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setRoomName:(NSString *)roomname;
- (void)setStatus:(NSString *)status;
@end
