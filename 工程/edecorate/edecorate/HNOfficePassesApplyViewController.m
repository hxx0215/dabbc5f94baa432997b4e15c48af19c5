//
//  HNOfficePassesApplyViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import "HNOfficePassesApplyViewController.h"
#import "UIView+AHKit.h"

@interface HNOfficePassesApplyViewController ()

@property (nonatomic,strong) IBOutlet UIScrollView *mainView;

@end

@implementation HNOfficePassesApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // _mainView.contentSize=cgsizemake(self.view.bounds.size.width, self.sumMoney.bottom+20);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
