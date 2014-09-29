//
//  HNCommentsDetailViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-28.
//
//

#import "HNCommentsDetailViewController.h"
#import "HNCommentsCell.h"
#import "UIView+AHKit.h"

@interface HNCommentsDetailViewController ()<HNCommentsDelegate>

@property(nonatomic,strong)IBOutlet UILabel *GoodsNameLable;
@property(nonatomic,strong)IBOutlet UILabel *GoodsPriceLable;
@property(nonatomic,strong)IBOutlet UILabel *GoodsCountLable;
@property(nonatomic,strong)IBOutlet UILabel *GoodsRemarksLable;
@property(nonatomic,strong)IBOutlet UILabel *CommentNameLable;
@property(nonatomic,strong)IBOutlet UILabel *CommentRemarksLable;

@property(nonatomic,strong)IBOutlet HNCommentsCell *commentsView;
@end

@implementation HNCommentsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self labelWithTitle:@"商品名称a"  label:self.GoodsNameLable];
    [self labelWithTitle:@"￥10.00"   label:self.GoodsPriceLable];
    [self labelWithTitle:@"1"  label:self.GoodsCountLable];
    [self labelWithTitle:@"你值得拥有"  label:self.GoodsRemarksLable];
    
    [self labelWithTitle:@"希腊胡"  label:self.CommentNameLable];
    [self labelWithTitle:@"你值得拥有"  label:self.CommentRemarksLable];
 
    self.navigationController.title=@"评论详情";
    
    self.commentsView = [[HNCommentsCell alloc]initWithFrame:CGRectMake(0, self.GoodsRemarksLable.bottom+10, self.view.width, 100)];
    self.commentsView.delegate = self;
    [self.view addSubview:self.commentsView];
  
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)CommentsNewDid:(HNCommentsCell*)commentsCell
{
}
- (void)CommentsDeleteDid:(HNCommentsCell*)commentsCell
{
}
- (void)CommentsHideDid:(HNCommentsCell*)commentsCell
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
