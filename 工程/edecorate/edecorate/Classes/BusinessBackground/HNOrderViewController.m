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
#import "HNOrderDetailTableViewCell.h"
#import "HNLoginData.h"
#import "HNImageData.h"

@interface HNOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableViewCell *orderMess;
@property (strong, nonatomic) IBOutlet UITableViewCell *receiptCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *receiveCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonCell;
@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) UIView *alertContent;
@property (strong, nonatomic) UITextView *cancelMemo;
@property (strong, nonatomic) UILabel *cancelLabel;

@property (strong, nonatomic) NSMutableArray *goodsInfo;
@property (nonatomic, strong) NSMutableArray *stateLog;
@property (nonatomic, strong) NSMutableDictionary *orderDetail;

@property (strong, nonatomic) IBOutlet UILabel *orderidLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusid;
@property (strong, nonatomic) IBOutlet UILabel *originprice;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *freightprice;

@property (strong, nonatomic) IBOutlet UILabel *isinvoice;
@property (strong, nonatomic) IBOutlet UIView *invoiceView;
@property (strong, nonatomic) IBOutlet UILabel *invoicetype;
@property (strong, nonatomic) IBOutlet UILabel *invoicehead;
@property (strong, nonatomic) IBOutlet UILabel *invoicecontent;

@property (strong, nonatomic) IBOutlet UILabel *receivename;
@property (strong, nonatomic) IBOutlet UILabel *receivemobile;
@property (strong, nonatomic) IBOutlet UILabel *receiveaddress;
@property (strong, nonatomic) IBOutlet UIButton *editPrice;
@property (strong, nonatomic) IBOutlet UIButton *cancelOrder;

@property (nonatomic, assign) BOOL firstLoad;
@property (nonatomic, strong) NSDictionary *statusidMap;
@end
static NSString *identy = @"orderDetailCell";
@implementation HNOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNOrderDetailTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identy];
    
    self.firstLoad = YES;
    self.orderDetail = [NSMutableDictionary new];
    
    self.editPrice.layer.cornerRadius = 7.0;
    [self.editPrice setBackgroundColor:[UIColor projectGreen]];
    self.cancelOrder.layer.cornerRadius = 7.0;
    [self.cancelOrder setBackgroundColor:[UIColor projectGreen]];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    if (self.firstLoad) {
        [self loadData];
        self.firstLoad = NO;
    }
    else
        [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)loadData{
    NSDictionary *sendDic = @{@"orderid": self.orderid};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.order.detial" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count != 0)
            {
                self.orderDetail = [[retDic objectForKey:@"data"][0] mutableCopy];
                self.goodsInfo = [self.orderDetail[@"goodsinfo"] mutableCopy];
                [self loadPic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
            else
                [self showNoData];
        }
        else
            [self showNoNetwork];
    }];
    
    //请求订单动态数据
    request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.order.statelog" Params:sendJson]];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count != 0)
            {
                [self.stateLog removeAllObjects];
                self.stateLog = [[retDic objectForKey:@"data"] mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
    }];
}
- (void)loadPic{
    for (int i = 0;i<[self.goodsInfo count];i++){
        id obj = [self.goodsInfo objectAtIndex:i];
        __block NSMutableDictionary *cpy = [obj mutableCopy];
        UIImage *img = [UIImage imageNamed:@"selectphoto.png"];
        [cpy setObject:img forKey:@"uiimage"];
        [self.goodsInfo replaceObjectAtIndex:i withObject:cpy];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0;i<[self.goodsInfo count];i++){
            id obj = [self.goodsInfo objectAtIndex:i];
            UIImage *image = [[HNImageData shared] imageWithLink:obj[@"imgurl"]];
            [obj setObject:image forKey:@"uiimage"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}
- (void)showNoNetwork{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
    
}
- (void)showNoData{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
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
    [alertView setButtonTitles:@[NSLocalizedString(@"OK", nil),NSLocalizedString(@"取消", nil)]];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2)
        return [self.goodsInfo count];
    if (section == 4)
        return [self.stateLog count];
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section !=5)
        return 44;
    else
        return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    if (section == 5)
        return view;
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, 320, 44);
    UILabel *label = [UILabel new];
    switch (section) {
        case 0:
            label.text = NSLocalizedString(@"订单信息", nil);
            break;
        case 1:
            label.text = NSLocalizedString(@"发票信息", nil);
            break;
        case 2:
            label.text = NSLocalizedString(@"商品信息", nil);
            break;
        case 3:
            label.text = NSLocalizedString(@"收货信息", nil);
            break;
        case 4:
            label.text = NSLocalizedString(@"订单动态", nil);
        default:
            break;
    }
    [label sizeToFit];
    label.textColor = [UIColor projectGreen];
    label.left = 10;
    label.centerY = view.height / 2;
    [view addSubview:label];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 43, 310, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 )
        return 162;
    if (indexPath.section == 1)
    {
        if ([[NSString stringWithFormat:@"%@",self.orderDetail[@"isinvoice"]] isEqualToString:@"0"])//不需要发票;
            return 44;
        else
            return 135;
    }
    if (indexPath.section == 2)
        return 100;
    if (indexPath.section == 3)
        return 100;
    if (indexPath.section == 4)
        return 55;
    if (indexPath.section == 5)
        return 44;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0)
    {
        cell = self.orderMess;
        self.orderidLabel.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"orderid"]];
        self.statusid.text = [[HNLoginData shared] mapOrderStatusID:[NSString stringWithFormat:@"%@",self.orderDetail[@"statusid"]]];
        self.number.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"number"]];
        self.price.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"price"]];
        self.originprice.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"originprice"]];
        self.freightprice.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"freightprice"]];
        
    }
    if (indexPath.section == 1)
    {
        cell = self.receiptCell;
        NSString *invoice = [NSString stringWithFormat:@"%@",self.orderDetail[@"isinvoice"]];
        self.isinvoice.text = [invoice isEqualToString:@"0"] ? NSLocalizedString(@"否", nil) : NSLocalizedString(@"是", nil);
        self.invoiceView.hidden = [invoice isEqualToString:@"0"];
        self.invoicetype.text = [[NSString stringWithFormat:@"%@",self.orderDetail[@"invoicetype"]] isEqualToString:@"0"] ? NSLocalizedString(@"普通发票", nil) : NSLocalizedString(@"增值税发票", nil);
        self.invoicehead.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"invoicehead"]];
        self.invoicecontent.text = [NSString stringWithFormat:@"%@",self.orderDetail[@"invoicecontent"]];
    }
    if (indexPath.section == 2)
    {
        HNOrderDetailTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:identy];
        [tCell setContent:self.goodsInfo[indexPath.row]];
        cell = tCell;
    }
    if (indexPath.section == 3)
    {
        cell = self.receiveCell;
        self.receivename.text = self.orderDetail[@"receivename"];
        self.receivemobile.text = self.orderDetail[@"receivemobile"];
        self.receiveaddress.text = self.orderDetail[@"receiveaddress"];
    }
    if (indexPath.section == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"stateCell"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stateCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell.textLabel.text = @"";
        cell.textLabel.numberOfLines = 3;
        if (self.stateLog)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",self.stateLog[indexPath.row][@"time"],self.stateLog[indexPath.row][@"content"]];
        }
    }
    if (indexPath.section == 5)
        cell = self.buttonCell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
