//
//  HNTemporaryDetailsViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNTemporaryDetailsViewController.h"
#import "UIView+AHKit.h"

@interface HNTemporaryDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *noticeFireButton;
@property (strong, nonatomic) IBOutlet UIButton *checkOutButton;


@property (strong, nonatomic) IBOutlet UILabel *statusLable;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray1;
@property (nonatomic, strong) NSArray *titleArray2;
@property (nonatomic, strong) NSArray *dataArray1;
@property (nonatomic, strong) NSArray *dataArray2;
@end

@implementation HNTemporaryDetailsViewController

-(id)initWithModel:(HNTemporaryModel *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.titleArray1 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Owners", nil),NSLocalizedString(@"Phone number", nil),NSLocalizedString(@"Construction unit", nil),NSLocalizedString(@"Person in charge of construction", nil),NSLocalizedString(@"Phone number", nil),nil];
    
    self.dataArray1 = [[NSArray alloc] initWithObjects:self.temporaryModel.huseInfo.owners,self.temporaryModel.huseInfo.ownersPhoneNumber,self.temporaryModel.huseInfo.constructionUnit,self.temporaryModel.huseInfo.constructionPerson,self.temporaryModel.huseInfo.constructionPersonPhoneNumber,nil];
    
    if (self.temporaryModel.type==FIRE) {
        HNTemporaryFireModel* fmodel = (HNTemporaryFireModel*)self.temporaryModel;
        self.titleArray2 =   [[NSArray alloc] initWithObjects:NSLocalizedString(@"Fire units", nil),NSLocalizedString(@"Use of fire by", nil),NSLocalizedString(@"Fire tools", nil),NSLocalizedString(@"Fire load", nil),NSLocalizedString(@"Start Time", nil),NSLocalizedString(@"End Time", nil),NSLocalizedString(@"Operator", nil),NSLocalizedString(@"Phone", nil),NSLocalizedString(@"Valid documents", nil),nil];
        
        self.dataArray2 = [[NSArray alloc] initWithObjects:fmodel.dataInfo.fireUnits,fmodel.dataInfo.useOfFireBy,fmodel.dataInfo.fireTools,fmodel.dataInfo.fireLoad,fmodel.dataInfo.startTime,fmodel.dataInfo.endTime,fmodel.dataInfo.operatorPerson,fmodel.dataInfo.phone,fmodel.dataInfo.validDocuments,nil];
        
    }
    else{
        HNTemporaryElectroModel* emodel = (HNTemporaryElectroModel*)self.temporaryModel;
        self.titleArray2 =   [[NSArray alloc] initWithObjects:NSLocalizedString(@"Electro units", nil),NSLocalizedString(@"Use of electro by", nil),NSLocalizedString(@"Electro tools", nil),NSLocalizedString(@"Electro load", nil),NSLocalizedString(@"Start Time", nil),NSLocalizedString(@"End Time", nil),NSLocalizedString(@"Operator", nil),NSLocalizedString(@"Phone", nil),NSLocalizedString(@"Valid documents", nil),nil];
        
        self.dataArray2 = [[NSArray alloc] initWithObjects:emodel.dataInfo.electroEnterprise,emodel.dataInfo.electroCause,emodel.dataInfo.electroTool,emodel.dataInfo.electroLoad,emodel.dataInfo.electroBTime,emodel.dataInfo.electroETime,emodel.dataInfo.electroOperator,emodel.dataInfo.electroPhone,emodel.dataInfo.PapersImg ,nil];
    }
    

    
//    
//    [self labelWithTitle:@"未上传" label:self.uploadStatusLable];
//    
//    //@property (strong, nonatomic) IBOutlet UIButton *commitButton;
//    
//    [self.noticeFireButton sizeToFit];
//    
//    
//    [self.checkOutButton setTitle:NSLocalizedString(@"Check Out", nil) forState:UIControlStateNormal];
//    [self.checkOutButton sizeToFit];
//    self.checkOutButton.layer.borderWidth = 1.0;
//    self.checkOutButton.layer.borderColor = [UIColor blackColor].CGColor;
//    
//    [self.statusLable setText:@"正在审核"];
//    //[self.statusLable sizeToFit];
//    
//    [HNUIStyleSet UIStyleSetRoundView:self.houseInfMainLabel];
//    [HNUIStyleSet UIStyleSetRoundView:self.temporaryApplyMainLable];
//    [HNUIStyleSet UIStyleSetRoundView:self.constructionInfMainLabel];
//    [HNUIStyleSet UIStyleSetRoundView:self.statusLable];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (IBAction)checkOut:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Check Out", nil) delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag=3;
    [alert show];
}

- (IBAction)noticeFireClicked:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"用火须知" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag = 2;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
//    [lab sizeToFit];
//    lab.font = [UIFont systemFontOfSize:12];
//    lab.numberOfLines = 2;
//    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        
        return 5;
    }
    else
        return 9;
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
        label.text = self.temporaryModel.roomName;
    }else
        label.text = NSLocalizedString(@"申请", nil);
    label.font = [UIFont systemFontOfSize:15];
    label.width = contentView.width -10;
    label.numberOfLines = 2;
    [label sizeToFit];
    label.textColor = [UIColor whiteColor];
    label.left = 5;
    label.centerY = contentView.height / 2;
    [contentView addSubview:label];
    [view addSubview:contentView];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"complaintDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (0==indexPath.section) {
        cell.textLabel.text = [self.titleArray1 objectAtIndex:indexPath.row];
        if(indexPath.row<[self.dataArray1 count])
            cell.detailTextLabel.text = [self.dataArray1 objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.titleArray2 objectAtIndex:indexPath.row];
        if(indexPath.row<[self.dataArray2 count])
            cell.detailTextLabel.text = [self.dataArray2 objectAtIndex:indexPath.row];
    }
    cell.textLabel.textColor = [UIColor darkTextColor];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
