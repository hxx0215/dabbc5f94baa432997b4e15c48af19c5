//
//  HNComplaintDetailsViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNComplaintDetailsViewController.h"
#import "UIView+AHKit.h"

@interface HNComplaintDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)IBOutlet UILabel *houseInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *complaintInfMainLabel;

@property (nonatomic, strong)IBOutlet UILabel *houseInfTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersPhoneNumberLabel;

@property (nonatomic, strong)IBOutlet UILabel *constructionUnitTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionUnitLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonPhoneNumberLabel;

@property (nonatomic, strong)IBOutlet UILabel *complaintInformationTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintCategoryTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintObjectTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintIssueTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *evidenceTitleLable;

@property (nonatomic, strong)IBOutlet UILabel *complaintCategoryLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintObjectLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintIssueLable;

@property (nonatomic, strong)IBOutlet UILabel *uploadStatusLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintStatusLable;
@property (nonatomic, strong)IBOutlet UIButton *checkOutButton;

@property (nonatomic, strong)IBOutlet UILabel *complaintbodyLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintCreateTimeLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintconstructionTeamLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintmanagementLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintconstructionTeamTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintmanagementTitleLable;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HNComplaintDetailsViewController

-(id)initWithModel:(HNComplaintData *)model
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
    
//    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfMainLabel];
//    
//    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfTitleLabel];
//    [self labelWithTitle:self.temporaryModel.room label:self.houseInfLabel];
//    
    
    //Complaint Information

    

    CGFloat pos = self.complaintIssueLable.bottom>self.complaintIssueTitleLable.bottom?self.complaintIssueLable.bottom:self.complaintIssueTitleLable.bottom;
    
    CGFloat space = self.complaintIssueTitleLable.top-self.complaintObjectTitleLable.bottom;
    self.complaintconstructionTeamLable.top = pos+space;
    self.complaintconstructionTeamTitleLable.top = self.complaintconstructionTeamLable.top;
    self.complaintmanagementLable.top = self.complaintconstructionTeamLable.bottom+space;
    self.complaintmanagementTitleLable.top = self.complaintmanagementLable.top;
    self.checkOutButton.top = self.complaintmanagementLable.bottom+space;

    self.uploadStatusLable.top = self.checkOutButton.top;
    self.evidenceTitleLable.top = self.checkOutButton.top;
    self.complaintStatusLable.top = self.checkOutButton.bottom+2;
    
    [self.checkOutButton setTitle:NSLocalizedString(@"Check Out", nil) forState:UIControlStateNormal];
    self.checkOutButton.layer.borderWidth = 1.0;
    self.checkOutButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.complaintStatusLable setText:NSLocalizedString(@"Processing", nil)];
    [HNUIStyleSet UIStyleSetRoundView:self.houseInfMainLabel];
    [HNUIStyleSet UIStyleSetRoundView:self.complaintInfMainLabel];
    [HNUIStyleSet UIStyleSetRoundView:self.complaintStatusLable];
    /*
     "Processing" ＝ "正在处理";*/
    
}

- (IBAction)checkOut:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Check Out", nil) delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag=3;
    [alert show];
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
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
        
        return 0;
    }
    else
        return 7;
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
        label.text = self.temporaryModel.room;
    }else
        label.text = NSLocalizedString(@"投诉信息", nil);
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
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"complaintDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (1==indexPath.section){
        NSString *titleString = nil;
        NSString *detailString = nil;
        switch (indexPath.row) {
            case 0:
            {
                titleString = NSLocalizedString(@"Complaint Time", nil);
                detailString = self.temporaryModel.CreateTime;
            }
                break;
            case 1:
            {
                titleString = NSLocalizedString(@"Complaint Content", nil);
                detailString = self.temporaryModel.body;
            }
                break;
            case 2:
            {
                titleString = NSLocalizedString(@"Complaint Category", nil);
                detailString = self.temporaryModel.complainType;
            }
                break;
            case 3:
            {
                titleString = NSLocalizedString(@"Complaint Object", nil);
                detailString = self.temporaryModel.complainObject;
            }
                break;
            case 4:
            {
                titleString = NSLocalizedString(@"Complaint Issue", nil);
                detailString = self.temporaryModel.complainProblem;
            }
                break;
            case 5:
            {
                titleString = NSLocalizedString(@"constructionTeam result", nil);
                detailString = self.temporaryModel.constructionTeam;
            }
                break;
            case 6:
            {
                titleString = NSLocalizedString(@"management result", nil);
                detailString = self.temporaryModel.management;
            }
                break;
                
            default:
                break;
        }
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.textLabel.text = titleString;
        cell.detailTextLabel.text = detailString;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
