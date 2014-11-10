//
//  HNImageUploadTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-10.
//
//

#import <UIKit/UIKit.h>
#import "HNUploadImage.h"

@interface HNImageUploadTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton *photo;
@property (nonatomic, strong)UILabel *title;
- (void)reset;
@end
