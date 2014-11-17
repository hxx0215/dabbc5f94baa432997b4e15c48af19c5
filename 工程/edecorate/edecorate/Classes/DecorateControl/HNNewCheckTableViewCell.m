//
//  HNNewCheckTableViewCell.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNNewCheckTableViewCell.h"
@interface HNNewCheckTableViewCell()
@property (nonatomic, strong)UILabel *hintLabel;
@end
@implementation HNNewCheckTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.name = [[UILabel alloc] init];
        self.hintLabel = [[UILabel alloc] init];
        self.name.font = [UIFont systemFontOfSize:13.0];
        self.hintLabel.font = [UIFont systemFontOfSize:11.0];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.hintLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.name sizeToFit];
    self.name.top = 5;
    self.name.left = 15;
    if ([self.type isEqualToString:@"1"]){
        self.hintLabel.text = NSLocalizedString(@"点击以输入内容", nil);
    }else{
        self.hintLabel.text = NSLocalizedString(@"点击以上传图片", nil);
    }
    [self.hintLabel sizeToFit];
    self.hintLabel.left = 15;
    self.hintLabel.top = self.name.bottom + 5;

}

//- (void)setType:(NSString *)type{
//    if ([_type isEqualToString:type])
//        return;
//    _type = type;
//    if ([self.type isEqualToString:@"1"]){
//        self.hintLabel.text = NSLocalizedString(@"点击以输入内容", nil);
//    }else{
//        self.hintLabel.text = NSLocalizedString(@"点击以上传图片", nil);
//    }
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
