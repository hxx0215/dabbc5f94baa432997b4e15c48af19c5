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
#import "JSONKit.h"
#import "MBProgressHUD.h"


//// 模拟器 宏定义
//#ifdef TARGET_IPHONE_SIMULATOR
//@interface CLLocationManager (Simulator)
//@end
//
//@implementation CLLocationManager (Simulator)
//
//-(void)startUpdatingLocation
//{
//    float latitude = 32.061;
//    float longitude = 118.79125;
//    CLLocation *setLocation= [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//    [self.delegate locationManager:self didUpdateToLocation:setLocation
//                      fromLocation:setLocation];
//}
//@end
//#endif // TARGET_IPHONE_SIMULATOR

@interface HNFilterDataViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *locationName;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;

@property (strong, nonatomic) IBOutlet UISegmentedControl *seg;
@end

@implementation HNFilterDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    self.seg.selectedSegmentIndex = [HNFilterModel shared].ordertype.integerValue;
    
    self.btn1.layer.borderWidth = 1;
    self.btn1.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    self.btn2.layer.borderWidth = 1;
    self.btn2.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    self.btn3.layer.borderWidth = 1;
    self.btn3.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    self.btn4.layer.borderWidth = 1;
    self.btn4.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    if ([HNFilterModel shared].goodsType1) {
        self.btn1.backgroundColor = [UIColor projectGreen];
        [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        self.btn1.backgroundColor = [UIColor whiteColor];
        [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if ([HNFilterModel shared].goodsType2) {
        self.btn2.backgroundColor = [UIColor projectGreen];
        [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        self.btn2.backgroundColor = [UIColor whiteColor];
        [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if ([HNFilterModel shared].goodsType3) {
        self.btn3.backgroundColor = [UIColor projectGreen];
        [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        self.btn3.backgroundColor = [UIColor whiteColor];
        [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if ([HNFilterModel shared].goodsType4) {
        self.btn4.backgroundColor = [UIColor projectGreen];
        [self.btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        self.btn4.backgroundColor = [UIColor whiteColor];
        [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
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
    if (![HNFilterModel shared].city) {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        [self.locationName setTitle:[HNFilterModel shared].city forState:UIControlStateNormal];
    }
    [self.locationName sizeToFit];
    
}

-(IBAction)goodsTypeClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            [HNFilterModel shared].goodsType1 = ![HNFilterModel shared].goodsType1;
            if ([HNFilterModel shared].goodsType1) {
                sender.backgroundColor = [UIColor projectGreen];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else{
                sender.backgroundColor = [UIColor whiteColor];
                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
            break;
        case 3:
        {
            [HNFilterModel shared].goodsType3 = ![HNFilterModel shared].goodsType3;
            if ([HNFilterModel shared].goodsType3) {
                sender.backgroundColor = [UIColor projectGreen];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else{
                sender.backgroundColor = [UIColor whiteColor];
                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
            break;
        case 2:
        {
            [HNFilterModel shared].goodsType2 = ![HNFilterModel shared].goodsType2;
            if ([HNFilterModel shared].goodsType2) {
                sender.backgroundColor = [UIColor projectGreen];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else{
                sender.backgroundColor = [UIColor whiteColor];
                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
            break;
        case 4:
        {
            [HNFilterModel shared].goodsType4 = ![HNFilterModel shared].goodsType4;
            if ([HNFilterModel shared].goodsType4) {
                sender.backgroundColor = [UIColor projectGreen];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else{
                sender.backgroundColor = [UIColor whiteColor];
                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
            break;
            
        default:
            break;
    };
}

-(IBAction)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    [HNFilterModel shared].ordertype = [NSString stringWithFormat:@"%ld",Index];
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
             [HNFilterModel shared].city = city;
             [self.locationName setTitle:city forState:UIControlStateNormal];
             [self loadMyData];
             
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
    [self.locationName sizeToFit];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

#pragma mark -LoadMyData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid", nil];
    //NSLog(@"%@",[HNLoginData shared].mshopid);
    NSString *jsonStr = [NSString stringWithFormat:@"{\"cityname\":\"%@\"}",[HNFilterModel shared].city];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.city.list" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        [self performSelectorOnMainThread:@selector(didLoadMyData:) withObject:data waitUntilDone:YES];
    }];
}



-(void)didLoadMyData:(NSData*)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        //NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<[array count]; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                //cityModel *model = [[cityModel alloc]init];
                [HNFilterModel shared].cityID = [dicData objectForKey:@"areaid"];
                //model.name = [dicData objectForKey:@"name"];
                //model.abc = [dicData objectForKey:@"abc"];
            }
        }
    }
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
