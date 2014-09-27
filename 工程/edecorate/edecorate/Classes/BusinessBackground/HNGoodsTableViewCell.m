//
//  HNGoodsTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/27/14.
//
//

#import "HNGoodsTableViewCell.h"

@implementation HNGoodsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
