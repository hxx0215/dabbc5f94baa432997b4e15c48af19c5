//
//  HNTemporaryTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import <UIKit/UIKit.h>
#include "HNTemporaryModel.h"

@interface HNTemporaryTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setRoomName:(NSString *)roomname;
- (void)setStatus:(HNTemporaryStatus)status;
@end
