//
//  HNArchivesTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-14.
//
//

#import <UIKit/UIKit.h>

@interface HNArchivesTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setRoomName:(NSString *)roomname;
- (void)setStatus:(NSString *)status;
- (void)setStatusByintValue:(NSInteger)status;
@end
