//
//  HNPassAddNewTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import <UIKit/UIKit.h>

@interface HNPassAddNewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *cardNOTextField;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@end
