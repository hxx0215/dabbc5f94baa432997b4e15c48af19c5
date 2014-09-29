//
//  HNCommentsTableViewCell.m
//  edecorate
//
//  Created by 熊彬 on 14-9-28.
//
//

#import "HNCommentsTableViewCell.h"

@interface HNCommentsTableViewCell()
@property (nonatomic,strong) IBOutlet UILabel *CommentGoods;
@property(nonatomic,strong) IBOutlet UILabel *CommentPrice;
@property(nonatomic,strong) IBOutlet UILabel *CommentCount;
@property(nonatomic,strong) IBOutlet UILabel *commentName;
@property(nonatomic,strong) IBOutlet UILabel *commentRemarks;
@property (nonatomic,strong) IBOutlet UILabel *CommentTime;

//@property(nonatomic,strong) IBOutlet UILabel *messageName;
//@property(nonatomic,strong) IBOutlet UILabel *messageRemarks;
//@property(nonatomic,strong) IBOutlet UILabel *messageTime;

@end

@implementation HNCommentsTableViewCell


- (void)awakeFromNib {
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) SetTableByType:(int)type;
{
    switch (type) {
        case 0:
     //       self.messageName.text=@"刘向宏";
            self.commentName.text=@"刘向宏";
//            self.messageName.hidden=YES;
//            self.messageRemarks.hidden=YES;
//            self.messageTime.hidden=YES;
//            self.commentName.hidden=NO;
//            self.CommentCount.hidden=NO;
//            self.CommentGoods.hidden=NO;
//            self.CommentPrice.hidden=NO;
//            self.commentRemarks.hidden=NO;
//            self.CommentTime.hidden=NO;
            break;
        case 1:
           // self.messageName.hidden=NO;
          //  self.messageRemarks.hidden=NO;
          //  self.messageTime.hidden=NO;
            self.commentName.hidden=YES;
            self.CommentCount.hidden=YES;
            self.CommentGoods.hidden=YES;
            self.CommentPrice.hidden=YES;
            self.commentRemarks.hidden=YES;
            self.CommentTime.hidden=YES;
            break;
        default:
            break;
    }
}
@end
