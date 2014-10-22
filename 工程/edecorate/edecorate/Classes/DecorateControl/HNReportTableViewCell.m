//
//  HNReportTableViewCell.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//
//self.statusMap = @{@"0": @"审核进度:未提交",@"1": @"审核进度:已审核",@"-1":@"审核进度:审核未通过"};
#import "HNReportTableViewCell.h"
@interface HNReportTableViewCell ()
@property (nonatomic, strong)UILabel *roomLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)UIImageView *statusImage;
@end
@implementation HNReportTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
        
        self.statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.statusImage.left = 12;
        self.statusImage.top = 23;
        [self.contentView addSubview:self.roomLabel];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.statusImage];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.statusLabel.bottom = self.contentView.height - 14;
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
    if ([status isEqualToString:@"审核进度:未提交"]){
        self.statusImage.image = [UIImage imageNamed:@"unsubmit.png"];
    }
    else if ([status isEqualToString:@"审核进度:已审核"]){
        self.statusImage.image = [UIImage imageNamed:@"accept.png"];
    }
    else
        self.statusImage.image = [UIImage new];
}
@end
