//
//  HNEditPriceViewController.m
//  edecorate
//
//  Created by hxx on 9/29/14.
//
//

#import "HNEditPriceViewController.h"

@interface HNEditPriceViewController ()

@end

@implementation HNEditPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(id)sender{
    
}
- (void)cancel:(id)sender{
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
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
