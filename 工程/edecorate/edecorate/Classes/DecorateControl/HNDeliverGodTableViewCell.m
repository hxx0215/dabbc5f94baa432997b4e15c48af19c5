//
//  HNDeliverGodTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-13.
//
//

#import "HNDeliverGodTableViewCell.h"

@implementation HNDeliverGodTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.nameTextField = [[UITextField alloc]init];
    self.bTimeTextField = [[UITextField alloc]init];
    self.endTimeTextField = [[UITextField alloc]init];
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.bTimeLabel = [[UILabel alloc]init];
    self.endTimeLabel = [[UILabel alloc]init];
    CGFloat labelWidth = 100;
    CGFloat labelHeight = 30;
    
    self.nameLabel.frame = CGRectMake(15, 5, labelWidth, labelHeight);
    self.bTimeLabel.frame = CGRectMake(15, 35, labelWidth, labelHeight);
    self.endTimeLabel.frame = CGRectMake(15, 65, labelWidth, labelHeight);
    
    self.nameTextField.frame = CGRectMake(labelWidth+20, 5, self.bounds.size.width-(labelWidth+20)-12, 30);
    self.bTimeTextField.frame = CGRectMake(labelWidth+20, 35, self.bounds.size.width-(labelWidth+20)-12, 30);
    self.endTimeTextField.frame = CGRectMake(labelWidth+20, 65, self.bounds.size.width-(labelWidth+20)-12, 30);
    
    self.nameLabel.text = NSLocalizedString(@"送货安装产品：", nil);
    self.bTimeLabel.text = NSLocalizedString(@"Start Time", nil);
    self.endTimeLabel.text = NSLocalizedString(@"End Time", nil);
    self.nameTextField.placeholder = @"点击在此输入货物名称";
    self.bTimeTextField.placeholder = @"点击在此输入开始时间";
    self.endTimeTextField.placeholder = @"点击在此输入结束时间";
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.bTimeLabel.font = [UIFont systemFontOfSize:13];
    self.endTimeLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.bTimeLabel.textAlignment = NSTextAlignmentRight;
    self.endTimeLabel.textAlignment = NSTextAlignmentRight;
    self.nameTextField.font = [UIFont systemFontOfSize:13];
    self.bTimeTextField.font = [UIFont systemFontOfSize:13];
    self.endTimeTextField.font = [UIFont systemFontOfSize:13];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.nameTextField];
    [self.contentView addSubview:self.bTimeTextField];
    [self.contentView addSubview:self.endTimeTextField];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.bTimeLabel];
    [self.contentView addSubview:self.endTimeLabel];
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //    self.iconPhoto.frame = CGRectMake(15, 5, 60, 60);
    //    self.cardTitleButton.frame = CGRectMake(15, 95, 60, 50);
    //    self.cardPhoto.frame = CGRectMake(75, 95, self.bounds.size.width-75-12, 50);
    //
    //    self.nameLabel.frame = CGRectMake(75, 5, 60, 30);
    //    self.phoneLabel.frame = CGRectMake(75, 35, 60, 30);
    //    self.cardLabel.frame = CGRectMake(75, 65, 60, 30);
    //
    //    self.nameTextField.frame = CGRectMake(135, 5, self.bounds.size.width-135-12, 30);
    //    self.phoneTextField.frame = CGRectMake(135, 35, self.bounds.size.width-135-12, 30);
    //    self.cardNOTextField.frame = CGRectMake(135, 65, self.bounds.size.width-135-12, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
