//
//  HNConstructViewController.m
//  edecorate
//
//  Created by hxx on 10/23/14.
//
//

#import "HNConstructViewController.h"
#import "HNPurchaseViewController.h"
#import "HNPurchaseItem.h"
#import "HNConstructTableViewCell.h"
#import "MBProgressHUD.h"
#import "HNBrowseImageViewController.h"
#import "HNConstructPaymentTableViewCell.h"
#import "HNGetAuthViewController.h"
#import "HNNewReportViewController.h"
#import "HNPaySupport.h"

@interface HNConstructViewController ()<UITableViewDelegate,UITableViewDataSource,HNDecoratePayModelDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *companyData;
@property (nonatomic, strong)NSArray *personalData;
@property (nonatomic, strong)NSArray *graphData;
@property (nonatomic, strong)NSMutableArray *detailTitle;
@property (nonatomic, strong)NSArray *pernalDetail;
@property (nonatomic, strong)NSMutableDictionary *picDict;
@property (nonatomic, strong)NSString *buttonName;
@property (nonatomic, strong)NSString *priceType;
@end

static NSString *kConstructPaymentCell = @"constPaymentCell";
@implementation HNConstructViewController
- (instancetype)init{
    self = [super init];
    if (self){
        self.chart = [[NSMutableDictionary alloc] init];
        self.shopInfo = [[NSMutableDictionary alloc] init];
        self.picDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.companyData = @[NSLocalizedString(@"营业执照", nil),NSLocalizedString(@"税务登记证",nil),NSLocalizedString(@"组织代码登记证",nil),NSLocalizedString(@"资质证书", nil),NSLocalizedString(@"电工证", nil),NSLocalizedString(@"法人委托书",nil),NSLocalizedString(@"法人身份证", nil),NSLocalizedString(@"装修施工合同图证",nil),NSLocalizedString(@"施工负责人身份",nil)];
    self.personalData = @[NSLocalizedString(@"房屋地址:", nil),NSLocalizedString(@"业主姓名:",nil),NSLocalizedString(@"手机号:",nil)];
    self.graphData = @[NSLocalizedString(@"原始结构图", nil),NSLocalizedString(@"平面布置图",nil),NSLocalizedString(@"墙体改造图",nil),NSLocalizedString(@"天花布置图", nil),NSLocalizedString(@"水路布置图", nil),NSLocalizedString(@"电路分布图",nil)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tableView];

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNConstructPaymentTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kConstructPaymentCell];
    
    [self initDetailData];
    [self initPicDict];
    self.pernalDetail = @[self.roomNo,self.ownerName,self.ownerMobile];
    [self initButtonName];
}
- (void)initButtonName{
    if ([self.assessorstate isEqualToString:@"0"]){
        self.buttonName = @"开通商家认证";
    }
    if ([self.assessorstate isEqualToString:@"-1"]){
        self.buttonName = @"开通商家认证";
    }
    if ([self.assessorstate isEqualToString:@"1"]){
        if ([self.paystate isEqualToString:@"1"])
            self.buttonName = @"开通商家认证";
        else if ([self.paystate isEqualToString:@"2"])
            self.buttonName = @"前去支付费用";
        else
            self.buttonName = @"完善报建资料";
    }
    if ([self.assessorstate isEqualToString:@"2"]){
        self.buttonName = @"开通商家认证";
    }
}
- (void)initDetailData{
    self.detailTitle = [[NSMutableArray alloc] init];
    if (self.constructType < 2){
        [self.detailTitle addObject:NSLocalizedString(@"装修公司资料", nil)];
        [self.detailTitle addObjectsFromArray:self.companyData];
    }
    [self.detailTitle addObject:NSLocalizedString(@"业主及图纸资料", nil)];
    [self.detailTitle addObjectsFromArray:self.personalData];
    [self.detailTitle addObjectsFromArray:self.graphData];
}
- (void)initPicDict{
    self.picDict = [[NSMutableDictionary alloc] init];
    NSString *offset = @"3";
    if (self.constructType < 2){
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"businessLicense"]] forKey:@"1"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"TaxCertificate"]] forKey:@"2"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"OrganizationCode"]] forKey:@"3"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"Certificate"]] forKey:@"4"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"Electrician"]] forKey:@"5"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"powerAttorney"]] forKey:@"6"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"gccIDCard"]] forKey:@"7"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"compactIMG"]] forKey:@"8"];
        [self.picDict setObject:[self imageWithLink:self.shopInfo[@"AttorneyIDcard"]] forKey:@"9"];
        offset = @"13";
    }
    NSInteger flag = [offset integerValue];
    [self.picDict setObject:[self imageWithLink:self.chart[kOriginalSChart]] forKey:[NSString stringWithFormat:@"%d",++flag]];
    [self.picDict setObject:[self imageWithLink:self.chart[kfloorplan]] forKey:[NSString stringWithFormat:@"%d",++flag]];
    [self.picDict setObject:[self imageWithLink:self.chart[kwallRemould]] forKey:[NSString stringWithFormat:@"%d",++flag]];
    [self.picDict setObject:[self imageWithLink:self.chart[kceilingPlan]] forKey:[NSString stringWithFormat:@"%d",++flag]];
    [self.picDict setObject:[self imageWithLink:self.chart[kWaterwayPlan]] forKey:[NSString stringWithFormat:@"%d",++flag]];
    [self.picDict setObject:[self imageWithLink:self.chart[kBlockDiagram]] forKey:[NSString stringWithFormat:@"%d",++flag]];
}
- (UIImage *)imageWithLink:(NSString *)link{
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[link addPort]]]];
    return image? image : [UIImage imageNamed:@"selectphoto.png"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:self.buttonName forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(purchase:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:purchase];
    CGSize size = self.tableView.contentSize;
    view.top = size.height;
    [self.tableView addSubview:view];
    size.height += view.height;
    self.tableView.contentSize = size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
//        if (self.constructType < 2)
//            return [self.companyData count];
//        else
//            return [self.personalData count];
        return [self.detailTitle count];
    }
    else
        return [self.allData[@"needItem"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    UILabel *label = [[UILabel alloc] init];
    if (section == 0){
        label.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"承包方式", nil),
                      self.constructType < 2 ? @"公司承包装修" : @"业主自装"];
    }else
        label.text = NSLocalizedString(@"缴费项目", nil);
    [label sizeToFit];
    label.textColor = [UIColor whiteColor];
    label.left = 5;
    label.centerY = contentView.height / 2;
    [contentView addSubview:label];
    [view addSubview:contentView];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"ConstructCell";
    HNConstructTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[HNConstructTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        [cell.photo addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (0==indexPath.section){
        //图纸及资料
        cell.title.text = self.detailTitle[indexPath.row];
        [cell reset];
        if (0==indexPath.row){
            cell.title.textColor = [UIColor colorWithWhite:200.0/255.0 alpha:1.0];
            cell.photo.hidden = YES;
        }
        NSUInteger offset = 0;
        if (self.constructType < 2){
            offset = [self.companyData count] + 1;
        }
        if (offset == indexPath.row)
        {
            cell.title.textColor = [UIColor colorWithWhite:200.0/255.0 alpha:1.0];
            cell.photo.hidden = YES;
        }
        if (offset < indexPath.row && offset + [self.personalData count] + 1> indexPath.row)
        {
            UIFont *font = cell.title.font;
            CGSize size = CGSizeMake(cell.contentView.width - 30, cell.contentView.height);
            CGSize titleSize = [[NSString stringWithFormat:@"%@%@",cell.title.text,self.pernalDetail[indexPath.row - offset - 1]] sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
            cell.title.width = titleSize.width;
            cell.title.height = titleSize.height;
            cell.title.text = [NSString stringWithFormat:@"%@%@",cell.title.text,self.pernalDetail[indexPath.row - offset - 1]];
            cell.title.centerY = cell.contentView.height / 2;
            cell.photo.hidden = YES;
        }
        if (!cell.photo.hidden){
            [cell.photo setImage:[self.picDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]] forState:UIControlStateNormal];
            [cell.photo setImage:[self.picDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]] forState:UIControlStateHighlighted];
        }
        cell.photo.tag = (indexPath.section + 1) * 100 + indexPath.row;
    }
    else
    {
        HNConstructPaymentTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:kConstructPaymentCell];
        [tCell setContent:self.allData[@"needItem"][indexPath.row]];
        return tCell;
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
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)purchase:(UIButton *)sender{
    if ([self.buttonName isEqualToString:@"开通商家认证"]){
        [self cerShop];
    }
    if ([self.buttonName isEqualToString:@"前去支付费用"]){
        [self goPur];
    }
    if ([self.buttonName isEqualToString:@"完善报建资料"]){
        [self configUnComplete];
    }
    return ;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSString *type = self.constructType > 1 ? @"0" :@"1";
    NSDictionary *dic = @{@"declareid": self.declareid,@"type": type};
    NSString *sendJson = [dic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.prices.list" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!retStr)
            {
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count!=0){
                NSMutableArray *mustPay = [[NSMutableArray alloc] init];
                NSMutableArray *optionPay = [[NSMutableArray alloc] init];
                NSArray *dataArr = [retDic objectForKey:@"data"];
                [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                    NSString *title = [obj objectForKey:@"name"];
                    NSString *must = [obj objectForKey:@"IsSubmit"];
                    NSString *price = [obj objectForKey:@"price"];
                    NSString *useUnit = [obj objectForKey:@"useUnit"];
                    HNPurchaseItem *item = [[HNPurchaseItem alloc] init];
                    item.title = title;
                    if (useUnit && ![useUnit isEqualToString:@""]){
                        item.single = 1;
                        item.nums = 0;
                        item.unitPrice = [price floatValue];
                        item.price = 0;
                    }
                    else{
                        item.single = 0;
                        item.price = [price floatValue];
                    }
                    if ([must isEqualToString:@"1"]){
                        [mustPay addObject:item];
                    }
                    else
                        [optionPay addObject:item];
                }];
                HNPurchaseViewController *pur = [[HNPurchaseViewController alloc] init];
                pur.mustPay = mustPay;
                pur.optionPay = optionPay;
                [self.navigationController pushViewController:pur animated:YES];
            }
            else
                [self showNoData];
        }
        else
            [self showNoNetwork];
    }];
//    HNPurchaseViewController *pur = [[HNPurchaseViewController alloc] init];
//    HNPurchaseItem *item = [[HNPurchaseItem alloc] init];
//    item.title = @"装修保证金";
//    item.price = 2000.0;
//    item.single = 0;
//    pur.mustPay = @[item];
//    HNPurchaseItem *oItem = [[HNPurchaseItem alloc] init];
//    oItem.title = @"装修垃圾下楼费";
//    oItem.single = 1;
//    oItem.nums = 3;
//    oItem.unitPrice = 300.0;
//    oItem.price = oItem.nums * oItem.unitPrice;
//    pur.optionPay = @[oItem];
    
//    [self.navigationController pushViewController:pur animated:YES];
}
- (void)cerShop{
    HNGetAuthViewController *vc = [[HNGetAuthViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goPur{
    HNPayType type = 0;
    if (self.constructType == kCompanyDetail){
        type = KHNPayType6;
    }
    else if (self.constructType == kPersonalDetail)
        type = KHNPayType5;
    if ([self.allData[@"Isaddition"] intValue] == 1)
        type = KHNPayType7;
    [HNPaySupport shared].delegate = self;
    [[HNPaySupport shared] getPayToken:self.declareid cid:self.declareid payType:type];
}
- (void)didGetPayUrl:(NSString *)url{
    NSURL *jump = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:jump];
}
- (void)configUnComplete{
    HNNewReportViewController *vc = [[HNNewReportViewController alloc] init];
    if (self.constructType == kCompanyDetail)
        vc.constructType = 1;
    else
        vc.constructType = 0;
    vc.declareId = self.declareid;
    vc.roomNumber = self.roomNo;
    vc.ownername = self.ownerName;
    vc.ownerphone = self.ownerMobile;
    vc.allData = self.allData;
    [self.navigationController pushViewController:vc animated:YES];
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
- (void)showPic:(UIButton *)sender{
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = sender.currentImage;
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}

@end
