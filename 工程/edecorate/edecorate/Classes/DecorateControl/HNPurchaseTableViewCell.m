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

@end
@implementation HNPurchaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, 200, 18)];
        self.title.font = [UIFont systemFontOfSize:18.0];
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 19)];
        self.price.font = [UIFont systemFontOfSize:19.0];
        self.price.textAlignment = NSTextAlignmentRight;
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, 200, 13)];;
        self.detail.font = [UIFont systemFontOfSize:13.0];
        self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"purchasecheckbox.png"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"purchasecheck.png"] forState:UIControlStateSelected];
        [self.checkButton sizeToFit];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.detail];
        [self.contentView addSubview:self.checkButton];
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
    self.price.right = self.contentView.width - 14;
    self.price.centerY = self.title.centerY;
    if (0 == self.single)
    {
        self.detail.hidden = YES;
    }
    else{
        self.detail.hidden = NO;
        self.detail.left = 27;
        self.detail.bottom = self.contentView.height - 12;
    }
    self.checkButton.left = 4;
    self.checkButton.top = 12;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
