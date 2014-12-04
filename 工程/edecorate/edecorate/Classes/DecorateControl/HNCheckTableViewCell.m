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
        self.roomName = [[UILabel alloc] initWithFrame:CGRectMake(27, 8.5, self.bounds.size.width * 0.8, 30)];
        self.roomName.numberOfLines = 2;
        self.roomName.font = [UIFont systemFontOfSize:15];
        self.checkStage = [[UILabel alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(self.roomName.frame)+2 , 40, 20)];
        self.checkStage.font = [UIFont systemFontOfSize:14];
        
        self.checkSchedule = [[UILabel alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(self.checkStage.frame) , 40, 20)];
        self.checkSchedule.font = [UIFont systemFontOfSize:14];
        self.checkStage.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        self.checkSchedule.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.roomName];
        [self.contentView addSubview:self.checkStage];
        [self.contentView addSubview:self.checkSchedule];
        self.checkStage.left = self.checkSchedule.right + 5;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
