//
//  HNTemporaryTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import "HNTemporaryTableViewCell.h"

@interface HNTemporaryTableViewCell ()
@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
@end
@implementation HNTemporaryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNTemporaryModel*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        self.roomLabel = [[UILabel alloc] init];
        self.roomLabel.numberOfLines = 2;
        self.roomLabel.font = [UIFont systemFontOfSize:15];
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, /*CGRectGetMaxY(self.roomLabel.frame)*/30 + 8, self.bounds.size.width * 0.8, 30)];
        self.statusLabel.font = [UIFont systemFontOfSize:28];
        [self.contentView addSubview:self.roomLabel];
        [self.contentView addSubview:self.statusLabel];
        self.temporaryModel = model;
        self.roomLabel.text = model.roomName;
        [self setStatus:model.status];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)updateMyCell
{
    [self setStatus:self.temporaryModel.status];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setRoomName:(NSString *)roomname{
    self.roomLabel.text = roomname;
}
- (void)setStatus:(HNTemporaryStatus)status
{
    self.roomLabel.font = [UIFont systemFontOfSize:15];
    switch (status) {
        case TemporaryStatusApplying:
            self.statusLabel.text = @"审核进度:审核中";
            break;
        case TemporaryStatusPassed:
            self.statusLabel.text = @"审核进度:已通过";
            break;
        case TemporaryStatusNotPassed:
            self.statusLabel.text = @"审核进度:未通过";
            break;
        default:
            self.statusLabel.text = @"";
            break;
    }
    CGFloat pos = 0;
    if (status == TemporaryStatusCustom) {
        pos = 20;
    }
    self.roomLabel.frame = CGRectMake(0, pos, self.bounds.size.width * 0.8, 35);
}
@end

