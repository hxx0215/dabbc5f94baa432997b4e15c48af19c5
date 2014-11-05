//
//  HNSettingViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-5.
//
//

#import "HNSettingViewController.h"

@interface HNSettingViewController ()
@property(nonatomic,strong) IBOutlet UIView* view1;
@property(nonatomic,strong) IBOutlet UIView* view2;
@end

@implementation HNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置";
    self.view1.backgroundColor = [UIColor whiteColor];
    self.view2.backgroundColor = [UIColor whiteColor];
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
