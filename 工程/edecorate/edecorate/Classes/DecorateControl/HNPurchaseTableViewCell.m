//
//  HNPurchaseTableViewCell.m
//  edecorate
//
//  Created by hxx on 10/24/14.
//
//

#import "HNPurchaseTableViewCell.h"
#import "HNPurchaseItem.h"

@interface HNPurchaseTableViewCell()
@property (nonatomic, strong)UIButton *plusButton;
@property (nonatomic, strong)UIButton *mineButton;
@end
@implementation HNPurchaseTableViewCell
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
        self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"purchasecheckbox.png"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"purchasecheck.png"] forState:UIControlStateSelected];
        [self.checkButton sizeToFit];
        self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.plusButton setImage:[UIImage imageNamed:@"btn_inc.png"] forState:UIControlStateNormal];
        self.mineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mineButton setImage:[UIImage imageNamed:@"btn_dec.png"] forState:UIControlStateNormal];
        [self.plusButton sizeToFit];
        [self.mineButton sizeToFit];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.detail];
        [self.contentView addSubview:self.checkButton];
        [self.contentView addSubview:self.plusButton];
        [self.contentView addSubview:self.mineButton];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (0 == self.single)
        self.title.centerY = self.contentView.height / 2;
    else
        self.title.top = 12;
    self.price.right = self.contentView.width - 24;
    self.price.centerY = self.title.centerY;
    if (0 == self.single)
    {
        self.detail.hidden = YES;
    }
    else{
        self.detail.hidden = NO;
        self.detail.left = 37;
        self.detail.bottom = self.contentView.height - 12;
    }
    self.checkButton.left = 14;
    self.checkButton.top = 12;
    self.plusButton.top = self.price.bottom+2;
    self.mineButton.top = self.plusButton.top;
    self.mineButton.right = self.contentView.width - 24;
    self.plusButton.right = self.mineButton.left;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
