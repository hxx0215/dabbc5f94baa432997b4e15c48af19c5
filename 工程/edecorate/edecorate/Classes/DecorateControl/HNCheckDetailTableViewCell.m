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
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.photo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
        [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
        [self.photo sizeToFit];
        self.photo.right = self.contentView.width - 14;
        self.photo.centerY = self.contentView.height / 2;
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.photo];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.centerY = self.contentView.height / 2;
    self.nameLabel.left = 15;
    
    self.contentLabel.left = self.nameLabel.right + 5;
    self.contentLabel.centerY = self.contentView.height / 2;
    
    self.photo.right = self.contentView.width - 14;
    self.photo.centerY = self.contentView.height / 2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
