//
//  HNNewCheckTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNNewCheckTableViewCell.h"
@interface HNNewCheckTableViewCell()<UITextFieldDelegate>

@end
@implementation HNNewCheckTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.name = [[UILabel alloc] init];
        self.name.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:self.name];
        
        self.textField = [[UITextField alloc] init];
        [self.contentView addSubview:self.textField];
        self.textField.hidden = YES;
        self.textField.delegate = self;
        
        self.upload = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.upload setTitle:NSLocalizedString(@"上传", nil) forState:UIControlStateNormal];
        [self.contentView addSubview:self.upload];
        [self.upload setBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:139.0/255.0 blue:96.0/255.0 alpha:1.0]];
        [self.upload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.upload.titleLabel.font = [UIFont systemFontOfSize:13.0];
        self.upload.hidden = YES;
        self.upload.layer.cornerRadius = 7.0;
        [self.upload sizeToFit];
        
        self.del = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.del setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
        [self.contentView addSubview:self.del];
        [self.del setBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:139.0/255.0 blue:96.0/255.0 alpha:1.0]];
        [self.del setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.del.titleLabel.font = [UIFont systemFontOfSize:13.0];
        self.del.hidden = YES;
        self.del.layer.cornerRadius = 7.0;
        [self.del sizeToFit];
        
        self.curImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        [self.contentView addSubview:self.curImageView];
        self.curImageView.hidden = YES;
        
        self.leftImg = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftImg setImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal];
        [self.leftImg sizeToFit];
        [self.contentView addSubview:self.leftImg];
        self.leftImg.hidden = YES;
        
        self.rightImg = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightImg setImage:[UIImage imageNamed:@"you.png"] forState:UIControlStateNormal];
        [self.rightImg sizeToFit];
        [self.contentView addSubview:self.rightImg];
        self.rightImg.hidden = YES;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.name sizeToFit];

    self.name.left = 15;
    self.name.centerY = 22;

    if ([self.type isEqualToString:@"1"]){
        self.upload.hidden = YES;
        self.textField.hidden = NO;
        self.textField.height = self.contentView.height;
        self.textField.left = self.name.right + 5;
        self.textField.width = self.contentView.width - 10 -self.name.right - 5;
        self.textField.top = 0;
    }
    else{
        self.textField.hidden = YES;
        self.upload.hidden = NO;
        self.upload.right = self.contentView.width - 20;
        self.upload.centerY = 22;
        self.del.right = self.upload.left - 10;
        self.del.centerY = 22;
        self.curImageView.centerX = self.contentView.width / 2;
        self.curImageView.top = 44;
        self.leftImg.left = 15;
        self.leftImg.centerY = self.curImageView.centerY;
        self.rightImg.right = self.contentView.width - 20;
        self.rightImg.centerY = self.leftImg.centerY;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
