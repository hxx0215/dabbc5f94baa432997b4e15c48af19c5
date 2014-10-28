//
//  HNComplaintTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNComplaintTableViewCell.h"
@interface HNComplaintTableViewCell()

@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)HNComplaintData* temporaryModel;
@end

@implementation HNComplaintTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNComplaintData*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.temporaryModel = model;
        self.roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, self.bounds.size.width * 0.8, 36)];
        self.roomLabel.top = 9;
        self.roomLabel.numberOfLines = 2;
        self.roomLabel.font = [UIFont systemFontOfSize:15];
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roomLabel.frame) + 8, self.bounds.size.width * 0.8, 14)];
        self.statusLabel.left = self.roomLabel.left;
        self.statusLabel.bottom = self.contentView.height - 14;
        self.statusLabel.font = [UIFont systemFontOfSize:14];
        self.statusLabel.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.roomLabel];
        [self.contentView addSubview:self.statusLabel];
        self.roomLabel.text = model.room;
        [self setStatus];
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

- (void)layoutSubviews{
    [super layoutSubviews];
    self.statusLabel.top = self.roomLabel.bottom +3;
}


- (void)setStatus
{
    if ([self.temporaryModel.complainObject isEqualToString:@""]) {
        self.statusLabel.text = @"";
        return;
    }
    else
        self.statusLabel.text = @"正在处理";
//        case TemporaryStatusApplying:
//            self.statusLabel.text = @"正在处理";
//            break;
//        case TemporaryStatusPassed:
//            self.statusLabel.text = @"投诉成功";
//            break;
//        case TemporaryStatusNotPassed:
//            self.statusLabel.text = @"投诉驳回";
//            break;
//    }
}


- (void)awakeFromNib {
    // Initialization code
}


@end
