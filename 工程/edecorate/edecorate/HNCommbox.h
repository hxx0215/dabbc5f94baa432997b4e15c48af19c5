//
//  HNCommbox.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import <UIKit/UIKit.h>

@interface HNCommbox : UIView<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tv;//下拉列表
    NSMutableArray *tableArray;//下拉列表数据
    UITextField *textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}
@property (nonatomic)NSInteger selectRow;
- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray*)array;
-(NSString*)currentText;
@end
