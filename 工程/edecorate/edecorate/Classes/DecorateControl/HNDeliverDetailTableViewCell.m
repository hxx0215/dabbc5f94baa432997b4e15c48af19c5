//
//  HNDeliverDetailTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import "HNDeliverDetailTableViewCell.h"

@interface HNDeliverDetailTableViewCell()
@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic,strong) IBOutlet UILabel *cardLabel;
@property (nonatomic,strong) IBOutlet UILabel *cardIconLabel;
@property (nonatomic,strong) IBOutlet UILabel *headIconLabel;
@end

@implementation HNDeliverDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(HNDeliverProposerItem*)deliverProposerItem
{
    self.nameLabel = (UILabel*)[self viewWithTag:2];
    self.phoneLabel = (UILabel*)[self viewWithTag:3];
    self.cardLabel = (UILabel*)[self viewWithTag:4];
    self.cardIconLabel = (UILabel*)[self viewWithTag:5];
    self.headIconLabel = (UILabel*)[self viewWithTag:6];
    
    self.nameLabel.text = deliverProposerItem.name;
    self.phoneLabel.text = deliverProposerItem.phone;
    self.cardLabel.text = deliverProposerItem.IDcard;
    self.cardIconLabel.text = deliverProposerItem.IDcardImg;
    self.headIconLabel.text = deliverProposerItem.Icon;
}

@end
