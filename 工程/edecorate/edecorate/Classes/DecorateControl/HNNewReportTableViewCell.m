//
//  HNNewReportTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/11/14.
//
//

#import "HNNewReportTableViewCell.h"

@implementation HNNewReportTableViewCell
@synthesize type = _type;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.label = [[UILabel alloc] init];
        self.textField = [[UITextField alloc] init];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.button];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [self.button setTitle:NSLocalizedString(@"上传", nil) forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
//        self.button.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [self.button setBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:139.0/255.0 blue:96.0/255.0 alpha:1.0]];
//        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.button.frame = CGRectMake(0, 0, 46, 28);
        self.button.layer.cornerRadius = 6.0;
        self.button.layer.masksToBounds = YES;
        [self.button sizeToFit];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label sizeToFit];
    if (self.label.width > self.contentView.width-30)
        self.label.width = self.contentView.width - 30;
    self.label.left = 20;
    self.label.centerY = self.contentView.height / 2;
    
    self.button.right = self.contentView.width - 20;
    self.button.centerY = self.contentView.height / 2;
    
    self.textField.left = self.label.right + 5;
    self.textField.width = self.contentView.width - 20 - self.textField.left;
    self.textField.height = self.label.height;
    self.textField.centerY = self.contentView.height / 2;
}
- (void)setType:(HNNewReportTableViewCellType)type{
    self.label.hidden = NO;
    self.textField.hidden = NO;
    self.button.hidden = NO;
    self.accessoryType = UITableViewCellAccessoryNone;
    _type = type;
    switch (type) {
        case HNNewReportTableViewCellTypeDate:
        {
            self.textField.hidden = YES;
            self.button.hidden = YES;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case HNNewReportTableViewCellTypeText:
        {
            self.button.hidden = YES;
        }
            break;
        case HNNewReportTableViewCellTypeLabel:
        {
            self.button.hidden = YES;
            self.textField.hidden = YES;
        }
            break;
        case HNNewReportTableViewCellTypeButton:
        {
            self.textField.hidden = YES;
        }
            break;
      default:
        break;
}
}
@end
