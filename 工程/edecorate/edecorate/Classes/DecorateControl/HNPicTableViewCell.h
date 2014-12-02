//
//  HNPicTableViewCell.h
//  edecorate
//
//  Created by hxx on 12/2/14.
//
//

#import <UIKit/UIKit.h>

@interface HNPicTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UIImage *imageToShow;
@property (nonatomic, copy) NSString *contentTitle;
@end
