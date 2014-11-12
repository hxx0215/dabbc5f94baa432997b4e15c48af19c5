//
//  HNOfficePassesDetailsViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-21.
//
//

#import "HNOfficePassesDetailsViewController.h"
#import "UIView+AHKit.h"
#import "HNPersonDetailTableViewCell.h"

@interface HNOfficePassesDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray1;
@property (nonatomic, strong) NSArray *titleArray2;
@property (nonatomic, strong) NSArray *dataArray1;
@property (nonatomic, strong) NSArray *dataArray2;
@end

@implementation HNOfficePassesDetailsViewController

-(id)initWithModel:(HNPassData *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"Pass Details", nil);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNPersonDetailTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PersonDetailCell"];
    
    [self.view addSubview:self.tableView];
    
    self.titleArray1 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Owners", nil),NSLocalizedString(@"Phone number", nil),NSLocalizedString(@"Construction unit", nil),NSLocalizedString(@"Person in charge of construction", nil),NSLocalizedString(@"Phone number", nil),nil];
    
    self.dataArray1 = [[NSArray alloc] initWithObjects:self.temporaryModel.ownername,self.temporaryModel.ownerphone,self.temporaryModel.shopname,self.temporaryModel.principal,self.temporaryModel.EnterprisePhone,nil];
    
    
    
    NSString *str = [[NSString alloc]init];
    for (int i=0; i<[self.temporaryModel.proposerItems count];i++) {
        HNPassProposerData* proposerData = self.temporaryModel.proposerItems[i];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@ ",proposerData.name]];
    }
    if ([self.temporaryModel.proposerItems count]) {
        
//        [self labelWithTitle:proposerData.name label:self.decortionMan];
//        [self labelWithTitle:proposerData.phone label:self.decorationManMobile];
//        [self labelWithTitle:proposerData.IDcard  label:self.decorationIdCardNo];
//        [self labelWithTitle:proposerData.Icon label:self.decorationIdCardPic];
//        [self labelWithTitle:proposerData.isTransaction label:self.decorationPic];
    }
//    self.personsLabel.text = str;
//    
// 
//    int officepassPerFee=10,depositFee=30;
//    int officepassCount=1,depositCount=1;
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassPerFee] label:self.passcardPerFee];
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount] label:self.passcardCount];
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount*officepassPerFee] label:self.passcardSumFee];
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositFee] label:self.depositPerFee];
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount] label:self.depositCount];
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee] label:self.depositSumFee];
//    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee+officepassCount*officepassPerFee] label:self.sumMoney];
    // Do any additional setup after loading the view from its nib.
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    //[lab sizeToFit];
    //lab.font = [UIFont systemFontOfSize:12];
    //lab.numberOfLines = 2;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2 + [self.temporaryModel.proposerItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        
        return 5;
    }
    else if([self.temporaryModel.proposerItems count]>=section)
    {
        return 1;
    }
    else
        return 1;
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
        label.text = self.temporaryModel.roomnumber;
    }else if([self.temporaryModel.proposerItems count]>=section)
    {
        label.text = NSLocalizedString(@"施工人员信息", nil);
    }
    else
        label.text = NSLocalizedString(@"缴费项目", nil);
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
    if (0==indexPath.section)
    {
        
        return 30;
    }
    else if([self.temporaryModel.proposerItems count]>=indexPath.section)
    {
        return 155;
    }
    else
        return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0==indexPath.section) {
        static NSString *identy = @"complaintDetailCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self.titleArray1 objectAtIndex:indexPath.row];
        if(indexPath.row<[self.dataArray1 count])
            cell.detailTextLabel.text = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor darkTextColor];
        return cell;
    }else if([self.temporaryModel.proposerItems count]>=indexPath.section)
    {
        static NSString *identy = @"PersonDetailCell";
        HNPersonDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[HNPersonDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        }
        HNPassProposerData *proposer = [self.temporaryModel.proposerItems objectAtIndex:(indexPath.section-1)];
        cell.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",proposer.name];
        cell.phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",proposer.phone];
        cell.cardLabel.text = [NSString stringWithFormat:@"身份证号码：%@",proposer.IDcard];
        return cell;
    }
    else
    {
        static NSString *identy = @"complaintDetailCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self.titleArray2 objectAtIndex:indexPath.row];
        if(indexPath.row<[self.dataArray2 count])
            cell.detailTextLabel.text = [self.dataArray2 objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor darkTextColor];
        return cell;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
