//
//  HNConstructPaymentTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/29/14.
//
//

#import "HNConstructPaymentTableViewCell.h"
@interface HNConstructPaymentTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *totalMoney;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *number;

@end
@implementation HNConstructPaymentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContent:(NSDictionary *)content{
    self.name.text = content[@"name"];
    self.totalMoney.text = [NSString stringWithFormat:@"%@",content[@"totalMoney"]];
    self.price.text = [NSString stringWithFormat:@"%@",content[@"price"]];
    self.number.text = [NSString stringWithFormat:@"%@",content[@"number"]];
}
@end
