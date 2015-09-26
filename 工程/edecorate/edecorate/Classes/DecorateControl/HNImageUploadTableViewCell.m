//
//  HNImageUploadTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-10.
//
//

#import "HNImageUploadTableViewCell.h"

@implementation HNImageUploadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.photo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
        [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
        [self.photo sizeToFit];
        self.photo.right = self.contentView.width - 14;
        self.photo.centerY = self.contentView.height / 2;
        
        self.leftPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftPhoto.right = self.photo.left;
        self.leftPhoto.centerY = self.contentView.height / 2;
        self.rightPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightPhoto.left = self.photo.right;
        self.rightPhoto.centerY = self.contentView.height / 2;
        self.leftPhoto.backgroundColor = [UIColor redColor];
        self.rightPhoto.backgroundColor = [UIColor redColor];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 18)];;
        self.title.centerY = self.contentView.height / 2;
        self.title.textAlignment = NSTextAlignmentRight;
        self.title.font = [UIFont systemFontOfSize:13];
        self.title.numberOfLines = 0;
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.addPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deletePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.photo];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.leftPhoto];
        [self.contentView addSubview:self.rightPhoto];
        [self.contentView addSubview:self.addPhoto];
        [self.contentView addSubview:self.deletePhoto];
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
    self.title.centerY = self.contentView.height / 2;
    
    self.leftPhoto.right = self.photo.left;
    self.leftPhoto.centerY = self.contentView.height / 2;
    self.rightPhoto.left = self.photo.right;
    self.rightPhoto.centerY = self.contentView.height / 2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)reset:(NSString*)imageString{
    self.title.textColor = [UIColor blackColor];
    self.photo.hidden = NO;
    //    self.title.bounds = CGRectMake(0, 0, 200, 18);
    self.title.height = 18;
    self.title.centerY = self.contentView.height / 2;
//    [self.photo setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
//    [self.photo setImage:[UIImage imageNamed:@"selectphotoclick.png"] forState:UIControlStateHighlighted];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadImage:) object:imageString];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];
}

- (void)downloadImage:(NSString*)imageString
{
    UIImage *image = [[HNImageData shared]imageWithLink:imageString];
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}


-(void)updateUI:(UIImage*) image{

    [self.photo setImage:image forState:UIControlStateNormal];
    [self.photo setImage:image forState:UIControlStateHighlighted];
}

@end
