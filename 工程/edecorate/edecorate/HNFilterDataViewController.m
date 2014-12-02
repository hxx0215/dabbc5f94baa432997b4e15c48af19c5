//
//  HNFilterDataViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-12-2.
//
//

#import "HNFilterDataViewController.h"
#import "HNCityChoiceViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface HNFilterDataViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *locationName;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation HNFilterDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得的所有信息显示到label上
//             self.location.text = placemark.name;
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             [self.locationName setTitle:city forState:UIControlStateNormal];
             
         }
         else if (error == nil && [array count] == 0)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.locationName setTitle:NSLocalizedString(@"无法定位", nil) forState:UIControlStateNormal];
                 UIAlertView *alert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"无法获得您当前的位置请手动选择城市", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
                 [alert show];
             });
         }
         else if (error != nil)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.locationName setTitle:NSLocalizedString(@"无法定位", nil) forState:UIControlStateNormal];
             });
         }
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
