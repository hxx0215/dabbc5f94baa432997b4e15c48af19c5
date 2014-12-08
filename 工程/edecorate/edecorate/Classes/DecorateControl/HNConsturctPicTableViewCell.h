//
//  HNConsturctPicTableViewCell.h
//  edecorate
//
//  Created by hxx on 12/3/14.
//
//

#import <UIKit/UIKit.h>

@interface HNConsturctPicTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UIButton *leftImg;
@property (strong, nonatomic) IBOutlet UIButton *rightImg;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIButton *delImage;
@property (strong, nonatomic) IBOutlet UIButton *uploadImage;
@property (strong, nonatomic) IBOutlet UIButton *showPic;
@property (strong, nonatomic) UIImage *img;
@end
