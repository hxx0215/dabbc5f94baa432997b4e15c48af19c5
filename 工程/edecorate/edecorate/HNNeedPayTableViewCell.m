//
//  HNNeedPayTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-24.
//
//

#import "HNNeedPayTableViewCell.h"

@implementation HNNeedPayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 200, 18)];
        self.title.font = [UIFont systemFontOfSize:18.0];
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 19)];
        self.price.font = [UIFont systemFontOfSize:19.0];
        self.price.textAlignment = NSTextAlignmentRight;
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 200, 13)];;
        self.detail.font = [UIFont systemFontOfSize:13.0];
        //self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[self.checkButton setBackgroundImage:[UIImage imageNamed:@"purchasecheckbox.png"] forState:UIControlStateNormal];
        //[self.checkButton setImage:[UIImage imageNamed:@"purchasecheck.png"] forState:UIControlStateSelected];
        //[self.checkButton sizeToFit];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.detail];
        //[self.contentView addSubview:self.checkButton];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    if (0 == self.single)
//        self.title.centerY = self.contentView.height / 2;
//    else
        self.title.top = 12;
    self.price.right = self.contentView.width - 24;
    self.price.centerY = self.title.centerY;
//    if (0 == self.single)
//    {
//        self.detail.hidden = YES;
//    }
//    else{
        self.detail.hidden = NO;
        self.detail.left = 37;
        self.detail.bottom = self.contentView.height - 12;
  //  }
//    self.checkButton.left = 14;
//    self.checkButton.top = 12;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
