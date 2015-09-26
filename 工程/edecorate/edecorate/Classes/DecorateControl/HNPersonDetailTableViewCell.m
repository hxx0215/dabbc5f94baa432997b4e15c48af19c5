//
//  HNPassPersonDetailTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-11.
//
//

#import "HNPersonDetailTableViewCell.h"

@interface HNPersonDetailTableViewCell()
@property (nonatomic, strong) HNPassProposerData *proposerData;
@end

@implementation HNPersonDetailTableViewCell


- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconPhoto = (UIButton *)[self viewWithTag:1];
    self.nameLabel = (UILabel *)[self viewWithTag:2];
    self.phoneLabel = (UILabel *)[self viewWithTag:3];
    self.cardLabel = (UILabel *)[self viewWithTag:4];
    self.cardPhoto = (UIButton *)[self viewWithTag:5];
}
- (void)layoutSubviews{
    [super layoutSubviews];

}

-(void)setData:(HNPassProposerData*)proposer
{
    self.proposerData = proposer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xd9/255.0f green:0xd9/255.0f blue:0xd9/255.0f alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(self.nameLabel.left-3, 0, 1, rect.size.height));
    CGContextStrokeRect(context, CGRectMake(self.nameLabel.left-3, self.nameLabel.bottom, self.nameLabel.width, 1));
    CGContextStrokeRect(context, CGRectMake(self.nameLabel.left-3, self.phoneLabel.bottom, self.nameLabel.width, 1));
    CGContextStrokeRect(context, CGRectMake(self.nameLabel.left-3, self.cardLabel.bottom, self.nameLabel.width, 1));
    [super drawRect:rect];
}

@end
