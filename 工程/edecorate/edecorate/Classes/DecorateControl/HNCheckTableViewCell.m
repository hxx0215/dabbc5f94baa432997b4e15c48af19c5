//
//  HNCheckTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNCheckTableViewCell.h"

@implementation HNCheckTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.roomName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 0.8, 30)];
        self.roomName.numberOfLines = 2;
        self.roomName.font = [UIFont systemFontOfSize:15];
        self.checkStage = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roomName.frame) + 8, self.bounds.size.width * 0.8, 20)];
        self.checkStage.font = [UIFont systemFontOfSize:20];
        
        self.checkSchedule = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.checkStage.frame) +2, self.bounds.size.width * 0.8, 20)];
        self.checkSchedule.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.roomName];
        [self.contentView addSubview:self.checkStage];
        [self.contentView addSubview:self.checkSchedule];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
