//
//  ProfileViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNProfileViewController.h"
#import "HNProfileChangeViewController.h"
#import "UIView+AHKit.h"
#import "HNBusinessBackgroundModel.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "HNLoginData.h"
#import "HNProfileData.h"
#import "HNImageUploadTableViewCell.h"

@interface HNProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) HNProfileData *model;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HNProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(changButtonClick:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.model = [[HNProfileData alloc]init];


    
}


- (IBAction)changButtonClick:(id)sender {
    HNProfileChangeViewController *controller = [[HNProfileChangeViewController alloc] init];
    controller.model = self.model;
    //[self.navigationController pushViewController:controller animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.translucent = NO;
    [self.navigationController.view setUserInteractionEnabled:NO];
    [self presentViewController:nav animated:YES completion:^{
        [self.navigationController.view setUserInteractionEnabled:YES];
    }];
}
#pragma mark - loadMyData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].uid,@"userid", nil];
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.user.details" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didloadMyData:) withObject:data waitUntilDone:YES];
    }];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)didloadMyData:(NSData *)data
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
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            [self.model updateData:[array objectAtIndex:0]];
            [self.tableView reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Fail", nil) message:NSLocalizedString(@"Please input correct username and password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self loadMyData];
    
}
#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    label.text = NSLocalizedString(@"我的资料", nil);
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
    if (indexPath.row==0)
    {
        return 65;
    }
    if (indexPath.row==9)
    {
        return 65;
    }
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        static NSString *identy = @"HNImageUploadTableViewCell";
        HNImageUploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[HNImageUploadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
            [cell.photo addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"商户头像：";
        [cell reset:self.model.headImage];
        return cell;
    }
    if (indexPath.row==9) {
        static NSString *identy = @"HNImageUploadTableViewCell";
        HNImageUploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[HNImageUploadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
            [cell.photo addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"身份证照片：";
        [cell reset:self.model.attorneyIDcard];
        return cell;
    }
    static NSString *identy = @"complaintDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *titleString = nil;
    NSString *detailString = nil;
    switch (indexPath.row) {
            
        case 1:
        {
            titleString = @"商户编号：";
            detailString = [NSString stringWithFormat:@"%ld",self.model.mshopid.integerValue] ;
        }
            break;
        case 2:
        {
            titleString = @"注册时间：";
            detailString = self.model.createtime;
        }
            break;
        case 3:
        {
            titleString = @"上次登录时间：";
            detailString = self.model.lastlogintime;
        }
            break;
        case 4:
        {
            titleString = @"登录名：";
            detailString = self.model.shopusername;
        }
            break;
        case 5:
        {
            titleString = @"真实姓名：";
            detailString = self.model.realname;
        }
            break;
        case 6:
        {
            titleString = @"联系方式：";
            detailString = self.model.phone;
        }
            break;
        case 7:
        {
            titleString = @"电子邮箱：";
            detailString = self.model.email;
        }
            break;
        case 8:
        {
            titleString = @"身份证号：";
            detailString = self.model.idcard;
        }
            break;
        default:
            break;
    }
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.textLabel.text = titleString;
    cell.detailTextLabel.text = detailString;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPic:(UIButton *)sender{
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = sender.currentImage;
    [self presentViewController:vc animated:NO completion:^{
        
    }];
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
