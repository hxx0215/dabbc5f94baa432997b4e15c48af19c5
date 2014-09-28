//
//  ProfileViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNProfileViewController.h"
#import "HNProfileChangeViewController.h"
#import "UIView+AHKit.h"
#import "HNBusinessBackgroundModel.h"

@interface HNProfileViewController ()
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

@property (strong, nonatomic) HNBusinessBKProfileModel *model;

@end

@implementation HNProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self labelWithTitle:NSLocalizedString(@"Name", nil) label:self.nameTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Category", nil) label:self.categoryTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Address", nil) label:self.addressTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Shopkeeper", nil) label:self.shopkeeperTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone", nil) label:self.phoneTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Online Service (QQ)", nil) label:self.onlineServiceTitleLabel];
    
    self.model = [[HNBusinessBKProfileModel alloc]init];

    
    self.changeButton.layer.borderWidth = 1.0;
    self.changeButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.changeButton setTitle:NSLocalizedString(@"Change2", nil) forState:UIControlStateNormal];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self labelWithTitle:self.model.name leftLabel:self.nameTitleLabel label:self.nameLabel];
    [self labelWithTitle:self.model.category leftLabel:self.categoryTitleLabel label:self.categoryLabel];
    [self labelWithTitle:self.model.address leftLabel:self.addressTitleLabel label:self.addressLabel];
    [self labelWithTitle:self.model.shopkeeper leftLabel:self.shopkeeperTitleLabel label:self.shopkeeperLabel];
    [self labelWithTitle:self.model.phone leftLabel:self.phoneTitleLabel label:self.phoneLabel];
    [self labelWithTitle:self.model.onlineService leftLabel:self.onlineServiceTitleLabel label:self.onlineServiceLabel];
}

- (IBAction)changButtonClick:(id)sender {
    HNProfileChangeViewController *controller = [[HNProfileChangeViewController alloc] init];
    controller.model = self.model;
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

- (void)labelWithTitle:(NSString *)title leftLabel:(UILabel*)leftlab label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:11];
    lab.numberOfLines = 2;
    lab.left = leftlab.left+leftlab.width;
    lab.top = leftlab.top;
    lab.height = leftlab.height;
    
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
