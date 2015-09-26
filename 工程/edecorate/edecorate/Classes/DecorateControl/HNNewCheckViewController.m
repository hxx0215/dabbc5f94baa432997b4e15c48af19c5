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
#import "HNNewCheckTableViewCell.h"
#import "HNUploadImage.h"
#import "MBProgressHUD.h"
#import "HNSelectChargeTableViewController.h"
#import "HNDecorateChoiceView.h"

@interface HNSeprateCheckView : UIView
@property (nonatomic, weak) UIView *hiddenWith;
@property (nonatomic, weak) UIView *hiddenWith2;
@end

@implementation HNSeprateCheckView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
    self.hiddenWith.hidden = YES;
    self.hiddenWith2.hidden = YES;
}
@end
@interface HNNewCheckViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,HNSelectChargeTableViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate,HNDecorateChoiceViewDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *curStatusCell;
@property (weak, nonatomic) IBOutlet UIImageView *step1;
@property (weak, nonatomic) IBOutlet UIImageView *step2;
@property (weak, nonatomic) IBOutlet UIImageView *step3;
@property (weak, nonatomic) IBOutlet UIImageView *step4;
@property (weak, nonatomic) IBOutlet UIButton *stepprocess1;
@property (weak, nonatomic) IBOutlet UIButton *stepprocess2;
@property (weak, nonatomic) IBOutlet UIButton *stepprocess3;
@property (weak, nonatomic) IBOutlet UILabel *steplabel1;
@property (weak, nonatomic) IBOutlet UILabel *steplabel2;
@property (weak, nonatomic) IBOutlet UILabel *steplabel3;
@property (weak, nonatomic) IBOutlet UILabel *steplabel4;
@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, strong) NSArray *stepprocesses;
@property (nonatomic, strong) NSArray *steplabels;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *curData;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSString *curDeclareId;
@property (nonatomic, strong) NSIndexPath *curIndexPath;
@property (nonatomic, strong) NSMutableArray *pickViewData;
@property (nonatomic, assign) NSInteger curPickViewIndex;
@property (nonatomic, assign) BOOL firstIn;
@property (nonatomic, strong) UIPickerView *listPick;
@property (nonatomic, strong) HNSeprateCheckView *sepView;
@property (nonatomic, strong) UIButton *showPick;
@property (nonatomic, strong) HNDecorateChoiceView *decorateChoiceView;
@property (nonatomic, strong) NSMutableDictionary *imageSet;
@property (strong, nonatomic) NSMutableDictionary *curImageIndex;
@property (nonatomic, strong) NSMutableDictionary *imgUrl;

@property (nonatomic, strong) NSMutableDictionary *sendData;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIView *submitView;
@end

@implementation HNNewCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.pickViewData = [[NSMutableArray alloc] init];
    self.dataArr = [[NSMutableArray alloc] init];
    self.imageSet = [[NSMutableDictionary alloc] init];
    self.imgUrl = [NSMutableDictionary new];
    self.curImageIndex = [[NSMutableDictionary alloc] init];
    self.items = [NSMutableArray new];
    self.curData = [NSMutableDictionary new];
    self.firstIn = YES;
    [self initPickView];
    [self loadList];
    [self initButtonView];
    self.title = @"新建装修验收";
    self.steps = @[self.step1,self.step2,self.step3,self.step4];
    self.stepprocesses = @[self.stepprocess1,self.stepprocess2,self.stepprocess3];
    self.steplabels = @[self.steplabel1,self.steplabel2,self.steplabel3,self.steplabel4];
}
- (void)initSendData{
    self.sendData = [NSMutableDictionary new];
    [self.sendData setObject:@"" forKey:@"declareid"];
    [self.sendData setObject:@"" forKey:@"processtep"];
    [self.sendData setObject:@"" forKey:@"shopreason"];
    [self.sendData setObject:@"" forKey:@"shopaccessory"];
}
- (void)initPickView{
    self.listPick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.height - 216, self.view.width, 216)];
    self.sepView = [[HNSeprateCheckView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 216)];
    self.sepView.backgroundColor = [UIColor clearColor];
    self.listPick.backgroundColor = [UIColor whiteColor];
    self.listPick.showsSelectionIndicator = YES;
    self.listPick.hidden = YES;
    self.listPick.delegate = self;
    self.listPick.dataSource = self;
    self.sepView.hidden = YES;
    self.sepView.hiddenWith = self.listPick;
    [self.view addSubview:self.listPick];
    [self.view addSubview:self.sepView];
    self.showPick = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.showPick addTarget:self action:@selector(showPick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)loadList{
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0 != count){
                [self.pickViewData removeAllObjects];
                self.curData = retDic[@"data"][0];
                for (int i=0;i<count;i++){
                    int processstep = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"processstep"] integerValue];
                    if (processstep != 0)
                    {
                        [self.pickViewData addObject:[[retDic objectForKey:@"data"] objectAtIndex:i]];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.showPick setTitle:[self.pickViewData[0] objectForKey:@"roomnumber"] forState:UIControlStateNormal];
                    self.curPickViewIndex = 0;
                    [self loadTableData:[self.pickViewData[0] objectForKey:@"declareId"]];
                });
            }
        }
    }];
    
}
- (void)loadTableData:(NSString *)declareId{
    if (!declareId || [declareId isEqualToString:@""])
        return ;
    self.curDeclareId = declareId;
    [self.imageSet removeAllObjects];
    [self.curImageIndex removeAllObjects];
    [self.imgUrl removeAllObjects];
    NSDictionary *sendDic = @{@"mshopid": [HNLoginData shared].mshopid,@"declareid" : declareId};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.acceptance.details" Params:sendJson]];
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
            if (0 != count){
                [self.dataArr removeAllObjects];
                for (int i = 0;i<count;i++)
                    [self.dataArr addObject:[[retDic objectForKey:@"data"] objectAtIndex:i]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self reloadTable];
                });
            }
            else
                [self showNoData];
        }else
            [self showNoNet];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    self.listPick.bottom = self.view.height;
    self.sepView.top = 0;
    self.sepView.height = self.view.height - self.listPick.height;
    if (self.firstIn){
        if ([self.pickViewData count]>0){
            self.curPickViewIndex = 0;
            [self.showPick setTitle:[self.pickViewData[0] objectForKey:@"roomnumber"] forState:UIControlStateNormal];
            [self loadTableData:[self.pickViewData[0] objectForKey:@"declareId"]];
        }
    }
    else{
        [self reloadTable];
    }
}
- (void)reloadTable{
    [self.tableView reloadData];
    [self.tableView setNeedsLayout];
    CGSize size = self.tableView.contentSize;
    self.submitView.top = size.height;
    size.height += 88;
    self.tableView.contentSize = size;
}
- (void)initButtonView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:NSLocalizedString(@"提交申请", nil) forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(submitData:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:purchase];
    self.submitView = view;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.firstIn)
        return ;
    self.firstIn = NO;
//    CGSize size = self.tableView.contentSize;
//    self.submitView.top = size.height;
    [self.tableView addSubview:self.submitView];

    
//    self.tableView.contentSize = size;
}
- (void)showNoNet{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}

- (void)showNoData{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    });
    
//    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    if ([self.pickViewData count]<1)
        return view;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    if (section==0 || (section > 1 &&[ self.dataArr[section - 2] count]==0))
        maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    [view addSubview:contentView];
    UILabel *label = [[UILabel alloc] init];
    if (section == 0)
    {
//        label.text = [self.pickViewData[self.curPickViewIndex] objectForKey:@"roomnumber"];
        if(!self.decorateChoiceView)
        {
            self.decorateChoiceView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 30)];
            self.decorateChoiceView.delegate = self;
            self.decorateChoiceView.left = 5;
            self.decorateChoiceView.centerY = contentView.height / 2;
            self.decorateChoiceView.updataDecorateInformation = NO;
            self.decorateChoiceView.payType = KHNPayTypeNo;
            
        }
        [contentView addSubview:self.decorateChoiceView];
        //self.showPick.frame = contentView.bounds;
        //self.showPick.layer.cornerRadius = 7.0;
        //[contentView addSubview:self.showPick];
        return view;
    }
    else
    if (section == 1)
        label.text = NSLocalizedString(@"装修验收", nil);
    else
        label.text = [self.dataArr[section - 2] objectForKey:@"typename"];
    [label sizeToFit];
    label.textColor = [UIColor whiteColor];
    label.left = 5;
    label.centerY = contentView.height / 2;
    [contentView addSubview:label];
    return view;
}

- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
    [self loadTableData:model.declareId];
    self.curData = [model.alldata mutableCopy];
    //NSLog(@"%@ : %@",roomNumber,declareId);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.pickViewData count]<1) return 0;
    return [self.dataArr count] + 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    if (section == 1)
        return 2;
    return [[self.dataArr[section - 2] objectForKey:@"ItemBody"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return 116;
    NSIndexPath *key = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    if ([self.imageSet objectForKey:key] &&([[self.imageSet objectForKey:key] respondsToSelector:@selector(count)] &&[[self.imageSet objectForKey:key] count]>0))
        return 84;
    else
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        NSInteger step = [self.curData[@"processstep"] integerValue];
        step--;
        for (int i=0;i<4;i++){
            UIImageView *imgView = self.steps[i];
            UILabel *label = self.steplabels[i];
            if (i<=step){
                imgView.highlighted = NO;
                label.textColor = [UIColor colorWithRed:60.0/255.0 green:173.0/255.0 blue:230.0/255.0 alpha:1.0];
            }
            else{
                imgView.highlighted = YES;
                label.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
            }
            if (i==3)
                break ;
            UIButton *button = self.stepprocesses[i];
            if (i<step - 1)
            {
                button.enabled = YES;
                [button setImage:[UIImage imageNamed:@"ic_step_done.png"] forState:UIControlStateNormal];
            }
            else if (i== step - 1){
                button.enabled = YES;
                [button setImage:[UIImage imageNamed:@"ic_step_processing.png"] forState:UIControlStateNormal];
            }else{
                button.enabled = NO;
                [button setImage:[UIImage imageNamed:@"ic_step_failed.png"] forState:UIControlStateNormal];
            }
        }
//        self.curStatusLabel.text = [NSString stringWithFormat:@"当前状态:%@",dic[self.curData[@"processstep"]]];
//        [self.curStatusLabel sizeToFit];
        return self.curStatusCell;
    }
    static NSString *identify = @"newCheckCell";
    HNNewCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNNewCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.contentView.tag = indexPath.section * 100 + indexPath.row;
    if (indexPath.section > 1)
    {
        cell.name.text = [[self.dataArr[indexPath.section - 2] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodyname"];
        cell.type = [[self.dataArr[indexPath.section - 2] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodytype"];
        cell.itemId =[self.dataArr[indexPath.section - 2] objectForKey:@"itemId"];
    }
    else{
        if (indexPath.row == 0){
            cell.name.text = NSLocalizedString(@"施工方备注", nil);
            cell.type = @"1";
            
        }
        else{
            cell.name.text = NSLocalizedString(@"施工方附件", nil);
            cell.type = @"2";
        }
    }
    if ([cell.type isEqualToString:@"2"])
    {
        cell.upload.tag = indexPath.section * 100 + indexPath.row;
        [cell.upload addTarget:self action:@selector(uploadImg:) forControlEvents:UIControlEventTouchUpInside];
        [cell.del addTarget:self action:@selector(delImg:) forControlEvents:UIControlEventTouchUpInside];
        [cell.leftImg addTarget:self action:@selector(leftImg:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightImg addTarget:self action:@selector(rightImg:) forControlEvents:UIControlEventTouchUpInside];
        [cell.showPic addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableArray *imgArr = [self.imageSet objectForKey:indexPath];
        if (imgArr && [imgArr count]>0)
        {
            cell.del.hidden = NO;
            cell.curImageView.hidden = NO;
            NSInteger index = [self.curImageIndex[indexPath] integerValue];
            cell.curImageView.image = imgArr[index];
            cell.leftImg.hidden = ([imgArr count]==1);
            cell.rightImg.hidden = ([imgArr count]==1);
        }
        else{
            cell.del.hidden = YES;
            cell.curImageView.hidden = YES;
            cell.leftImg.hidden = YES;
            cell.rightImg.hidden = YES;
        }
    }
    else{
        cell.textField.delegate = self;
        cell.textField.text = self.imageSet[indexPath];
    }
    return cell;
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
- (void)submitData:(id)sender{
    if ([self.dataArr count]<1)
        return;
    NSMutableDictionary *sendDic = [@{@"declareid": self.curDeclareId, @"processtep" : [self.curData objectForKey:@"processstep"]} mutableCopy];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSString *shopreason = self.imageSet[indexPath] ? self.imageSet[indexPath] : @"";
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSString *shopaccessory = [self connectArr:self.imgUrl[indexPath]];
    [sendDic setObject:shopreason ? shopreason : @"" forKey:@"shopreason"];
    [sendDic setObject:shopaccessory ? shopaccessory : @"" forKey:@"shopaccessory"];
    for (int i=0;i< [self.dataArr count];i++){
        for (int j = 0;j< [[self.dataArr[i] objectForKey:@"ItemBody"] count];j++){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[self.dataArr[i] objectForKey:@"itemId"] forKey:@"itemid"];
            [dic setObject:[[self.dataArr[i] objectForKey:@"ItemBody"][j] objectForKey:@"bodyname"] forKey:@"name"];
            [dic setObject:[[self.dataArr[i] objectForKey:@"ItemBody"][j] objectForKey:@"bodytype"] forKey:@"type"];
//            [dic setObject:@"/Picture/201409/041700468686.jpg" forKey:@"img"];
            indexPath = [NSIndexPath indexPathForRow:j inSection:i+2];
            id temp = self.imageSet[indexPath];
            if ([temp isKindOfClass:[NSString class]]){
                [dic setObject:temp forKey:@"img"];
            }
            else
            {
                NSString *str = [self connectArr:self.imgUrl[indexPath]];
                [dic setObject:str ? str:@"" forKey:@"img"];
            }
            [arr addObject:dic];
        }
    }
//    [sendDic setObject:[arr JSONString] forKey:@"ItemBody"];
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.acceptance.details" Params:sendJson]];
    NSString *bodyJson = [NSString stringWithFormat:@"ItemBody=%@",[arr JSONString]];
    NSData *bodyData = [bodyJson dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    NSString *postLength = [NSString stringWithFormat:@"%d",[bodyData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr)
        {
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSDictionary *retDic = [retJson objectFromJSONString];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:retDic[@"data"][0][@"msg"] delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
            [alert show];
        });
    }];
}

- (NSString *)connectArr:(NSArray *)arr{
    NSMutableString *ret = [NSMutableString new];
    if ([arr count]==1)
        return arr[0];
    else
        ret = [arr[0] mutableCopy];
    for (int i=1;i<[arr count];i++)
        [ret appendFormat:@",%@",arr[i]];
    return ret;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UIPickerView Delegate && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickViewData count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickViewData[row] objectForKey:@"roomnumber"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.curPickViewIndex = row;
    self.listPick.hidden = YES;
    self.sepView.hidden = YES;
    [self.showPick setTitle:[self.pickViewData[self.curPickViewIndex] objectForKey:@"roomnumber"] forState:UIControlStateNormal];
    [self loadTableData:[self.pickViewData[row] objectForKey:@"declareId"]];
}
#pragma mark - UIImagePickController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSMutableArray *imageArr = [self.imageSet objectForKey:self.curIndexPath];
    NSMutableArray *imageUrlArr = [self.imgUrl objectForKey:self.curIndexPath];
    if (!imageArr)
        imageArr = [[NSMutableArray alloc] init];
    if (!imageUrlArr)
        imageUrlArr = [[NSMutableArray alloc] init];
    [imageArr addObject:image];

    
    [picker dismissViewControllerAnimated:YES completion:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"上传中", nil);
        CGFloat maxWH = 480;
        CGFloat maxImg = MAX(image.size.width, image.size.height);
        CGFloat scale = MIN(1, maxWH / maxImg);
        UIImage *img = [HNUploadImage ScaledImage:image scale:scale];
        [HNUploadImage UploadImage:img block:^(NSString *msg){
            NSLog(@"%@",msg);
            if (!msg){
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                return ;
            }
            [self.imageSet setObject:imageArr forKey:self.curIndexPath];
            [self.curImageIndex setObject:@([imageArr count] - 1) forKey:self.curIndexPath];
            [imageUrlArr addObject:msg];
            [self.imgUrl setObject:imageUrlArr forKey:self.curIndexPath];
            NSLog(@"%@",self.imgUrl);
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.labelText = NSLocalizedString(@"上传成功", nil);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self reloadTable];
            });
        }];
    }];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2)
        return;
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    if (buttonIndex == 1)
        pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    else
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:^{
        
    }];
}
#pragma mark - ButtonActions
- (void)showPick:(UIButton *)sender{
    HNSelectChargeTableViewController *vc = [[HNSelectChargeTableViewController alloc] init];
    vc.chargeDelegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
    return ;
    [self.listPick reloadAllComponents];
    self.listPick.hidden = NO;
    self.sepView.hidden = NO;
}

- (void)uploadImg:(UIButton *)sender{
    NSInteger section = sender.tag / 100;
    NSInteger row = sender.tag % 100;
    self.curIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"选择照片照片获取方式", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"相机", nil),NSLocalizedString(@"相册", nil), nil];
    [sheet showInView:self.view];
    
}
- (void)delImg:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSInteger curImageIndex = [self.curImageIndex[indexPath] integerValue];
    [self.imageSet[indexPath] removeObjectAtIndex:curImageIndex];
    [self.imgUrl[indexPath] removeObjectAtIndex:curImageIndex];
    if (curImageIndex>= [self.imageSet[indexPath] count])
        curImageIndex = MAX(0, [self.imageSet[indexPath] count] - 1);
    if (curImageIndex<0) curImageIndex = 0;
    [self.curImageIndex setObject:@(curImageIndex) forKey:indexPath];
    [self reloadTable];
}
- (void)leftImg:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSInteger curImageIndex = [self.curImageIndex[indexPath] integerValue];
    curImageIndex --;
    if (curImageIndex <0) curImageIndex =0;
    [self.curImageIndex setObject:@(curImageIndex) forKey:indexPath];
    [self reloadTable];
}
- (void)rightImg:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSInteger maxIndex = [self.imageSet[indexPath] count];
    NSInteger curImageIndex = [self.curImageIndex[indexPath] integerValue];
    curImageIndex ++;
    if (curImageIndex > maxIndex - 1) curImageIndex = maxIndex - 1;
    [self.curImageIndex setObject:@(curImageIndex) forKey:indexPath];
    [self reloadTable];
}
- (void)showPic:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSMutableArray *imgArr = [self.imageSet objectForKey:indexPath];
    NSInteger index = [self.curImageIndex[indexPath] integerValue];
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = imgArr[index];
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}
-(void)didSelect:(NSString *)roomNumber declareId:(NSString *)declareId data:(NSDictionary *)alldata{
    [self.showPick setTitle:roomNumber forState:UIControlStateNormal];
    [self loadTableData:declareId];
    self.curData = [alldata mutableCopy];
    NSLog(@"%@ : %@",roomNumber,declareId);
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger section = [textField superview].tag / 100;
    NSInteger row = [textField superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.imageSet setObject:textField.text forKey:indexPath];
    [textField resignFirstResponder];
    return YES;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
