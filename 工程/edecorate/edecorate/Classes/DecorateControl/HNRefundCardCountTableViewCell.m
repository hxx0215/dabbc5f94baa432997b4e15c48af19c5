//
//  HNRefundCardCountTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-10.
//
//

#import "HNRefundCardCountTableViewCell.h"

@interface HNRefundCardCountTableViewCell()
@property (nonatomic, strong)UILabel *uintLabel;
@end

@implementation HNRefundCardCountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.card = [[UITextField alloc]init];
        self.card.frame = CGRectMake(self.contentView.width-84, 5, 50, 30);
        self.card.right = self.contentView.width - 34;
        self.card.centerY = self.contentView.height / 2;
        self.card.borderStyle = UITextBorderStyleRoundedRect;
        self.card.layer.borderColor = [UIColor blackColor].CGColor;
        self.card.keyboardType = UIKeyboardTypeNumberPad;
        
        self.uintLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.width-30, 0, 20, 18)];
        self.uintLabel.text = @"张";
        [self.uintLabel sizeToFit];
        self.uintLabel.right = self.contentView.width - 14;
        self.uintLabel.centerY = self.contentView.height / 2;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 18)];
        self.title.centerY = self.contentView.height / 2;
        self.title.numberOfLines = 0;
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.card];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.uintLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.card.right = self.contentView.width - 34;
    self.card.centerY = self.contentView.height / 2;
    self.uintLabel.right = self.contentView.width - 14;
    self.uintLabel.centerY = self.contentView.height / 2;
    self.title.centerY = self.contentView.height / 2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
