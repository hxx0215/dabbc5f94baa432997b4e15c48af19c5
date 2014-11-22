//
//  HNGoodsViewController.m
//  edecorate
//
//  Created by hxx on 9/27/14.
//
//

#import "HNGoodsViewController.h"
#import "HNLoginData.h"

@interface HNGoodsViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) NSMutableDictionary *goodsDetail;
@end

@implementation HNGoodsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backView.frame = self.view.bounds;
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(320, 935);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    NSDictionary *sendDic = @{@"mshopid": [HNLoginData shared].mshopid,@"goodsid" : self.goodsid,@"imgwidth" : @"89", @"imgheight" : @"89"};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.goods.detail" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSDictionary *retDic = [retJson objectFromJSONString];
        NSLog(@"%@",retDic);
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
