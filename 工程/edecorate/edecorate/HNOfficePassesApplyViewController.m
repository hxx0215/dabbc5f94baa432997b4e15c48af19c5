//
//  HNOfficePassesApplyViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import "HNOfficePassesApplyViewController.h"
#import "HNOfficePassesViewController.h"
#import "UIView+AHKit.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNPersonNewTableViewCell.h"
#import "HNDecorateChoiceView.h"
#import "HNUploadImage.h"
#import "HNNeedPayTableViewCell.h"

@interface HNOfficePassesApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,HNDecorateChoiceViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) HNPersonNewTableViewCell *addNewCell;

@property (strong, nonatomic) HNDecorateChoiceView *choiceDecorateView;

@property (strong, nonatomic) UITextField * currentTextField;

@property (strong, nonatomic) UIButton * imageButton;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIToolbar * topView;
@property (strong,nonatomic) UIView *commitView;
@property (nonatomic)CGFloat contentSizeHeight;
@property (nonatomic) BOOL bo;
@property (strong,nonatomic) HNPaySupport *payModel;

@property (strong,nonatomic) NSIndexPath* selectIndex;
@end

@implementation HNOfficePassesApplyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.temporaryModel = [[HNPassData alloc]init];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"Pass Apply", nil);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    HNPassProposerData *Proposer = [[HNPassProposerData alloc]init];
    [self.temporaryModel.proposerItems addObject:Proposer];
 

    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =self;
    self.imagePicker.sourceType = sourceType;
    self.imagePicker.allowsEditing = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.frame = self.view.bounds;
    if(!self.commitView)
        self.commitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:NSLocalizedString(@"在线支付", nil) forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(checkOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitView addSubview:purchase];
    [self movewButton];
}

-(void)movewButton
{
    CGSize size = self.tableView.contentSize;
    self.commitView.top = size.height;
    [self.tableView addSubview:self.commitView];
    size.height += self.commitView.height;
    self.tableView.contentSize = size;
    self.contentSizeHeight = size.height;
}

- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
//    self.houseInfo.text = model.roomName;
//    self.houseOnwerMobile.text = model.ownerphone;
//    self.houseOnwer.text = model.ownername;
//    [self.houseOnwerMobile sizeToFit];
//    [self.houseOnwer sizeToFit ];
//    self.houseOnwerMobile.right = self.view.width - 14;
//    self.houseOnwer.right = self.houseOnwerMobile.left-5;
    self.temporaryModel.declareId = model.declareId;
    self.payModel = model.payModel;
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableDictionary *sendDic = [[NSMutableDictionary alloc] init];
    [sendDic setObject:self.temporaryModel.declareId forKey:@"declareid"];
    [sendDic setObject:[NSNumber numberWithInteger:(2)]forKey:@"type"];
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.prices.list" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        [self performSelectorOnMainThread:@selector(doLoadingPay:) withObject:data waitUntilDone:YES];
    }];

}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)doLoadingPay:(NSData*)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr){
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSInteger count = [[dic objectForKey:@"total"] integerValue];
        if (0!=count)
        {
            NSArray *dataArr = [dic objectForKey:@"data"];
            [self.temporaryModel.needItems removeAllObjects];
            for (int i=0; i<[dataArr count]; i++) {
                HNPassNeedItem *pay = [[HNPassNeedItem alloc]init];
                NSDictionary *dicData = [dataArr objectAtIndex:i];
                [pay updateData:dicData];
                pay.number = @"0";
                pay.totalMoney = @"¥0.00";
                [self.temporaryModel.needItems addObject:pay];
            }
            [self.tableView reloadData];
            [self movewButton];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    //[lab sizeToFit];
    //lab.font = [UIFont systemFontOfSize:12];
    //lab.numberOfLines = 2;
    //lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame =self.view.bounds;
}

- (IBAction)addNewClick:(id)sender
{
    HNPassProposerData* data = [[HNPassProposerData alloc]init];
    [self.temporaryModel.proposerItems addObject:data];
    [self.tableView reloadData];
    [self movewButton];
}

- (IBAction)checkOut:(id)sender
{
    if (self.currentTextField) {
        [self.currentTextField resignFirstResponder];
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithTemporaryModel] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.pass.list" Params:jsonStr]];
    
    NSData *jsonBody = [[self bodyWithModel] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonBody];
    NSString *postLength = [NSString stringWithFormat:@"%ld",[jsonBody length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didCheckOut:) withObject:data waitUntilDone:YES];
        
    }];
}

-(void)didCheckOut:(NSData*)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"从服务器获取数据失败", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
            return;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber *total = [dic objectForKey:@"total"];
        if (total.intValue)
        {
            NSArray *array = [dic objectForKey:@"data"];
            NSDictionary *dicArray = [array objectAtIndex:0];
            NSNumber *cardId = [dicArray objectForKey:@"cardId"];
            [self.choiceDecorateView getPayToken:[NSString stringWithFormat:@"%ld",cardId.integerValue]];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didGetPayToken:(NSString*)token
{
    NSLog(@"%@",token);
    NSURL *url = [[NSURL alloc]initWithString:token];
    [[UIApplication sharedApplication]openURL:url];
    [self.navigationController popViewControllerAnimated:YES];
    //[self showPurchased];
}

- (NSDictionary *)encodeWithTemporaryModel{
    
//    headcount	Y	施工总人数
//    declareId	Y	报建编号
//    proposerId	Y	申请用户userid
//    proposer	Y	申请人员信息JSON（realname：姓名，idcard：身份证号，phone：联系电话，idcardImg：身份证照片，icon：头像）
//    needItem	Y	缴费项json([{name:名称,price:价格,useUnit:单位,number:数量,IsSubmit:是否必缴,Isrefund:是否可退,totalMoney:总金额,sort:排序},{...}]
//

    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.temporaryModel.declareId,@"declareId", [NSString stringWithFormat:@"%ld",(unsigned long)[self.temporaryModel.proposerItems count]],@"headcount",[HNLoginData shared].uid,@"proposerId",nil];//self.temporaryModel.declareId,@"totalcost"
    NSLog(@"%@",[dic JSONString]);
    
    return dic;
}


- (NSString *)bodyWithModel
{
    /*
     proposer		申请人员信息json[{realname:姓名,idcard:身份证号,phone:联系电话,idcardImg:身份证照片,icon:头像},{...}]）
     needItem		缴费项json([{name:名称,price:价格,useUnit:单位,number:数量,IsSubmit:是否必缴,Isrefund:是否可退,totalMoney:总金额,sort:排序},{...}]
     */
    
    NSArray *array = [[NSArray alloc]init];
    NSMutableArray *jsonArray = [[NSMutableArray alloc]init];//创建最外层的数组
    for (int i=0; i<[self.temporaryModel.proposerItems count]; i++) {
        HNPassProposerData *tModel = [self.temporaryModel.proposerItems objectAtIndex:i];
        
        NSDictionary *dic = [[NSMutableDictionary alloc]init];//创建内层的字典
        //申请人员信息JSON（realname：姓名，idcard：身份证号，phone：联系电话，idcardImg：身份证照片，icon：头像）
        if (!tModel.name) {
            tModel.name = @"";
        }
        if (!tModel.IDcard) {
            tModel.IDcard = @"";
        }
        if (!tModel.phone) {
            tModel.phone = @"";
        }
        if (!tModel.IDcardImg) {
            tModel.IDcardImg = @"";
        }
        if (!tModel.Icon) {
            tModel.Icon = @"";
        }
        [dic setValue:tModel.name forKey:@"realname"];
        [dic setValue:tModel.IDcard forKey:@"idcard"];
        [dic setValue:tModel.phone forKey:@"phone"];
        [dic setValue:tModel.IDcardImg forKey:@"idcardImg"];
        [dic setValue:tModel.Icon forKey:@"icon"];
        [jsonArray addObject:dic];
    }
    array = [NSArray arrayWithArray:jsonArray];
    
    NSArray *array2 = [[NSArray alloc]init];
    NSMutableArray *jsonArray2 = [[NSMutableArray alloc]init];//创建最外层的数组
    for (int i=0; i<[self.temporaryModel.needItems count]; i++) {
        HNPassNeedItem *tModel = [self.temporaryModel.needItems objectAtIndex:i];
        
        NSDictionary *dic = [[NSMutableDictionary alloc]init];//创建内层的字典
        //（name：缴费项名称，price:缴费金额，numer：数量，totalMoney：总金额，useUnit：单位）"
        [dic setValue:tModel.name forKey:@"name"];
        [dic setValue:[NSNumber numberWithFloat:tModel.price.floatValue]  forKey:@"price"];
        [dic setValue:[NSNumber numberWithInteger:tModel.number.integerValue] forKey:@"number"];
        [dic setValue:tModel.useUnit forKey:@"useUnit"];
        [dic setValue:tModel.IsSubmit forKey:@"IsSubmit"];
        //[dic setValue:tModel.Isrefund forKey:@"Isrefund"];
        [jsonArray2 addObject:dic];
    }
    array2 = [NSArray arrayWithArray:jsonArray2];
    
    NSString *strBody = [NSString stringWithFormat:@"proposer=%@&needItem=%@",[array JSONString],[array2 JSONString]];
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[array JSONString],@"proposer",[array2 JSONString],@"needItem",nil];
    NSLog(@"%@",strBody);//[dic JSONString]);
    
    return strBody;//dic;
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //if(alertView.tag==1)
//        //self.temporaryModel.status = TemporaryStatusApplying;
//        [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3+[self.temporaryModel.proposerItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    else if (section<[self.temporaryModel.proposerItems count]+1) {
        return 1;
    }
    else if (section==1+[self.temporaryModel.proposerItems count]) {
        return 0;
    }
    else if (section==2+[self.temporaryModel.proposerItems count]) {
        return [self.temporaryModel.needItems count];
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    if (section==0 || section>= 1+[self.temporaryModel.proposerItems count])
    {
        [HNUIStyleSet UIStyleSetRoundView:contentView];
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    if (section==0) {
        if(!self.choiceDecorateView)
        {
            self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 30)];
            self.choiceDecorateView.delegate = self;
            self.choiceDecorateView.left = 5;
            self.choiceDecorateView.centerY = contentView.height / 2;
            self.choiceDecorateView.updataDecorateInformation = YES;
            self.choiceDecorateView.payType = KHNPayTypePass;
            
        }
        [contentView addSubview:self.choiceDecorateView];
    }
    else if (section==1+[self.temporaryModel.proposerItems count]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.width = contentView.width -10;
        btn.height = contentView.height -5;
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.left = 5;
        btn.centerY = contentView.height / 2;
        [contentView addSubview:btn];
        [btn setImage:[UIImage imageNamed:@"+号_24"] forState:UIControlStateNormal];
        [btn setTitle:NSLocalizedString(@"新增施工人员", nil) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addNewClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont systemFontOfSize:15];
        label.width = contentView.width -10;
        label.height = contentView.height -5;
        label.numberOfLines = 2;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.left = 5;
        label.centerY = contentView.height / 2;
        [contentView addSubview:label];
        if (section<[self.temporaryModel.proposerItems count]+1) {
            label.text = NSLocalizedString(@"施工人员信息", nil);
        }
        
        else if (section==2+[self.temporaryModel.proposerItems count]) {
            label.text = NSLocalizedString(@"缴费项目", nil);
        }
    }
    [view addSubview:contentView];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<[self.temporaryModel.proposerItems count]+2)
    {
        return 145;
    }
    if (indexPath.section==[self.temporaryModel.proposerItems count]+2) {
        return 60;
    }
    return 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section<[self.temporaryModel.proposerItems count]+1)
    {
        static NSString *identy = @"newPersonCell";
        HNPersonNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[HNPersonNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        }
        HNPassProposerData *peroposer = (HNPassProposerData *)[self.temporaryModel.proposerItems objectAtIndex:(indexPath.section -1)];
        cell.nameTextField.delegate = self;
        cell.nameTextField.text = peroposer.name;
        cell.nameTextField.tag = (indexPath.section-1)*10+1;
        cell.phoneTextField.delegate = self;
        cell.phoneTextField.text = peroposer.phone;
        cell.phoneTextField.tag = (indexPath.section-1)*10+2;
        cell.cardNOTextField.delegate = self;
        cell.cardNOTextField.text = peroposer.IDcard;
        cell.cardNOTextField.tag = (indexPath.section-1)*10+3;
        [cell.iconPhoto addTarget:self action:@selector(imageUploadClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cardPhoto addTarget:self action:@selector(imageUploadClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.iconPhoto.tag = (indexPath.section-1)*10+4;
        cell.cardPhoto.tag = (indexPath.section-1)*10+5;
        [cell reSetPohoto];
        if (peroposer.imageIcon) {
            [cell.iconPhoto setImage:peroposer.imageIcon forState:UIControlStateNormal];
        }
        if (peroposer.imageIDcard) {
            [cell.cardPhoto setImage:peroposer.imageIDcard forState:UIControlStateNormal];
        }
        return cell;
    }
    if (indexPath.section == [self.temporaryModel.proposerItems count]+2) {
        static NSString *identy = @"purchaseIdenty";
        HNNeedPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        HNPassNeedItem *neddItem = [self.temporaryModel.needItems objectAtIndex:indexPath.row];
        if (!cell){
            cell = [[HNNeedPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            //[cell.checkButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
        }
        {
            //        cell.textLabel.text = [self.mustPay[indexPath.row] title];
            cell.detail.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
            cell.checkButton.hidden = YES;
        }
        
        cell.checkButton.tag = indexPath.row;
        cell.title.text = neddItem.name;
        cell.price.text = neddItem.totalMoney;
        cell.detail.text = [NSString stringWithFormat:@"单价%@   数量%@%@",neddItem.price,neddItem.number,neddItem.useUnit];
        return cell;
    }
    static NSString *identy = @"DefaultApplyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == [self.temporaryModel.proposerItems count]+2)
    {
        HNPassNeedItem *neddItem = [self.temporaryModel.needItems objectAtIndex:indexPath.row];
        self.selectIndex = indexPath;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"请输入数量", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *tf=[alert textFieldAtIndex:0];
        tf.text = [NSString stringWithFormat:@"%@",neddItem.number];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 123){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    UITextField *tf=[alertView textFieldAtIndex:0];
    if (1==buttonIndex){
        HNPassNeedItem *neddItem = [self.temporaryModel.needItems objectAtIndex:self.selectIndex.row];
        HNNeedPayTableViewCell *cell = (HNNeedPayTableViewCell *)[self.tableView cellForRowAtIndexPath:self.selectIndex];
        neddItem.number = [NSString stringWithFormat:@"%ld", tf.text.integerValue];
        neddItem.totalMoney = [NSString stringWithFormat:@"¥%.2f",neddItem.number.integerValue*1.00*neddItem.price.floatValue];
        cell.price.text = neddItem.totalMoney;
        cell.detail.text = [NSString stringWithFormat:@"单价%@   数量%@%@",neddItem.price,neddItem.number,neddItem.useUnit];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 7.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                /*} else if (indexPath.row == 0) {
                 CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                 CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                 addLine = YES;*/
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
            
        }
    }
}


 #pragma mark - UIImagePickerControllerDelegate

- (void)imageUploadClick:(id)sender
{
    self.imageButton = sender;
    
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];

}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        
        self.imagePicker.sourceType = sourceType;
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    CGFloat scaleSize = 0.1f;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"上传中", nil);
    [HNUploadImage UploadImage:scaledImage block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (msg) {
            [self.imageButton setImage:image forState:UIControlStateNormal];
            
            NSInteger section = self.imageButton.tag/10;
            HNPassProposerData *data = [self.temporaryModel.proposerItems objectAtIndex:section];
            NSInteger row = self.imageButton.tag%10;
            switch (row) {
                case 4:
                {
                    data.imageIcon = image;
                    data.Icon = msg;
                }
                    break;
                case 5:
                {
                    data.imageIDcard = image;
                    data.IDcardImg = msg;
                }
                    
                default:
                    break;
            }

        }
    }];
    
}

 #pragma mark textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    self.bo = true;
    NSLog(@"textFieldShouldBeginEditing");
    self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width,self.contentSizeHeight+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.tableView];//把当前的textField的坐标映射到scrollview上
    if(self.tableView.contentOffset.y-pt.y<=0)//判断最上面不要去滚动
        [self.tableView setContentOffset:CGPointMake(0, pt.y) animated:YES];//华东
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    self.currentTextField = textField;
    self.bo = false;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentTextField = nil;
    NSInteger section = textField.tag/10;
    HNPassProposerData *data = [self.temporaryModel.proposerItems objectAtIndex:section];
    NSInteger row = textField.tag%10;
    switch (row) {
        case 1:
        {
            data.name = textField.text;
        }
            break;
        case 2:
        {
            data.phone = textField.text;
        }
            break;
        case 3:
        {
            data.IDcard = textField.text;
        }
            break;
            
        default:
            break;
    }
    if (!self.bo) {
        //开始动画
        [UIView animateWithDuration:0.30f animations:^{
            self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width, self.contentSizeHeight);
        }];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

-(void)showPurchased{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"完成", nil) message:NSLocalizedString(@"请至网页端完成支付", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"完成", nil) otherButtonTitles:NSLocalizedString(@"支付遇到问题", nil), nil];
    alert.tag = 123;
    [alert show];
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
