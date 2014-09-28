//
//  HNOrderTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/28/14.
//
//

#import "HNOrderTableViewCell.h"

@implementation HNOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
