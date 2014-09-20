//
//  HNReportPurchaseViewController.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNReportPurchaseViewController.h"
#import "HNDecorateReportViewController.h"

@interface HNReportPurchaseViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong)IBOutlet UILabel *haveToPayLabel;
@property (nonatomic, strong)IBOutlet UILabel *haveToPayItems;
@property (nonatomic, strong)IBOutlet UILabel *optionalLabel;
@property (nonatomic, strong)IBOutlet UILabel *total;
@property (nonatomic, strong)IBOutlet UIButton *onlinePay;
@end

@implementation HNReportPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.onlinePay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pay:(id)sender{
    [self success];
}

- (void)success{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", nil) message:NSLocalizedString(@"Pay success,you apply for construction have submitted,lease in through the audit to the property office to receive a permit.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSArray *viewControllers = [self.navigationController viewControllers];
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass:[HNDecorateReportViewController class]]){
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }
    }];
}
@end
