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
        self.roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, self.bounds.size.width * 0.8, 17)];
        self.roomLabel.top = 19;
        self.roomLabel.numberOfLines = 2;
        self.roomLabel.font = [UIFont systemFontOfSize:17];
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roomLabel.frame) + 8, self.bounds.size.width * 0.8, 14)];
        self.statusLabel.left = self.roomLabel.left;
        self.statusLabel.bottom = self.contentView.height - 14;
        self.statusLabel.font = [UIFont systemFontOfSize:14];
        self.statusLabel.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        
        [self.contentView addSubview:self.roomLabel];
        [self.contentView addSubview:self.statusLabel];
        self.temporaryModel = model;
        self.roomLabel.text = model.roomnumber;
        [self setStatus];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.statusLabel.bottom = self.contentView.height - 14;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateMyCell
{
    [self setStatus];
}

- (void)setRoomName:(NSString *)roomname{
    self.roomLabel.text = roomname;
}

- (void)setStatus
{
    
    self.roomLabel.font = [UIFont systemFontOfSize:15];
    
    if ([self.temporaryModel.CARDId isEqualToString:@"0"]) {
        self.statusLabel.text = @"";
        self.roomLabel.font = [UIFont systemFontOfSize:20];
    }
    else
    {
        if ([self.temporaryModel.assessorState isEqualToString:@"1"]) {
            self.statusLabel.text = @"审核通过";
            
        }
        else
        {
            self.statusLabel.text = @"正在审核";
        }
    }
}


@end
