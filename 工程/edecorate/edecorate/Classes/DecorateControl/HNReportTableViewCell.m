//
//  HNReportTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNReportTableViewCell.h"
@interface HNReportTableViewCell ()
@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@end
@implementation HNReportTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
- (void)setStatus:(NSString *)status{
    self.statusLabel.text = status;
}
@end
