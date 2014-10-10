//
//  HNOfficePassedTableViewCell.m
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import "HNOfficePassedTableViewCell.h"
#import "HNPassData.h"


@interface HNOfficePassedTableViewCell()

@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)HNPassData* temporaryModel;

@end

@implementation HNOfficePassedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(HNPassData*)model
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
        self.roomLabel.text = model.roomnumber;
        //[self setStatus:model.status];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)update
{
    //[self setStatus:self.temporaryModel.status];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateMyCell
{
    //[self setStatus:self.temporaryModel.status];
}

- (void)setRoomName:(NSString *)roomname{
    self.roomLabel.text = roomname;
}

- (void)setStatus:(HNTemporaryStatus)status
{
    
    self.roomLabel.font = [UIFont systemFontOfSize:15];
    
    switch (status) {
        case TemporaryStatusApplying:
            self.statusLabel.text = @"正在审核";
            break;
        case TemporaryStatusPassed:
            self.statusLabel.text = @"审核通过";
            break;
        case TemporaryStatusNotPassed:
            self.statusLabel.text = @"审核失败";
            break;
        default:
            self.statusLabel.text = @"";
            self.roomLabel.font = [UIFont systemFontOfSize:20];
            break;
    }
}


@end
