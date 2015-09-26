//
//  HNImageUploadTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-10.
//
//

#import <UIKit/UIKit.h>
#import "HNUploadImage.h"
#import "HNImageData.h"

@interface HNImageUploadTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton *photo;
@property (nonatomic, strong)UIButton *deletePhoto;
@property (nonatomic, strong)UIButton *addPhoto;
@property (nonatomic, strong)UIButton *leftPhoto;
@property (nonatomic, strong)UIButton *rightPhoto;
@property (nonatomic, strong)UILabel *title;
- (void)reset:(NSString*)imageString;
@end
