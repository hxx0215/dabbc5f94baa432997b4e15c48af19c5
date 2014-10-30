//
//  HNPassAddNewTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import <UIKit/UIKit.h>
#import "HNPassData.h"

@protocol HNPassAddNewTableViewCellDelegate <NSObject>
- (void)moveScrollView:(UITextField*)textFiled;
- (void)finishMoveScrollView:(UITextField*)textFiled;
@end

@interface HNPassAddNewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *cardNOTextField;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) HNPassProposerData* proposerData;
@property (nonatomic, strong) id <HNPassAddNewTableViewCellDelegate> delegate;
@end
