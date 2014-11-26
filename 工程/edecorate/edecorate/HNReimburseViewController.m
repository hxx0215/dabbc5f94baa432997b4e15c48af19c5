//
//  HNReimburseViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-28.
//
//

#import "HNReimburseViewController.h"
#include "UIView+AHKit.h"
#include "HNAcceptReturnGoodViewController.h"
#import "CustomIOS7AlertView.h"
#import "HNReturnDetailTableViewCell.h"
#import "HNImageData.h"

@interface HNReimburseViewController ()<CustomIOS7AlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *returnidCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *returnMessCell;

@property (strong, nonatomic) IBOutlet UILabel *orderid;
@property (strong, nonatomic) IBOutlet UILabel *userPayPrice;
@property (strong, nonatomic) IBOutlet UILabel *onlinePayPrice;

@property (strong, nonatomic) IBOutlet UISwitch *isAgree;
@property (strong, nonatomic) IBOutlet UITextField *takeAddr;
@property (strong, nonatomic) IBOutlet UITextView *memo;
@property (strong, nonatomic) IBOutlet UIButton *confirm;

@property (assign, nonatomic) BOOL shouldRefresh;
@property (strong, nonatomic) NSMutableDictionary *contentDic;
@property (strong, nonatomic) NSMutableArray *exchangeGoods;
@end
static NSString *kHNReturnCellIdenty = @"HNReturnCell";
@implementation HNReimburseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"Order details", nil);
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNReturnDetailTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kHNReturnCellIdenty];
    [self.view addSubview:self.tableView];
    self.shouldRefresh = YES;
    
    self.memo.layer.cornerRadius = 7.0;
    self.memo.backgroundColor = [UIColor colorWithWhite:245.0/255.0 alpha:1.0];
    [self initAccessoryView];
    
    self.confirm.layer.cornerRadius = 7.0;
    [self.confirm setBackgroundColor:[UIColor projectGreen]];
}
- (void)initAccessoryView{
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //设置style
    [topView setBarStyle:UIBarStyleDefault];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"完成", nil) style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    //    [textView setInputView:topView];
    [self.memo setInputAccessoryView:topView];
}
- (void)resignKeyboard{
    self.tableView.frame = self.view.bounds;
    [self.memo resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    if (self.shouldRefresh){
        self.shouldRefresh = NO;
        [self loadData];
    }
    [self.tableView reloadData];
}
- (void)loadData{
    NSDictionary *sendDic = @{@"returnid": self.returnid};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.order.returndetail" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count != 0){
                self.contentDic = [[retDic[@"data"] objectAtIndex:0] mutableCopy];
                [self loadPic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
            }
            else
                [self showNoData];
        }else
            [self showNoNetwork];
    }];
}
- (void)loadPic{
    self.exchangeGoods = [self.contentDic[@"exchangeGoods"] mutableCopy];
    for (int i = 0;i<[self.exchangeGoods count];i++){
        id obj = [self.exchangeGoods objectAtIndex:i];
        __block NSMutableDictionary *cpy = [obj mutableCopy];
        UIImage *img = [UIImage imageNamed:@"selectphoto.png"];
        [cpy setObject:img forKey:@"uiimage"];
        [self.exchangeGoods replaceObjectAtIndex:i withObject:cpy];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0;i<[self.exchangeGoods count];i++){
            id obj = [self.exchangeGoods objectAtIndex:i];
            UIImage *image = [[HNImageData shared] imageWithLink:obj[@"image"]];
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
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0)
        return 0;
    if (section <4)
        return 44;
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    if (section == 0)
        return view;
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, 320, 44);
    UILabel *label = [UILabel new];
    switch (section) {
        case 1:
            label.text = NSLocalizedString(@"商品信息", nil);
            break;
        case 2:
            label.text = NSLocalizedString(@"退换货记录", nil);
            break;
        case 3:
            label.text = NSLocalizedString(@"退款信息", nil);
            break;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    if (section == 1)
        return [self.contentDic[@"exchangeGoods"] count];
    if (section == 2)
        return [self.contentDic[@"exchangelog"] count];
    if (section == 3)
        return 1;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return 100;
    if (indexPath.section == 1)
        return 110;
    if (indexPath.section == 2)
        return 80;
    if (indexPath.section == 3)
        return 235;
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *exchangelogCellIndety = @"ExchangeLogCell";
    UITableViewCell *cell = nil;
    if (indexPath.section == 0)
    {
        cell = self.returnidCell;
        self.orderid.text = self.contentDic[@"orderid"];
        self.userPayPrice.text = [NSString stringWithFormat:@"%@",self.contentDic[@"userPayPrice"]];
        self.onlinePayPrice.text = [NSString stringWithFormat:@"%@",self.contentDic[@"onlinePayPrice"]];
    }
    if (indexPath.section == 1){
        HNReturnDetailTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:kHNReturnCellIdenty];
        [tCell setContent:self.exchangeGoods[indexPath.row]];
        cell = tCell;
    }
    if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:exchangelogCellIndety];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exchangelogCellIndety];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        NSDictionary *dic = self.contentDic[@"exchangelog"][indexPath.row];
        NSString *content = [dic[@"content"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@\n%@",dic[@"username"],dic[@"createtime"],content];
        cell.textLabel.numberOfLines = 5;
    }
    if (indexPath.section == 3){
        cell = self.returnMessCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tableView.height = self.view.height - 216;
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.tableView.height = self.view.height - 216;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.tableView.frame = self.view.bounds;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.tableView.frame = self.view.bounds;
    return YES;
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.tableView.height = self.view.height - 216;
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.tableView.height = self.view.height - 216;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    self.tableView.frame = self.view.bounds;
    return YES;
}

@end
