//
//  HNCheckDetailTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNCheckDetailTableViewCell.h"

@implementation HNCheckDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.nameLabel = [[UILabel alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        self.contentLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.top = 5;
    self.nameLabel.left = 5;
    
    self.contentLabel.left = 5;
    self.contentLabel.top = self.nameLabel.bottom + 5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
