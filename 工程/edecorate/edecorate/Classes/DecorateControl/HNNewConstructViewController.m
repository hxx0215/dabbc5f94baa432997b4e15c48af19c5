//
//  HNNewConstructViewController.m
//  edecorate
//
//  Created by hxx on 9/23/14.
//
//

#import "HNNewConstructViewController.h"
#import "UIView+AHKit.h"
#import "HNReportPurchaseViewController.h"

@interface HNNewConstructViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIView *purchaseListView;
@property (strong, nonatomic) IBOutlet UIButton *purchaseButton;

@end

@implementation HNNewConstructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.width, self.purchaseListView.hidden ? self.purchaseButton.bottom + 10 : self.purchaseListView.bottom + 10);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)purchase:(id)sender {
    HNReportPurchaseViewController *purchaseViewController = [[HNReportPurchaseViewController alloc] init];
    [self.navigationController pushViewController:purchaseViewController animated:YES];
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
