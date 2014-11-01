//
//  HNRefundTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import "HNRefundTableViewCell.h"

@interface HNRefundTableViewCell()

@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)HNRefundData* temporaryModel;
@end

@implementation HNRefundTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNRefundData*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 0.8, 30)];
        self.roomLabel.numberOfLines = 2;
        self.roomLabel.font = [UIFont systemFontOfSize:15];
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roomLabel.frame) + 8, self.bounds.size.width * 0.8, 35)];
        self.statusLabel.font = [UIFont systemFontOfSize:28];
        [self.contentView addSubview:self.roomLabel];
        [self.contentView addSubview:self.statusLabel];
//        self.temporaryModel = model;
//        self.roomLabel.text = model.roomName;
//        [self setStatus:model.status];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void)setRoomName:(NSString *)roomname{
    self.roomLabel.text = roomname;
}

- (void)setStatus
{
    
//    switch (status) {
//        case TemporaryStatusApplying:
//            self.statusLabel.text = @"正在处理";
//            break;
//        case TemporaryStatusPassed:
//            self.statusLabel.text = @"退款成功";
//            break;
//        case TemporaryStatusNotPassed:
//            self.statusLabel.text = @"退款失败";
//            break;
//        default:
//            self.statusLabel.text = @"";
//            self.roomLabel.font = [UIFont systemFontOfSize:20];
//            break;
//    }
}

@end
