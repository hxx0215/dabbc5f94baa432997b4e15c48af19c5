//
//  HNEditTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-23.
//
//

#import "HNEditTableViewCell.h"

@implementation HNEditTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 18)];
        self.title.centerY = self.contentView.height / 2;
        self.title.numberOfLines = 0;
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        self.title.textAlignment = NSTextAlignmentRight;
        self.title.font = [UIFont systemFontOfSize:13];
        
        self.textView = [[UITextField alloc]init];
        self.textView.frame = CGRectMake(120, 0, self.contentView.width -120 -14, self.contentView.height-8);
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.centerY = self.contentView.height / 2;
        self.textView.font = [UIFont systemFontOfSize:13];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.title];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textView.centerY = self.contentView.height / 2;
    self.title.centerY = self.contentView.height / 2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
