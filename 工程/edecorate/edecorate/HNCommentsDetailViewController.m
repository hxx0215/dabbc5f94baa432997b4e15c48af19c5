//
//  HNCommentsDetailViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-28.
//
//

#import "HNCommentsDetailViewController.h"

@interface HNCommentsDetailViewController ()

@property(nonatomic,strong)IBOutlet UILabel *GoodsName;
@property(nonatomic,strong)IBOutlet UILabel *GoodsPrice;
@property(nonatomic,strong)IBOutlet UILabel *GoodsCount;
@property(nonatomic,strong)IBOutlet UILabel *GoodsRemarks;
@property(nonatomic,strong)IBOutlet UILabel *CommentName;
@property(nonatomic,strong)IBOutlet UILabel *CommentRemarks;
@end

@implementation HNCommentsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self labelWithTitle:@"商品名称a"  label:self.GoodsName];
    [self labelWithTitle:@"￥10.00"   label:self.GoodsPrice];
    [self labelWithTitle:@"1"  label:self.GoodsCount];
    [self labelWithTitle:@"你值得拥有"  label:self.GoodsRemarks];
    
    [self labelWithTitle:@"希腊胡"  label:self.CommentName];
    [self labelWithTitle:@"你值得拥有"  label:self.CommentRemarks];
 
    self.navigationController.title=@"评论详情";
  
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
