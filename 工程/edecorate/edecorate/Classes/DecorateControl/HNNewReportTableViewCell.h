//
//  HNNewReportTableViewCell.h
//  edecorate
//
//  Created by hxx on 11/11/14.
//
//

#import <UIKit/UIKit.h>
typedef enum HNNewReportTableViewCellType{
    HNNewReportTableViewCellTypeButton,
    HNNewReportTableViewCellTypeText,
    HNNewReportTableViewCellTypeDate,
    HNNewReportTableViewCellTypeLabel
}HNNewReportTableViewCellType;
@interface HNNewReportTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) HNNewReportTableViewCellType type;
@end
