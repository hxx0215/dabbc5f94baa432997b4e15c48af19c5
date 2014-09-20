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
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
@end

@implementation HNComplaintTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNTemporaryModel*)model
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
        self.temporaryModel = model;
        self.roomLabel.text = model.roomName;
        [self setStatus:model.status];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)update
{
    [self setStatus:self.temporaryModel.status];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)updateMyCell
{
    [self setStatus:self.temporaryModel.status];
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
            self.roomLabel.font = [UIFont systemFontOfSize:20];
            break;
    }
}


- (void)awakeFromNib {
    // Initialization code
}


@end
