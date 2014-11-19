//
//  HNNewCheckTableViewCell.h
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import <UIKit/UIKit.h>

@interface HNNewCheckTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *itemId;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *upload;
@property (strong, nonatomic) UIButton *del;
@property (strong, nonatomic) UIImageView *curImageView;
@end
