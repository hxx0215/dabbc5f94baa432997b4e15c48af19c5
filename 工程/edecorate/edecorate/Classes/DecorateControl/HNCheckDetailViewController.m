//
//  HNCheckDetailViewController.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNCheckDetailViewController.h"

@interface HNCheckDetailViewController ()
@property (nonatomic, strong)IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIButton *originStructure;
@property (strong, nonatomic) IBOutlet UIButton *waterProof;
@property (strong, nonatomic) IBOutlet UIButton *Circuit;
@property (strong, nonatomic) IBOutlet UIButton *backFill;
@property (strong, nonatomic) IBOutlet UIButton *complete;

@end

@implementation HNCheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.originStructure setTitle:NSLocalizedString(@"Origin", nil) forState:UIControlStateNormal];
    [self.waterProof setTitle:NSLocalizedString(@"Water", nil) forState:UIControlStateNormal];
    [self.Circuit setTitle:NSLocalizedString(@"Circuir", nil) forState:UIControlStateNormal];
    [self.backFill setTitle:NSLocalizedString(@"Backfill", nil) forState:UIControlStateNormal];
    [self.complete setTitle:NSLocalizedString(@"Complete", nil) forState:UIControlStateNormal];
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
