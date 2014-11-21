//
//  HNGoodsTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/27/14.
//
//

#import "HNGoodsTableViewCell.h"
@interface HNGoodsTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *goodsId;
@property (strong, nonatomic) IBOutlet UILabel *marketPrice;
@property (strong, nonatomic) IBOutlet UILabel *salePirce;
@property (strong, nonatomic) IBOutlet UILabel *buypeople;
@property (strong, nonatomic) IBOutlet UILabel *commentcount;
@property (strong, nonatomic) IBOutlet UIImageView *pics;

@end
@implementation HNGoodsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContet:(NSDictionary *)content{
    self.pics.height =75;
    self.pics.image = [content objectForKey:@"uiimage"];
    self.name.text = [content objectForKey:@"name"];
    self.goodsId.text = [content objectForKey:@"id"];
    self.marketPrice.text = [NSString stringWithFormat:@"%@",[content objectForKey:@"MarketPrice"]];
    self.salePirce.text = [NSString stringWithFormat:@"%@",[content objectForKey:@"salePirce"]];
    self.buypeople.text = [NSString stringWithFormat:@"%@",[content objectForKey:@"buypeople"]];
    self.commentcount.text = [NSString stringWithFormat:@"%@",[content objectForKey:@"commentcount"]];
    [self.name sizeToFit];
}
@end
