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
        [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
        [self.photo sizeToFit];
        self.photo.right = self.contentView.width - 14;
        self.photo.centerY = self.contentView.height / 2;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 200, 18)];;
        self.title.centerY = self.contentView.height / 2;
        
        [self.contentView addSubview:self.photo];
        [self.contentView addSubview:self.title];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.photo.right = self.contentView.width - 14;
    self.photo.centerY = self.contentView.height / 2;
    self.title.centerY = self.contentView.height / 2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
