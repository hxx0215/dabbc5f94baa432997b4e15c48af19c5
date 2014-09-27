//
//  HNBusinessBKControlViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNBusinessBKControlViewController.h"
#import "UIView+AHKit.h"
#import "VolumeViewController.h"

@interface HNBusinessBKControlViewController ()
@property (strong, nonatomic) IBOutlet UIButton *messagePayingButton;
@property (strong, nonatomic) IBOutlet UIButton *messageShippingButton;
@property (strong, nonatomic) IBOutlet UIButton *messageShippedButton;
@property (strong, nonatomic) IBOutlet UIButton *messageSuccessfulButton;

@property (strong, nonatomic) IBOutlet UIButton *merchandiseButton;
@property (strong, nonatomic) IBOutlet UIButton *orderButton;
@property (strong, nonatomic) IBOutlet UIButton *returnsButton;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UIButton *volumeButton;


@end

#define HSPACE 50
#define WSPACE 15
#define TSPACEPER 0.1
#define BTNHEIGHT 50
#define STARTTOP 50

@implementation HNBusinessBKControlViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self messageButtonWithTitle:NSLocalizedString(@"Pending payment", nil) button:self.messagePayingButton numMessage:3 index:0];
    [self messageButtonWithTitle:NSLocalizedString(@"To be shipped", nil) button:self.messageShippingButton numMessage:3 index:1];
    [self messageButtonWithTitle:NSLocalizedString(@"Shipped", nil) button:self.messageShippedButton numMessage:3 index:2];
    [self messageButtonWithTitle:NSLocalizedString(@"Successful transaction", nil) button:self.messageSuccessfulButton numMessage:3 index:3];
    
    [self businessButtonWithTitle:NSLocalizedString(@"My merchandise", nil) button:self.merchandiseButton rowIndex:0 coloumIndex:0];
    [self businessButtonWithTitle:NSLocalizedString(@"Order Management", nil) button:self.orderButton rowIndex:0 coloumIndex:1];
    [self businessButtonWithTitle:NSLocalizedString(@"Returns Management", nil) button:self.returnsButton rowIndex:0 coloumIndex:2];
    [self businessButtonWithTitle:NSLocalizedString(@"Comments", nil) button:self.commentsButton rowIndex:1 coloumIndex:0];
    [self businessButtonWithTitle:NSLocalizedString(@"My Profile", nil) button:self.profileButton rowIndex:1 coloumIndex:1];
    [self businessButtonWithTitle:NSLocalizedString(@"Consumption volume verification", nil) button:self.volumeButton rowIndex:1 coloumIndex:2];
    
    self.navigationItem.title = NSLocalizedString(@"Business Background", nil);
    // Do any additional setup after loading the view from its nib.
}

- (UIButton *)messageButtonWithTitle:(NSString *)title button:(UIButton*)btn numMessage:(NSInteger)num index:(NSInteger)colom
{
    NSString *str = [[NSString alloc]initWithFormat:@"%@\n%ld",title,num];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.width = self.view.width/4;
    btn.height = 50;
    btn.left = self.view.width/4*colom;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.numberOfLines = 2;
    //btn.font = [UIFont systemFontOfSize:12];
    return btn;
}

- (UIButton *)businessButtonWithTitle:(NSString *)title button:(UIButton*)btn rowIndex:(NSInteger)row coloumIndex:(NSInteger)coloum
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.width = (self.view.width - 5 * WSPACE)/3;
    btn.height = BTNHEIGHT;
    btn.left = WSPACE+(btn.width+WSPACE)*coloum;
    btn.top = 50+HSPACE+(BTNHEIGHT+HSPACE)*row;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.numberOfLines = 2;
    //btn.font = [UIFont systemFontOfSize:12];
    return btn;
}


- (IBAction)merchandiseClicked:(id)sender {
}
- (IBAction)orderClicked:(id)sender {
}
- (IBAction)returnsClicked:(id)sender {
}
- (IBAction)commentsClicked:(id)sender {
}
- (IBAction)profileClicked:(id)sender{
}
- (IBAction)volumeClicked:(id)sender {
    VolumeViewController* vc = [[VolumeViewController alloc]init];
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
