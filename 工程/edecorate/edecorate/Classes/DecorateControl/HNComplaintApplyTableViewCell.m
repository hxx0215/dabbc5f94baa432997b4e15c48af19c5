//
//  HNComplaintApplyTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-9.
//
//

#import "HNComplaintApplyTableViewCell.h"

@implementation HNComplaintApplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.photo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
        [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
        [self.photo sizeToFit];
        self.photo.right = self.contentView.width - 14;
        self.photo.centerY = self.contentView.height / 2;
        self.photo.hidden = YES;
        
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
        
        self.textView2 = [[UITextView alloc]init];
        self.textView2.frame = CGRectMake(120, 0, self.contentView.width -120 -14, self.contentView.height-8);
        self.textView2.backgroundColor = [UIColor clearColor];
        self.textView2.centerY = self.contentView.height / 2;
        self.textView2.font = [UIFont systemFontOfSize:13];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.photo];
        [self.contentView addSubview:self.textView2];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.title];
        
        self.textView2.hidden = YES;
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.photo.right = self.contentView.width - 14;
    self.photo.centerY = self.contentView.height / 2;
    
    self.textView.centerY = self.contentView.height / 2;
    self.textView2.centerY = self.contentView.height / 2;
    self.title.centerY = self.contentView.height / 2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setStyle:(NSInteger)flage
{
    switch (flage) {
        case 0:
        {
            self.photo.hidden = YES;
            self.textView2.hidden = YES;
            self.textView.hidden = NO;
        }
            break;
        case 1:
        {
            self.photo.hidden = YES;
            self.textView2.hidden = NO;
            self.textView.hidden = YES;
        }
            break;
        case 2:
        {
            self.photo.hidden = NO;
            self.textView2.hidden = YES;
            self.textView.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

- (void)reset{
    self.title.textColor = [UIColor blackColor];
    //self.photo.hidden = NO;
    //    self.title.bounds = CGRectMake(0, 0, 200, 18);
    self.title.height = 18;
    self.title.centerY = self.contentView.height / 2;
}

@end
