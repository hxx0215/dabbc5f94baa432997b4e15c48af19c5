//
//  HNReturnsTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-28.
//
//

#import "HNReturnsTableViewCell.h"
@interface HNReturnsTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *orderid;
@property (strong, nonatomic) IBOutlet UILabel *returnid;
@property (strong, nonatomic) IBOutlet UILabel *type_txt;
@property (strong, nonatomic) IBOutlet UILabel *question;
@property (strong, nonatomic) IBOutlet UILabel *addtime;
@property (strong, nonatomic) IBOutlet UILabel *status_txt;


@end
@implementation HNReturnsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight
{
    return 150;
}
- (void)setContent:(NSDictionary *)content{
    self.orderid.text = [NSString stringWithFormat:@"%@",content[@"orderid"]];
    self.returnid.text = [NSString stringWithFormat:@"%@",content[@"returnid"]];
    self.type_txt.text = [NSString stringWithFormat:@"%@",content[@"type_txt"]];
    self.question.text = [NSString stringWithFormat:@"%@",content[@"question"]];
    self.addtime.text = [NSString stringWithFormat:@"%@",content[@"addtime"]];
    self.status_txt.text = [NSString stringWithFormat:@"%@",content[@"status_txt"]];
}
@end
