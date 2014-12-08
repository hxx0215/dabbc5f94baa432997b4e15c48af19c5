//
//  HNPassAddNewTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import "HNPersonNewTableViewCell.h"

@interface HNPersonNewTableViewCell()<UITextFieldDelegate>
@property (strong, nonatomic) UIButton *cardTitleButton;
@end

@implementation HNPersonNewTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.nameTextField = [[UITextField alloc]init];
    self.phoneTextField = [[UITextField alloc]init];
    self.cardNOTextField = [[UITextField alloc]init];
    
    self.cardPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cardPhoto setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
    [self.cardPhoto setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
    [self.cardPhoto sizeToFit];
    
    self.cardTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cardTitleButton setImage:[UIImage imageNamed:@"08.png"] forState:UIControlStateNormal];
    [self.cardTitleButton sizeToFit];
    
    self.iconPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.iconPhoto setImage:[UIImage imageNamed:@"添加照片_18"] forState:UIControlStateNormal];
    [self.iconPhoto sizeToFit];
    
    self.nameLabel = [[UILabel alloc]init];
    self.phoneLabel = [[UILabel alloc]init];
    self.cardLabel = [[UILabel alloc]init];
    CGFloat labelWidth = 70;
    CGFloat labelHeight = 30;
    self.iconPhoto.frame = CGRectMake(14, 15, 60, 60);
    self.cardTitleButton.frame = CGRectMake(15, 95, 60, 50);
    
    
    CGFloat fColor = 200/255.0;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(75, 1, 1, 144)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:fColor alpha:1];
    [self.contentView bringSubviewToFront:view];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(75, 5+labelHeight, self.bounds.size.width-75-12, 1)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:fColor alpha:1];
    [self.contentView bringSubviewToFront:view];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(75, 35+labelHeight, self.bounds.size.width-75-12, 1)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:fColor alpha:1];
    [self.contentView bringSubviewToFront:view];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(12, 65+labelHeight, self.bounds.size.width-12-12, 1)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:fColor alpha:1];
    [self.contentView bringSubviewToFront:view];
    
    self.nameLabel.frame = CGRectMake(75, 5, labelWidth, labelHeight);
    self.phoneLabel.frame = CGRectMake(75, 35, labelWidth, labelHeight);
    self.cardLabel.frame = CGRectMake(75, 65, labelWidth, labelHeight);
    
    self.nameTextField.frame = CGRectMake(145, 5, self.bounds.size.width-135-12, 30);
    self.phoneTextField.frame = CGRectMake(145, 35, self.bounds.size.width-135-12, 30);
    self.cardNOTextField.frame = CGRectMake(145, 65, self.bounds.size.width-135-12, 30);
    
    self.nameLabel.text = @"姓名：";
    self.phoneLabel.text = @"联系电话：";
    self.cardLabel.text = @"身份证号：";
    self.nameTextField.placeholder = @"点击在此输入姓名";
    self.phoneTextField.placeholder = @"点击在此输入联系电话";
    self.cardNOTextField.placeholder = @"点击在此输入身份证号";
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.phoneLabel.font = [UIFont systemFontOfSize:13];
    self.cardLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    self.cardLabel.textAlignment = NSTextAlignmentRight;
    self.nameTextField.font = [UIFont systemFontOfSize:13];
    self.phoneTextField.font = [UIFont systemFontOfSize:13];
    self.cardNOTextField.font = [UIFont systemFontOfSize:13];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.nameTextField];
    [self.contentView addSubview:self.phoneTextField];
    [self.contentView addSubview:self.cardNOTextField];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.cardLabel];
    [self.contentView addSubview:self.cardTitleButton];
    [self.contentView addSubview:self.iconPhoto];
    [self.contentView addSubview:self.cardPhoto];
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cardPhoto.centerY = (95+95+50)/2;
    self.cardPhoto.centerX = (75+self.bounds.size.width-75-12+75)/2;
    //self.cardPhoto.frame = CGRectMake(75, 95, self.bounds.size.width-75-12, 50);
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

-(void)reSetPohoto
{
    [self.iconPhoto setImage:[UIImage imageNamed:@"添加照片_18"] forState:UIControlStateNormal];
    [self.cardPhoto setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
    [self.cardPhoto setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
