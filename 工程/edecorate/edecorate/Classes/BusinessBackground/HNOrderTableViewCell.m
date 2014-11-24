//
//  HNOrderTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/28/14.
//
//

#import "HNOrderTableViewCell.h"
@interface HNOrderTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *orderid;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *orderstime;
@property (strong, nonatomic) IBOutlet UILabel *statusid;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *shopprice;
@property (strong, nonatomic) IBOutlet UILabel *actualprice;


@end
@implementation HNOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContent:(NSDictionary *)content{
    self.pic.image = [content objectForKey:@"uiimage"];
    self.orderid.text = [NSString stringWithFormat:@"%@",content[@"orderid"]];
    [self.orderid sizeToFit];
    self.orderstime.text = [NSString stringWithFormat:@"%@",content[@"orderstime"]];
    [self.orderstime sizeToFit];
    self.orderstime.right = self.contentView.width - 5;
    self.statusid.text = [NSString stringWithFormat:@"%@",content[@"statusid"]];
    self.username.text = content[@"username"];
    [self.username sizeToFit];
    if ([content[@"OrderGoods"] count]>0){
        id obj =content[@"OrderGoods"][0];
        self.shopprice.text = [NSString stringWithFormat:@"%@",obj[@"shopprice"]];
        [self.shopprice sizeToFit];
        self.actualprice.text = [NSString stringWithFormat:@"%@",obj[@"actualprice"]];
        [self.actualprice sizeToFit];
        self.title.text = [NSString stringWithFormat:@"%@",obj[@"title"]];
        [self.title sizeToFit];
    }
}
@end
