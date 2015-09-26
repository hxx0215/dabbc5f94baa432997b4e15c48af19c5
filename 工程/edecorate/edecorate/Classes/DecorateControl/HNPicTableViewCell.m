//
//  HNPicTableViewCell.m
//  edecorate
//
//  Created by hxx on 12/2/14.
//
//

#import "HNPicTableViewCell.h"
#import "MBProgressHUD.h"
#import "HNUploadImage.h"
#import "HNImageData.h"
#import "HNBrowseImageViewController.h"

@interface HNPicTableViewCell()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong)UIImagePickerController *imagePicker;
@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic)NSInteger currentImage;
@property (nonatomic) BOOL showPic;
@end

@implementation HNPicTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 18)];
        self.name.centerY = self.contentView.height / 2;
        self.name.numberOfLines = 0;
        self.name.lineBreakMode = NSLineBreakByWordWrapping;
        self.name.textAlignment = NSTextAlignmentRight;
        self.name.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.name];
        
        self.upload = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.upload setTitle:NSLocalizedString(@"上传", nil) forState:UIControlStateNormal];
        [self.contentView addSubview:self.upload];
        [self.upload setBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:139.0/255.0 blue:96.0/255.0 alpha:1.0]];
        [self.upload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.upload.titleLabel.font = [UIFont systemFontOfSize:13.0];
        //self.upload.hidden = YES;
        self.upload.layer.cornerRadius = 7.0;
        [self.upload sizeToFit];
        [self.upload addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        
        self.del = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.del setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
        [self.contentView addSubview:self.del];
        [self.del setBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:139.0/255.0 blue:96.0/255.0 alpha:1.0]];
        [self.del setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.del.titleLabel.font = [UIFont systemFontOfSize:13.0];
        self.del.hidden = YES;
        self.del.layer.cornerRadius = 7.0;
        [self.del sizeToFit];
        [self.del addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
        
        self.curImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.curImage.frame =  CGRectMake(0, 0, 50 , 50);
        [self.contentView addSubview:self.curImage];
        self.curImage.hidden = YES;
        [self.curImage addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
        
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
        [self.leftImg addTarget:self action:@selector(moveImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightImg addTarget:self action:@selector(moveImage:) forControlEvents:UIControlEventTouchUpInside];
        
//        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//        }
//        self.imagePicker = [[UIImagePickerController alloc] init];
//        self.imagePicker.delegate =self;
//        self.imagePicker.sourceType = sourceType;
//        self.imagePicker.allowsEditing = NO;
        
        self.imageArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //[self.name sizeToFit];
    
    //self.name.left = 15;
    //self.name.centerY = 22;
    
    //self.upload.hidden = NO;
    self.upload.right = self.contentView.width - 20;
    self.upload.centerY = 22;
    self.del.right = self.upload.left - 10;
    self.del.centerY = 22;
    self.curImage.centerX = self.contentView.width / 2;
    self.curImage.top = 44;
    self.leftImg.left = 15;
    self.leftImg.centerY = self.curImage.centerY;
    self.rightImg.right = self.contentView.width - 20;
    self.rightImg.centerY = self.leftImg.centerY;
}


- (IBAction)upload:(id)sender{
    
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:((UIViewController*)self.delegate).view];
    
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = sourceType;
        [(UIViewController*)self.delegate presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:((UIViewController*)self.delegate).view animated:YES];
    hud.labelText = NSLocalizedString(@"正在上传", nil);
    [HNUploadImage UploadImage:image block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:((UIViewController*)self.delegate).view animated:YES];
        if (msg) {
            [self.imageArray addObject:msg];
            NSString *str=nil;
            for (int i = 0 ;i<[self.imageArray count] ; i++) {
                NSString *ss = [self.imageArray objectAtIndex:i];
                if (i==0) {
                    str = ss;
                }
                else
                {
                    str = [NSString stringWithFormat:@"%@,%@",str,ss];
                }
            }
            NSLog(@"%@",str);
            BOOL bo = (self.currentImage == 0);
            self.currentImage = [self.imageArray count]-1;
            [self retImages];
            [self.delegate updataImage:str heightChange:bo];
        }
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImages:(NSString*)images
{
    self.currentImage = 0;
    [self.imageArray removeAllObjects];
    NSArray *array = [images componentsSeparatedByString:@","];
    for (NSString* str in array) {
        if (str.length>1) {
            [self.imageArray addObject:str];
        }
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSString *str in self.imageArray) {
            [[HNImageData shared] imageWithLink:str];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self retImages];
            });
        }
        
    });
}

-(void)retImages
{
    if(self.showPic)
    {
        self.upload.hidden = YES;
    }
    else
    {
        self.upload.hidden = NO;
    }
    if ([self.imageArray count]==0) {
        self.rightImg.hidden = YES;
        self.leftImg.hidden = YES;
        self.del.hidden = YES;
        self.curImage.hidden = YES;
        return;
    }
    else
    {
        self.curImage.hidden = NO;
        if (!self.showPic) {
            self.del.hidden = NO;
        }
    }
    
    if ([self.imageArray count]>self.currentImage+1) {
        self.rightImg.hidden = NO;
    }
    else
        self.rightImg.hidden = YES;
    
    if (self.currentImage>0) {
        self.leftImg.hidden = NO;
    }
    else
        self.leftImg.hidden = YES;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger tagi = self.currentImage;
        UIImage *image = [[HNImageData shared] imageWithLink:[self.imageArray objectAtIndex:self.currentImage]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (tagi == self.currentImage) {
                [self.curImage setImage:image forState:UIControlStateNormal];
                [self.curImage setImage:image forState:UIControlStateHighlighted];
            }
            
        });
        
    });

}

-(void)moveImage:(UIButton*)sender
{
    if ([sender isEqual:self.leftImg]) {
        self.currentImage--;
    }
    else{
        self.currentImage++;
    }
    [self retImages];
}

-(void)delImage:(UIButton*)sender
{
    [self.imageArray removeObjectAtIndex:self.currentImage];
    NSString *str=nil;
    for (int i = 0 ;i<[self.imageArray count] ; i++) {
        NSString *ss = [self.imageArray objectAtIndex:i];
        if (i==0) {
            str = ss;
        }
        else
        {
            str = [NSString stringWithFormat:@"%@,%@",str,ss];
        }
    }
    NSLog(@"%@",str);
    if ([self.imageArray count]<=self.currentImage) {
        self.currentImage = [self.imageArray count]-1;
    }
    [self retImages];
    BOOL bo = ([self.imageArray count] == 0);
    [self.delegate updataImage:str heightChange:bo];
}

- (void)showPic:(UIButton *)sender{
    if (!self.showPic) {
        return;
    }
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = sender.currentImage;
    [(UIViewController*)self.delegate presentViewController:vc animated:NO completion:^{
        
    }];
}

-(void)MyShowPic:(BOOL)show
{
    self.showPic = show;
    if(self.showPic)
    {
        self.upload.hidden = YES;
        self.del.hidden = YES;
    }
    else
    {
        self.upload.hidden = NO;
        self.del.hidden = NO;
    }
}
@end
