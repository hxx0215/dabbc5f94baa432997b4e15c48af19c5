//
//  HNImageUploadTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-10.
//
//

#import "HNImageUploadTableViewCell.h"

@implementation HNImageUploadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.photo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
        [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
        [self.photo sizeToFit];
        self.photo.right = self.contentView.width - 14;
        self.photo.centerY = self.contentView.height / 2;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 18)];;
        self.title.centerY = self.contentView.height / 2;
        self.title.textAlignment = NSTextAlignmentRight;
        self.title.font = [UIFont systemFontOfSize:13];
        self.title.numberOfLines = 0;
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)reset{
    self.title.textColor = [UIColor blackColor];
    self.photo.hidden = NO;
    //    self.title.bounds = CGRectMake(0, 0, 200, 18);
    self.title.height = 18;
    self.title.centerY = self.contentView.height / 2;
    [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
    [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
}

@end
