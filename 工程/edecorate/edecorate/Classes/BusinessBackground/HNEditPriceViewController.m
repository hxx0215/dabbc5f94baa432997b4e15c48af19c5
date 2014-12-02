//
//  HNEditPriceViewController.m
//  edecorate
//
//  Created by hxx on 9/29/14.
//
//

#import "HNEditPriceViewController.h"
#import "HNOrderDetailTableViewCell.h"
#import "HNLoginData.h"

@interface HNEditPriceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *editCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *addrCell;
@property (strong, nonatomic) IBOutlet UILabel *originPrice;
@property (strong, nonatomic) IBOutlet UILabel *transPrice;
@property (strong, nonatomic) IBOutlet UILabel *sumPrice;
@property (strong, nonatomic) IBOutlet UITextField *goodsPrice;
@property (strong, nonatomic) IBOutlet UITextField *editTrans;
@property (strong, nonatomic) IBOutlet UIButton *isFreeTrans;

@end
static NSString *kEditPriceCellIdenty = @"EditPriceCell";
@implementation HNEditPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNOrderDetailTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kEditPriceCellIdenty];
    
    [self initAccessoryView];
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
    [self.goodsPrice setInputAccessoryView:topView];
    [self.editTrans setInputAccessoryView:topView];
}
- (void)resignKeyboard{
    self.tableView.frame = self.view.bounds;
    [self.goodsPrice resignFirstResponder];
    [self.editTrans resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)done:(id)sender{
    NSDictionary *sendDic = @{@"mshopid": [HNLoginData shared].mshopid ,@"orderid" : self.orderid,@"ordermark" :@"",@"orderstate" :@"",@"newprice":self.goodsPrice.text,@"newfreight":self.editTrans.text};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"update.order.operation" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count != 0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[[retDic objectForKey:@"data"][0] objectForKey:@"msg"] delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
                alert.tag =[[[retDic objectForKey:@"data"][0] objectForKey:@"state"] integerValue];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }
            else
                [self showNoData];
        }
        else
            [self showNoNetwork];
    }];
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
- (void)cancel:(id)sender{
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
}
- (IBAction)checkFree:(UIButton *)sender {
    sender.selected = ! sender.selected;
}

#pragma mark UITableViewDelegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return [self.orderArr count];
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return 100;
    if (indexPath.section == 1)
        return 155;
    if (indexPath.section == 2)
        return 70;
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0)
    {
        HNOrderDetailTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:kEditPriceCellIdenty];
        [tCell setContent:self.orderArr[indexPath.row]];
        cell = tCell;
        
    }
    if (indexPath.section == 1)
    {
        cell = self.editCell;
        self.originPrice.text = self.totalPrice;
        self.transPrice.text = self.trans;
        
        self.sumPrice.text = [NSString stringWithFormat:@"%@ + %@ = %.2f",isZero(self.goodsPrice.text),isZero(self.editTrans.text),[self.goodsPrice.text floatValue] + [self.editTrans.text floatValue]];
    }
    if (indexPath.section == 2)
    {
        cell = self.addrCell;
    }
    return cell;
}
NSString * isZero(NSString *str){
    if (!str || [str isEqualToString:@""])
        return @"0.0";
    return str;
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.sumPrice.text = [NSString stringWithFormat:@"%@ + %@ = %.2f",isZero(self.goodsPrice.text),isZero(self.editTrans.text),[self.goodsPrice.text floatValue] + [self.editTrans.text floatValue]];
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1)
    {
        [self cancel:nil];
    }
}
@end
