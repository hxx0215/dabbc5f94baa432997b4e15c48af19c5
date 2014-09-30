//
//  HNOrderViewController.m
//  edecorate
//
//  Created by hxx on 9/28/14.
//
//

#import "HNOrderViewController.h"
#import "CustomIOS7AlertView.h"
#import "HNEditPriceViewController.h"

@interface HNOrderViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIView *logisticsView;
@property (strong, nonatomic) IBOutlet UIView *receiveView;
@property (strong, nonatomic) IBOutlet UIView *orderMessageView;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIButton *changePriceButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *deliverButton;
@property (strong, nonatomic) IBOutlet UILabel *remainTime;

@property (assign, nonatomic) HNOrderType orderType;
@property (strong, nonatomic) UIView *alertContent;
@property (strong, nonatomic) UITextView *cancelMemo;
@property (strong, nonatomic) UILabel *cancelLabel;

@end

@implementation HNOrderViewController
- (instancetype)initWithType:(HNOrderType)type{
    self = [super init];
    if (self){
        self.orderType = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    switch (self.orderType){
        case kWaiting:
            break;
        case kUnsolved:
        {
            self.changePriceButton.hidden = YES;
            self.cancelOrderButton.hidden = YES;
            self.deliverButton.hidden = NO;
            self.actionView.top = self.orderMessageView.bottom;
            self.remainTime.hidden = YES;
        }
            break;
        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.width, 568);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePrice:(id)sender {
    HNEditPriceViewController *editor = [[HNEditPriceViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editor];
    [self.navigationController.view setUserInteractionEnabled:NO];
    [self presentViewController:nav animated:YES completion:^{
        [self.navigationController.view setUserInteractionEnabled:YES];
    }];
}
- (IBAction)cancelOrder:(id)sender {
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    alertView.parentView = self.navigationController.view;
    alertView.containerView  = self.alertContent;
    [alertView setButtonTitles:@[NSLocalizedString(@"OK", nil),NSLocalizedString(@"Close", nil)]];
    [alertView show];
}
- (IBAction)deliver:(id)sender {
    NSLog(@"发货");
}

- (UIView *)alertContent{
    if (!_alertContent){
        _alertContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
        self.cancelLabel = [[UILabel alloc] init];
        self.cancelLabel.text = NSLocalizedString(@"Cancel Order Memo:", nil);
        [self.cancelLabel sizeToFit];
        [_alertContent addSubview:self.cancelLabel];
        self.cancelMemo = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, 260, 160)];
        [_alertContent addSubview:self.cancelMemo];
    }
    return _alertContent;
}

@end
