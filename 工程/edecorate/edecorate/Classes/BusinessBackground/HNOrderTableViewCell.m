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


@end
@implementation HNOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
