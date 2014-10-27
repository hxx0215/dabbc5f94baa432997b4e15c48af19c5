//
//  HNPassAddNewTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import "HNPassAddNewTableViewCell.h"

@implementation HNPassAddNewTableViewCell

-(id)init
{
    self = [super init];
    self.uploadButton.backgroundColor = [UIColor colorWithRed:45/255.0 green:179/255.0 blue:123/255.0 alpha:1];
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
