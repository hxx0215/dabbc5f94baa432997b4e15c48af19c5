//
//  HNOrderDetailTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/25/14.
//
//

#import "HNOrderDetailTableViewCell.h"
#import "HNImageData.h"

@interface HNOrderDetailTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *actualprice;
@property (strong, nonatomic) IBOutlet UILabel *goodsNum;

@end
@implementation HNOrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContent:(NSDictionary *)content{
//    self.img.image = [UIImage imageNamed:@"selectphoto.png"];
//    self.img.height = 84;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *image = [[HNImageData shared] imageWithLink:content[@"imgurl"]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.img.image = image;
//        });
//    });
    self.img.image = content[@"uiimage"];
    self.img.height = 84;
    self.title.text = content[@"title"];
    self.actualprice.text = [NSString stringWithFormat:@"%@",content[@"actualprice"]];
    self.goodsNum.text = [NSString stringWithFormat:@"%@",content[@"goodsNum"]];
}
@end
