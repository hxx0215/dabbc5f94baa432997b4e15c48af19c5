//
//  HNDeliverDetailViewController.m
//  edecorate
//
//  Created by hxx on 9/22/14.
//
//

#import "HNDeliverDetailViewController.h"
#import "UIView+AHKit.h"
@interface HNDeliverDetailViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIButton *onlinePay;

@end

@implementation HNDeliverDetailViewController

-(id)initWithModel:(HNDeliverData *)model{
    self = [super init];
    self.deliverModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.width, 662);
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
