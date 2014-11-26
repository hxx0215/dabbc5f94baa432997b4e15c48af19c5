//
//  HNReturnDetailTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/26/14.
//
//

#import "HNReturnDetailTableViewCell.h"
@interface HNReturnDetailTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *ordertime;
@property (strong, nonatomic) IBOutlet UILabel *goodsid;
@property (strong, nonatomic) IBOutlet UILabel *totalprice;
@property (strong, nonatomic) IBOutlet UILabel *attrs;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UIImageView *pics;

@end
@implementation HNReturnDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContent:(NSDictionary *)content{
    self.ordertime.text = content[@"ordertime"];
    self.goodsid.text = content[@"goodsid"];
    self.totalprice.text = [NSString stringWithFormat:@"%@",content[@"totalprice"]];
    self.attrs.text = content[@"attrs"];
    self.number.text = content[@"number"];
    self.pics.image = content[@"uiimage"];
}
@end
