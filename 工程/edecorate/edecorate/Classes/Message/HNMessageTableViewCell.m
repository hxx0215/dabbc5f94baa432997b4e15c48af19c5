//
//  HNMessageTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-6.
//
//

#import "HNMessageTableViewCell.h"

@implementation HNMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labelTitle = (UILabel *)[self viewWithTag:1];
    self.labelMessage = (UILabel *)[self viewWithTag:2];
    self.labelDate = (UILabel *)[self viewWithTag:3];
    self.imageViewRead = (UIImageView *)[self viewWithTag:4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
