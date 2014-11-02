//
//  HNNewCheckViewController.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNNewCheckViewController.h"
#import "HNDecorateChoiceView.h"
#import "HNLoginData.h"

@interface HNNewCheckViewController ()<UITableViewDelegate,UITableViewDataSource,HNDecorateChoiceViewDelegate>
@property (nonatomic, strong) HNDecorateChoiceView *pickView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation HNNewCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pickView = [[HNDecorateChoiceView alloc] initWithFrame:CGRectMake(12, 12, self.view.width - 24, 25)];
    self.pickView.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.pickView.bottom + 5, self.view.width, 300)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.pickView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updataDecorateInformation:(HNDecorateChoiceModel *)model{
    if (!model || [model.declareId isEqualToString:@""]){
        [self showNoData];
    }else{
        NSDictionary *sendDic = @{@"mshopid": [[HNLoginData shared] mshopid],@"declareid" : model.declareId};
        NSString *sendJson = [sendDic JSONString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.acceptance.details" Params:sendJson]];
        NSString *contentType = @"text/html";
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
            if (data){
                NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
                NSDictionary *retDic = [retJson objectFromJSONString];
                NSInteger count = [[retDic objectForKey:@"total"] integerValue];
                if (0 != count){
                    [self.dataArr removeAllObjects];
                    self.dataArr = [[retDic objectForKey:@"data"] mutableCopy];
                    [self.tableView reloadData];
                }
                else{
                    [self.dataArr removeAllObjects];
                    [self.tableView reloadData];
                    [self showNoData];
                }
            }else{
                [self showNoNet];
            }
        }];
    }
}
- (void)showNoNet{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//    [alert show];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

- (void)showNoData{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//    [alert show];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArr[section] objectForKey:@"ItemBody"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"newCheckCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [[self.dataArr[indexPath.section] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodyname"];
    return cell;
}
@end
