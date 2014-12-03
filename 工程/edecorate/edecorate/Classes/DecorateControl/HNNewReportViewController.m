//
//  HNNewReportViewController.m
//  edecorate
//
//  Created by hxx on 11/10/14.
//
//

#import "HNNewReportViewController.h"
#import "HNLoginData.h"
#import "HNNewReportTableViewCell.h"
#import "MBProgressHUD.h"
#import "HNUploadImage.h"
#import "HNPurchaseItem.h"
#import "HNPurchaseViewController.h"
#import "HNConsturctPicTableViewCell.h"

@interface HNSeprateView : UIView
@property (nonatomic, weak) UIView *hiddenWith;
@property (nonatomic, weak) UIView *hiddenWith2;
@end

@implementation HNSeprateView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
    self.hiddenWith.hidden = YES;
    self.hiddenWith2.hidden = YES;
}

@end
@interface HNNewReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *topView;
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

@property (nonatomic, strong) NSArray *userCellType;
@property (nonatomic, strong) NSArray *companyCellType;
@property (nonatomic, strong) NSArray *personalCellType;
@property (nonatomic, strong) NSMutableArray *tableType;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSIndexPath *curIndexPath;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSString *beginDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSMutableDictionary *userDic;
@property (nonatomic, strong) NSMutableDictionary *picDict;
@property (nonatomic, assign) BOOL userLoaded;
@property (nonatomic, weak) UITextField *curText;

@property (nonatomic, strong) NSMutableDictionary *sendDic;

@property (nonatomic, strong) NSMutableDictionary *imageSet;
@property (nonatomic, strong) NSMutableDictionary *curImageIndex;
@property (nonatomic, strong) NSMutableDictionary *imageUrl;

@property (nonatomic, strong) UIView *buttonView;
@end

@implementation HNNewReportViewController
static NSString *kNewPicCell = @"kNewPicCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userLoaded = NO;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNConsturctPicTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kNewPicCell];
    self.userTitle = @[NSLocalizedString(@"身份证号: ", nil),NSLocalizedString(@"手机号: ", nil),NSLocalizedString(@"施工总人数: ", nil),NSLocalizedString(@"开始时间: ", nil),NSLocalizedString(@"结束时间: ", nil)];
    self.companyData = @[NSLocalizedString(@"营业执照", nil),NSLocalizedString(@"税务登记证",nil),NSLocalizedString(@"组织代码登记证",nil),NSLocalizedString(@"资质证书", nil),NSLocalizedString(@"电工证", nil),NSLocalizedString(@"法人委托书",nil),NSLocalizedString(@"法人身份证", nil),NSLocalizedString(@"装修施工合同图证",nil),NSLocalizedString(@"施工负责人身份",nil)];
    self.personalData = @[[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"房屋地址:", nil),self.roomNumber],[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"业主姓名:",nil),self.ownername],[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"手机号:",nil),self.ownerphone]];
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
    
    self.userCellType = @[@"1",@"1",@"1",@"2",@"2"];
    NSMutableArray *tArr = [[NSMutableArray alloc] init];
    for (id o in self.companyData){
        [tArr addObject:@"0"];
    }
    self.companyCellType = [tArr copy];
    self.personalCellType = @[@"3",@"3",@"3"];
    [tArr removeAllObjects];
    for (id o in self.graphData){
        [tArr addObject:@"0"];
    }
    NSMutableArray *persnalType = [NSMutableArray new];
    [persnalType addObjectsFromArray:self.personalCellType];
    [persnalType addObjectsFromArray:[tArr copy]];
    [tArr removeAllObjects];
    for (id o in self.housePic){
        [tArr addObject:@"0"];
    }
    self.tableType = [NSMutableArray new];
    [self.tableType addObject:self.userCellType];
    [self.tableType addObject:[NSArray new]];
    if (1==self.constructType){
        [self.tableType addObject:self.companyCellType];
    }
    [self.tableType addObject:persnalType];
    [self.tableType addObject:[tArr copy]];
    [self initDateString];
    [self initPickView];
    [self initPicDict];
    [self initTopView];
    self.userDic = [@{@"idcard": @"",@"phone" : @"", @"population" :@"",@"realname":@""} mutableCopy];
    [self initSendDic];
    [self initButtonView];
    self.imageUrl = [NSMutableDictionary new];
    self.imageSet = [NSMutableDictionary new];
    self.curImageIndex = [NSMutableDictionary new];
}
- (void)initSendDic{
    self.sendDic = [@{@"declareid": self.declareId , @"mshopid" : [HNLoginData shared].mshopid,@"principal":@"",@"EnterprisePhone":@"",@"EIDCard":@"",/*@"beginTime":@"",@"endTime": @"",*/@"population":@"",@"headImage":@"",@"OriginalSChart":@"",@"floorplan":@"",@"wallRemould":@"" , @"ceilingPlan":@"",@"WaterwayPlan":@"",@"BlockDiagram":@"",@"businessLicense":@"",@"TaxIMG":@"",@"organizeIMG":@"",@"qualificationIMG":@"" ,@"ElectricianIMG":@"",@"powerAttorney":@"",@"AttorneyIDcard":@"",@"EIDCardIMG":@"",@"compactIMG":@"",@"kitchenIMG":@"",@"WCIMG":@"",@"roomIMG":@"",@"gasLineIMG":@"",@"electricityBoxIMG":@"",@"waterPipeIMG":@"",@"proportion":@"",@"blueprint":@"" }mutableCopy];
}
- (void)initButtonView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize contentSize = self.tableView.contentSize;
    purchase.frame = CGRectMake(10, contentSize.height, self.view.width - 20, 40);
    purchase.layer.cornerRadius = 7.0;
    [view addSubview:purchase];
    [purchase setBackgroundColor:[UIColor projectRed]];
    [purchase setTitle:NSLocalizedString(@"配置缴费项", nil) forState:UIControlStateNormal];
    [purchase addTarget:self action:@selector(purchase:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonView = view;
}
- (void)initDateString{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd EEEE"];
    self.beginDate = [df stringFromDate:[NSDate date]];
    self.endDate = [df stringFromDate:[NSDate date]];
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
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:self.listPick.frame];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];
    self.datePicker.hidden = YES;
    self.sepView.hiddenWith2 = self.datePicker;
    
}
- (void)initPicDict{
    self.picDict = [[NSMutableDictionary alloc] init];
    int offset = 2;
    if (self.constructType == 1)
    {
        offset++;
        for (int i = 0 ;i < [self.companyData count];i++)
        {
            NSString *key = [NSString stringWithFormat:@"%d",i + offset * 1000];
            [self.picDict setObject:[NSNull null] forKey:key];
        }
    }
    offset++;
    for (int i=0; i< [self.graphData count];i ++){
        NSString *key = [NSString stringWithFormat:@"%d", i + 3 + offset * 1000];
        [self.picDict setObject:[NSNull null] forKey:key];
    }
    offset++;
    for (int i = 0;i< [self.housePic count]; i++){
        NSString *key = [NSString stringWithFormat:@"%d", i + offset * 1000];
        [self.picDict setObject:[NSNull null] forKey:key];
    }
    
}
- (void)initTopView{
    self.topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    self.topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(textDone:)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [self.topView setItems:buttonsArray];
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
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count != 0){
                self.userList = [retDic objectForKey:@"data"];
                self.userDic[@"idcard"] = self.userList[0][@"idcard"];
                self.userDic[@"phone"] = self.userList[0][@"phone"];
                self.userDic[@"realname"] = [self.userList[0] objectForKey:@"realname"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.userButton setTitle:[self.userList[0] objectForKey:@"realname"] forState:UIControlStateNormal];
                    [self.listPick reloadAllComponents];
                    [self.tableView reloadData];
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
    self.datePicker.frame= self.listPick.frame;
    if (!self.userLoaded)
    {
        self.userLoaded = YES;
        [self loadUserList];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
#pragma mark - UITableViewDelegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.tableData count] + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == [self.tableData count])
        return 0;
    return [self.tableData[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tableType[indexPath.section][indexPath.row] intValue] == HNNewReportTableViewCellTypeButton)
    {
        NSString *key = [NSString stringWithFormat:@"%d",indexPath.section*100 + indexPath.row];
        if ([self shouldShowAllUI:key])
            return 115;
        else
            return 45;
    }
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"NewReportCell";
    HNNewReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[HNNewReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        [cell.button addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.label.text = self.tableData[indexPath.section][indexPath.row];
    cell.type = [self.tableType[indexPath.section][indexPath.row] intValue];
    if (indexPath.section == 0){
        switch (indexPath.row){
            case 0:
                cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
                cell.textField.text = self.userDic[@"idcard"];
                if (!cell.textField.delegate)
                {
                    cell.textField.delegate = self;
                    cell.textField.tag = 100;
                    cell.textField.inputAccessoryView = self.topView;
                }
                break;
            case 1:
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                cell.textField.text = self.userDic[@"phone"];
                if (!cell.textField.delegate)
                {
                    cell.textField.delegate = self;
                    cell.textField.tag = 101;
                    cell.textField.inputAccessoryView = self.topView;
                }
                break;
            case 2:
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                cell.textField.placeholder = NSLocalizedString(@"请输入施工总人数", nil);
                cell.textField.text = self.userDic[@"population"];
                if (!cell.textField.delegate)
                {
                    cell.textField.delegate = self;
                    cell.textField.tag = 102;
                    cell.textField.inputAccessoryView = self.topView;
                }
                break;
            case 3:
                cell.label.text = [NSString stringWithFormat:@"%@ %@",self.tableData[indexPath.section][indexPath.row],self.beginDate];
                [cell.label sizeToFit];
                break;
            case 4:
                cell.label.text = [NSString stringWithFormat:@"%@ %@",self.tableData[indexPath.section][indexPath.row],self.endDate];
                [cell.label sizeToFit];
                break;
            default:
                break;
        }
    }
    cell.button.tag = (indexPath.section + 1) * 1000 + indexPath.row;
    if (cell.type == HNNewReportTableViewCellTypeButton){
        HNConsturctPicTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:kNewPicCell];
        tCell.contentView.tag = indexPath.section * 100 + indexPath.row;
        tCell.titleText.text = cell.label.text;
        [tCell.titleText sizeToFit];
        tCell.uploadImage.selected = YES;
        tCell.delImage.selected = YES;
        [tCell.uploadImage removeTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.uploadImage addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.delImage removeTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.delImage addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.leftImg removeTarget:self action:@selector(leftImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.leftImg addTarget:self action:@selector(leftImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.rightImg removeTarget:self action:@selector(rightImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.rightImg addTarget:self action:@selector(rightImage:) forControlEvents:UIControlEventTouchUpInside];
        NSString *key = [NSString stringWithFormat:@"%d",tCell.contentView.tag];
        [self shouldHideCellUI:tCell
                          hide:![self shouldShowAllUI:key]];
        NSArray *imageArr = self.imageSet[key];
        if (imageArr && [imageArr count]>0){
            tCell.pic.image = imageArr[[self.curImageIndex[key] integerValue]];
        }
        return tCell;

        if ([self.picDict objectForKey:key] != [NSNull null])
            [cell.button setImage:[self.picDict objectForKey:key] forState:UIControlStateNormal];
        else
            [cell.button setImage:[UIImage imageNamed:@"selectphoto.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}
- (void)shouldHideCellUI:(HNConsturctPicTableViewCell *)cell hide:(BOOL)hide{
    cell.delImage.hidden = hide;
    cell.leftImg.hidden = hide;
    cell.rightImg.hidden = hide;
    cell.pic.hidden = hide;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0==indexPath.section){
        if (3==indexPath.row || 4==indexPath.row){
            self.curIndexPath = indexPath;
            self.datePicker.hidden = NO;
            self.sepView.hidden = NO;
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"YYYY-MM-dd EEEE"];
            if (3==indexPath.row)
                [self.datePicker setDate:[df dateFromString:self.beginDate] animated:YES];
            if (4==indexPath.row)
                [self.datePicker setDate:[df dateFromString:self.endDate] animated:YES];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == [self.tableData count])
        return self.buttonView;
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
    self.userDic[@"idcard"] = self.userList[row][@"idcard"];
    self.userDic[@"phone"] = self.userList[row][@"phone"];
    pickerView.hidden = YES;
    self.sepView.hidden = YES;
    [self.tableView reloadData];
}
- (void)showPick:(id)sender{
    [self.listPick reloadAllComponents];
    self.listPick.hidden = NO;
    self.sepView.hidden = NO;
}
- (void)dateChange:(UIDatePicker *)sender{
    self.selectedDate = sender.date;
    HNNewReportTableViewCell *cell = (HNNewReportTableViewCell *)[self.tableView cellForRowAtIndexPath:self.curIndexPath];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [df setDateFormat:@"YYYY-MM-dd EEEE"];
    cell.label.text = [NSString stringWithFormat:@"%@ %@",self.tableData[self.curIndexPath.section][self.curIndexPath.row],[df stringFromDate:self.selectedDate]];
    if (3== self.curIndexPath.row)
        self.beginDate = [df stringFromDate:self.selectedDate];
    else
        self.endDate = [df stringFromDate:self.selectedDate];
    [cell.label sizeToFit];
    cell.label.left = 20;
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
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%d",textField.tag);
    self.curText = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 100:
            self.userDic[@"idcard"] = textField.text;
            break;
        case 101:
            self.userDic[@"phone"] = textField.text;
            break;
        case 102:
            self.userDic[@"population"] = textField.text;
            break;
        default:
            break;
    }
}
#pragma mark - UIImagePickControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *key = [NSString stringWithFormat:@"%d",picker.view.tag];
    [self.picDict setObject:image forKey:key];
    NSMutableArray *imageArr = self.imageSet[key];
    NSMutableArray *imageUrl = self.imageUrl[key];
    if (!imageArr)
        imageArr = [NSMutableArray new];
    if (!imageUrl)
        imageUrl = [NSMutableArray new];
    [imageArr addObject:image];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"上传中", nil);
        CGFloat maxWH = 480;
        CGFloat maxImg = MAX(image.size.width, image.size.height);
        CGFloat scale = MIN(1, maxWH / maxImg);
        UIImage *img = [HNUploadImage ScaledImage:image scale:scale];
        [HNUploadImage UploadImage:img block:^(NSString *msg){
            [imageUrl addObject:msg];
            [self.imageSet setObject:imageArr forKey:key];
            [self.imageUrl setObject:imageUrl forKey:key];
            [self.curImageIndex setObject:@([imageArr count] - 1) forKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.labelText = NSLocalizedString(@"上传成功", nil);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView reloadData];
            });
        }];
    }];
}
- (void)textDone:(id)sender{
    [self.curText resignFirstResponder];
}
- (void)purchase:(id)sender{
    __block NSString *purchaseType = @"0";
    if (self.constructType == 1)//公司 type:6
        purchaseType = @"6";
    if (self.constructType == 0)
        purchaseType = @"5";
    if ([self.allData[@"Isaddition"] intValue] == 1)
        purchaseType = @"7";
    NSDictionary *sendDic = @{@"declareid": self.declareId,@"type" : purchaseType};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.prices.list" Params:sendJson]];
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
            NSArray *dataArr = [retDic objectForKey:@"data"];
            NSMutableArray *mustPay = [NSMutableArray new];
            NSMutableArray *optionPay = [NSMutableArray new];
            HNPurchaseViewController *vc = [[HNPurchaseViewController alloc] init];
            vc.allData = [dataArr mutableCopy];
            for (int i=0;i<count;i++){
                HNPurchaseItem *item = [HNPurchaseItem new];
                item.title = dataArr[i][@"name"];
                vc.declareid = self.declareId;
                vc.type = [purchaseType intValue];
                if (dataArr[i][@"useUnit"] && ![dataArr[i][@"useUnit"] isEqualToString:@""]){
                    item.single = 1;
                    item.nums = 0;
                    item.unitPrice = [dataArr[i][@"price"] floatValue];
                    item.price = 0;
                }
                else{
                    item.single = 0;
                    item.price = [dataArr[i][@"price"] floatValue];
                }
                if ([dataArr[i][@"IsSubmit"] intValue] == 0)
                {
                    [optionPay addObject:item];
                }
                else
                    [mustPay addObject:item];
            }
            vc.mustPay = mustPay;
            vc.optionPay = optionPay;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:vc animated:YES];
            });
        }
    }];
//    return;
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.sendDic[@"principal"] = self.userDic[@"realname"];
    self.sendDic[@"EnterprisePhone"] = self.userDic[@"phone"];
    self.sendDic[@"EIDCard"] = self.userDic[@"idcard"];
//    self.sendDic[@"beginTime"] = [self.beginDate substringToIndex:10];
//    self.sendDic[@"endTime"] = [self.endDate substringToIndex:10];
    self.sendDic[@"population"] = self.userDic[@"population"];
    sendJson = [self.sendDic JSONString];
    request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.decoraton.declaredetails" Params:sendJson]];
    contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
//            NSLog(@"%@",retDic[@"data"][0][@"msg"]);
        }
        else{
            NSLog(@"%@",connectionError);
        }
    }];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)upload:(UIButton *)sender{
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.view.tag = [sender superview].tag;
    pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:^{
        
    }];
}
- (void)leftImage:(UIButton *)sender{
    NSString *key = [NSString stringWithFormat:@"%d",[sender superview].tag];
    NSInteger curImageIndex = [self.curImageIndex[key] integerValue];
    curImageIndex --;
    if (curImageIndex <0) curImageIndex =0;
    [self.curImageIndex setObject:@(curImageIndex) forKey:key];
    [self.tableView reloadData];
}
- (void)rightImage:(UIButton *)sender{
    NSString *key = [NSString stringWithFormat:@"%d",[sender superview].tag];
    NSInteger maxIndex = [self.imageSet[key] count];
    NSInteger curImageIndex = [self.curImageIndex[key] integerValue];
    curImageIndex ++;
    if (curImageIndex > maxIndex - 1) curImageIndex = maxIndex - 1;
    [self.curImageIndex setObject:@(curImageIndex) forKey:key];
    [self.tableView reloadData];
}
- (void)delImage:(UIButton *)sender{
    NSString *key = [NSString stringWithFormat:@"%d",[sender superview].tag];
    if ([self.imageSet[key] count]<1)
        return ;
    NSInteger curImageIndex = [self.curImageIndex[key] integerValue];
    [self.imageSet[key] removeObjectAtIndex:curImageIndex];
    [self.imageUrl[key] removeObjectAtIndex:curImageIndex];
    if (curImageIndex>= [self.imageSet[key] count])
        curImageIndex = MAX(0, [self.imageSet[key] count] - 1);
    if (curImageIndex<0) curImageIndex = 0;
    [self.curImageIndex setObject:@(curImageIndex) forKey:key];
    [self.tableView reloadData];
}
- (BOOL)shouldShowAllUI:(NSString *)key{
    NSArray *imgarr = self.imageSet[key];
    if (imgarr && [imgarr count]>0)
        return YES;
    else
        return NO;
}
@end

