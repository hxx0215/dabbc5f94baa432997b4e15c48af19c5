//
//  HNFilterDataViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-12-2.
//
//

#import "HNFilterDataViewController.h"
#import "HNCityChoiceViewController.h"

@interface HNFilterDataViewController ()

@end

@implementation HNFilterDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)cityChoiceClick:(id)sender
{
    HNCityChoiceViewController *vc = [[HNCityChoiceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
