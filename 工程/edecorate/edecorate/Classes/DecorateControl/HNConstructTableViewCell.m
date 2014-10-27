//
//  HNConstructTableViewCell.m
//  edecorate
//
//  Created by hxx on 10/27/14.
//
//

#import "HNConstructTableViewCell.h"

@implementation HNConstructTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.photo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
    }
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
