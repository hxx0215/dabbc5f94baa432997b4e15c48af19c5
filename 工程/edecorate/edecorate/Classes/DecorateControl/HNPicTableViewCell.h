//
//  HNPicTableViewCell.h
//  edecorate
//
//  Created by hxx on 12/2/14.
//
//

#import <UIKit/UIKit.h>

@protocol HNPicTableViewCellDelegate <NSObject>
- (void)updataImage:(NSString*)images heightChange:(BOOL)change;
@end

@interface HNPicTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *itemId;
@property (strong, nonatomic) UIButton *upload;
@property (strong, nonatomic) UIButton *del;
@property (strong, nonatomic) UIButton *curImage;
@property (strong, nonatomic) UIButton *leftImg;
@property (strong, nonatomic) UIButton *rightImg;
@property (nonatomic) NSInteger index;
@property (nonatomic, weak) id <HNPicTableViewCellDelegate> delegate;
-(void)setImages:(NSString*)images;
-(void)MyShowPic:(BOOL)show;
@end
