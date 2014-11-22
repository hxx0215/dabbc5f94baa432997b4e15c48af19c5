//
//  ProfileChangeViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNProfileChangeViewController.h"
#import "HNAreaPickerView.h"
#include "UIView+AHKit.h"
#include "HNEditTableViewCell.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "HNLoginData.h"

@interface HNProfileChangeViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITextField* currentTextField;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UIView* textOKView;
@end

@implementation HNProfileChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(OKButtonClick:)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(CancelButtonClick:)];
    self.navigationItem.leftBarButtonItem = cancel;
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.nameTextField.text = self.model.name;
//    self.categoryTextField.text = self.model.category;
//    self.addressTextField.text = self.model.address;
//    self.shopkeeperTextField.text = self.model.shopkeeper;
//    self.phoneTextField.text = self.model.phone;
//    self.onlineServiceTextField.text = self.model.onlineService;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.currentTextField = nil;
}

- (IBAction)OKButtonClick:(id)sender
{
    if (self.currentTextField) {
        [self.currentTextField resignFirstResponder];
    }
    [self loadMyData];
    //[self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)CancelButtonClick:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - loadMyData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].uid,@"userid",self.model.realname,@"realname", self.model.email,@"email",self.model.idcard,@"idcard",self.model.phone,@"phone",self.model.attorneyIDcard,@"attorneyIDcard",nil];
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.user.details" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didloadMyData:) withObject:data waitUntilDone:YES];
    }];
}

- (void)didloadMyData:(NSData *)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){
            self.navigationController.view.userInteractionEnabled = NO;
            [self dismissViewControllerAnimated:YES completion:^{
                self.navigationController.view.userInteractionEnabled = YES;
            }];
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
#pragma mark - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    self.currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentTextField = nil;
    switch (textField.tag) {
        case 0:
        {
            self.model.realname = textField.text;
        }
            break;
        case 1:
        {
            self.model.phone = textField.text;
        }
            break;
        case 2:
        {
            self.model.email = textField.text;
        }
            break;
        case 3:
        {
            self.model.idcard = textField.text;
        }
            break;
        case 4:
        {
            self.model.attorneyIDcard = textField.text;
        }
            break;
        default:
            break;
    };
}


- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    return YES;
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
#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identy = @"complaintDetailCell";
    HNEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[HNEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *titleString = nil;
    NSString *detailString = nil;
    switch (indexPath.row) {
            
        case 0:
        {
            titleString = @"真实姓名：";
            detailString = self.model.realname;
        }
            break;
        case 1:
        {
            titleString = @"联系方式：";
            detailString = self.model.phone;
        }
            break;
        case 2:
        {
            titleString = @"电子邮箱：";
            detailString = self.model.email;
        }
            break;
        case 3:
        {
            titleString = @"身份证号：";
            detailString = self.model.idcard;
        }
            break;
        case 4:
        {
            titleString = @"身份证照片：";
            detailString = self.model.attorneyIDcard;
        }
            break;
        default:
            break;
    }
    cell.title.text = titleString;
    cell.textView.text = detailString;
    cell.textView.tag = indexPath.row;
    cell.textView.delegate = self;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
