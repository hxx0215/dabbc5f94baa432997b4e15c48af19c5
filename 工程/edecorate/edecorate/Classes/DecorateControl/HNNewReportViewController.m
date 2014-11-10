//
//  HNNewReportViewController.m
//  edecorate
//
//  Created by hxx on 11/10/14.
//
//

#import "HNNewReportViewController.h"
#import "HNLoginData.h"

@interface HNSeprateView : UIView
@property (nonatomic, weak) UIView *hiddenWith;
@end

@implementation HNSeprateView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
    self.hiddenWith.hidden = YES;
}

@end
@interface HNNewReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSArray *userTitle;
@property (nonatomic, strong) NSArray *companyData;
@property (nonatomic, strong) NSArray *personalData;
@property (nonatomic, strong) NSArray *graphData;
@property (nonatomic, strong) NSArray *housePic;
@property (nonatomic, strong) NSArray *headerTitle;
@property (nonatomic, strong) UIPickerView *listPick;
@property (nonatomic, strong) NSMutableArray *userList;
@property (nonatomic, strong) UIButton *userButton;
@property (nonatomic, strong) HNSeprateView *sepView;
@end

@implementation HNNewReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.userTitle = @[NSLocalizedString(@"身份证号: ", nil),NSLocalizedString(@"手机号: ", nil),NSLocalizedString(@"施工总人数: ", nil),NSLocalizedString(@"开始时间: ", nil),NSLocalizedString(@"结束时间: ", nil)];
    self.companyData = @[NSLocalizedString(@"营业执照", nil),NSLocalizedString(@"税务登记证",nil),NSLocalizedString(@"组织代码登记证",nil),NSLocalizedString(@"资质证书", nil),NSLocalizedString(@"电工证", nil),NSLocalizedString(@"法人委托书",nil),NSLocalizedString(@"法人身份证", nil),NSLocalizedString(@"装修施工合同图证",nil),NSLocalizedString(@"施工负责人身份",nil)];
    self.personalData = @[NSLocalizedString(@"房屋地址:", nil),NSLocalizedString(@"业主姓名:",nil),NSLocalizedString(@"手机号:",nil)];
    self.graphData = @[NSLocalizedString(@"原始结构图", nil),NSLocalizedString(@"平面布置图",nil),NSLocalizedString(@"墙体改造图",nil),NSLocalizedString(@"天花布置图", nil),NSLocalizedString(@"水路布置图", nil),NSLocalizedString(@"电路分布图",nil)];
    if (self.constructType == 1)
        self.headerTitle = @[@"",NSLocalizedString(@"承包方式: ", nil),NSLocalizedString(@"装修公司资料", nil),NSLocalizedString(@"业主及图纸资料", nil),NSLocalizedString(@"业主房屋实景图", nil)];
    else
        self.headerTitle = @[@"",NSLocalizedString(@"承包方式: ", nil),NSLocalizedString(@"业主及图纸资料", nil),NSLocalizedString(@"业主房屋实景图", nil)];
    NSMutableArray *personal = [NSMutableArray new];
    [personal addObjectsFromArray:self.personalData];
    [personal addObjectsFromArray:self.graphData];
    
    self.housePic = @[NSLocalizedString(@"1、厨房结构", nil),NSLocalizedString(@"2、洗手间结构", nil),NSLocalizedString(@"3、房间结构", nil),NSLocalizedString(@"4、燃气管道位置", nil),NSLocalizedString(@"5、强弱电箱位置", nil),NSLocalizedString(@"6、主入水管位置", nil)];
    self.tableData = [[NSMutableArray alloc] init];
    [self.tableData addObject:self.userTitle];
    [self.tableData addObject:[NSArray new]];
    if (self.constructType == 1)
        [self.tableData addObject:self.companyData];
    [self.tableData addObject:personal];
    [self.tableData addObject:self.housePic];
    
    [self initPickView];
}
- (void)initPickView{
    self.listPick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.height - 216, self.view.width, 216)];
    self.sepView = [[HNSeprateView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 216)];
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
    self.userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userButton addTarget:self action:@selector(showPick:) forControlEvents:UIControlEventTouchUpInside];
    self.userList = [[NSMutableArray alloc] init];
}
- (void)loadUserList{
    NSDictionary *dic = @{@"mshopid": [HNLoginData shared].mshopid};
    NSString *sendJson = [dic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.user.list" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count != 0){
                self.userList = [retDic objectForKey:@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.userButton setTitle:[self.userList[0] objectForKey:@"realname"] forState:UIControlStateNormal];
                    [self.listPick reloadAllComponents];
                });
            }
            else{
                [self showNoData];
            }
        }else{
            [self showNoNetwork];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self.tableView reloadData];
    self.listPick.bottom = self.view.height;
    self.sepView.top = 0;
    self.sepView.height = self.view.height - self.listPick.height;
    [self loadUserList];
}
#pragma mark - UITableViewDelegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.tableData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"NewReportCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.textLabel.text = self.tableData[indexPath.section][indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    if ([self.tableData[section] count]==0)
        maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    [view addSubview:contentView];
    UILabel *label = [[UILabel alloc] init];
    label.text = self.headerTitle[section];
    if (section == 0){
        self.userButton.frame = contentView.bounds;
        self.userButton.layer.cornerRadius = 7.0;
        [contentView addSubview:self.userButton];
        return view;
    }
    else if (section ==1){
        label.text = [NSString stringWithFormat:@"%@%@",label.text,self.constructType == 1 ?  NSLocalizedString(@"公司承包", nil):NSLocalizedString(@"业主自装", nil)];
    }
    [label sizeToFit];
    label.textColor = [UIColor whiteColor];
    label.left = 5;
    label.centerY = contentView.height / 2;
    [contentView addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
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

#pragma mark - UIPickerView Delegate && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.userList count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.userList[row] objectForKey:@"realname"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.userButton setTitle:[self.userList[row] objectForKey:@"realname"] forState:UIControlStateNormal];
    pickerView.hidden = YES;
    self.sepView.hidden = YES;
}
- (void)showPick:(id)sender{
    [self.listPick reloadAllComponents];
    self.listPick.hidden = NO;
    self.sepView.hidden = NO;
}
#pragma mark - network
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
@end

