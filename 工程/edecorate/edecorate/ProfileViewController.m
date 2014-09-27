//
//  ProfileViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "ProfileViewController.h"
#import "ProfileChangeViewController.h"
#import "UIView+AHKit.h"


@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopkeeperTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *onlineServiceTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopkeeperLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *onlineServiceLabel;

@property (strong, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self labelWithTitle:NSLocalizedString(@"Name", nil) label:self.nameTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Category", nil) label:self.categoryTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Address", nil) label:self.addressTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Shopkeeper", nil) label:self.shopkeeperTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone", nil) label:self.phoneTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Online Service (QQ)", nil) label:self.onlineServiceTitleLabel];
    
    self.changeButton.layer.borderWidth = 1.0;
    self.changeButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.changeButton setTitle:NSLocalizedString(@"Change2", nil) forState:UIControlStateNormal];
    
}

- (IBAction)changButtonClick:(id)sender {
    ProfileChangeViewController *controller = [[ProfileChangeViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
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
