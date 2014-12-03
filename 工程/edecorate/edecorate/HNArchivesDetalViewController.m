//
//  HNArchivesDetalViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-26.
//
//

#import "HNArchivesDetalViewController.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNUploadImage.h"
#import "HNImageUploadTableViewCell.h"
#import "HNTemporaryApplyTableViewCell.h"
#import "HNPicTableViewCell.h"

@interface HNArchivesDetalViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HNPicTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *uploadButton;
@property (nonatomic, strong) UIImage *uploadImage;

@property (nonatomic, strong)UIImagePickerController *imagePicker;
@property (strong, nonatomic) NSString* imagePath;
//@property (nonatomic) NSString* imagePath;
@end

@implementation HNArchivesDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.title = @"装修档案详情";
    
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =self;
    self.imagePicker.sourceType = sourceType;
    self.imagePicker.allowsEditing = NO;
    
    [self loadMyData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark data
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.model.fileid,@"fileid", nil];//self.dID
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.archives.details" Params:jsonStr]];
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
        if (!retStr)
        {
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<total.intValue; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                [self.model updateDeteilData:dicData];
            }
            [self.tableView reloadData];
        }

    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model.isReturn.integerValue) {
        return 3;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (1==section)
    {
        
        return 2;
    }
    if (2==section)
    {
        if(self.model.isReturn.integerValue)
            return 4;
        else
            return 2;
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
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    if (section == 3)
    {
        UIButton *label = [UIButton buttonWithType:UIButtonTypeCustom];
        label.titleLabel.font = [UIFont systemFontOfSize:15];
        label.width = contentView.width -10;
        label.height = contentView.height - 10;
        [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        contentView.backgroundColor = [UIColor projectRed];
        [HNUIStyleSet UIStyleSetRoundView:contentView];
        [label setTitle:@"提交" forState:UIControlStateNormal];
        [label addTarget:self action:@selector(commitclicked:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:label];
    }
    else{
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.width = contentView.width -10;
        label.height = contentView.height - 10;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 2;
        label.centerY = contentView.height / 2;
        if (section == 0){
            [HNUIStyleSet UIStyleSetRoundView:contentView];
            label.text = self.model.room;
            [label sizeToFit];
            label.centerY = contentView.height / 2;
        }else if (section == 1)
        {
            label.text = NSLocalizedString(@"档案信息", nil);
            label.textAlignment = NSTextAlignmentCenter;
        }
        else if (section == 2)
        {
            label.text = NSLocalizedString(@"施工方回复", nil);
            label.textAlignment = NSTextAlignmentCenter;
        }
        
        label.left = 5;
        [contentView addSubview:label];
    }
    
    
    
    [view addSubview:contentView];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2&&indexPath.row==1&&!self.model.isReturn.integerValue) {
        if (self.imagePath&&self.imagePath.length>1) {
            return 97;
        }
        return 40;
    }
    if (indexPath.section==2&&indexPath.row==3) {
        return 60;
    }
    return 30;
}

- (void)updataImage:(NSString*)images heightChange:(BOOL)change
{
    self.imagePath = images;
    if (change) {
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (2==indexPath.section){
        if(!self.model.isReturn.integerValue)
        {
            
            
            if (1 == indexPath.row) {
                static NSString *identy = @"picCell";
                HNPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
                if (!cell)
                {
                    cell = [[HNPicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
                }

                cell.name.text = @"附件：";
                [cell setImages:self.imagePath];
                [cell MyShowPic:YES];// = 0;
                cell.delegate = self;
                return cell;
            }
            else
            {
                static NSString *identy = @"ApplyCell";
                HNTemporaryApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
                if (!cell)
                {
                    cell = [[HNTemporaryApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.title.text = @"回复内容：";
                [cell setStyle:0];
                cell.textField.placeholder = @"点击输入回复内容";
                cell.textField.delegate = self;
                return cell;
            }
            
        }
        else
        {
            if (indexPath.row==3) {
                static NSString *identy = @"imageCell";
                HNPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
                if (!cell)
                {
                    cell = [[HNPicTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
                }
                //UIImage *image = [[HNImageData shared]imageWithLink:[self.dataArray2 objectAtIndex:indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.name.text = @"附件";
                [cell setImages:self.model.EnterpriseFile];
                [cell MyShowPic:YES];// = 1;
                cell.delegate = self;
                return cell;
            }
            static NSString *identy = @"complaintDetailCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"回复内容：";
                    cell.detailTextLabel.text = self.model.gccReturn;
                    break;
                case 1:
                    cell.textLabel.text = @"回复时间：";
                    cell.detailTextLabel.text = self.model.gccReturnTime;
                    break;
                case 2:
                    cell.textLabel.text = @"是否满意：";
                    cell.detailTextLabel.text = self.model.satisfaction.integerValue?@"不满意":@"满意";
                    break;
                    
                default:
                    break;
            }
            cell.textLabel.textColor = [UIColor darkTextColor];
            return cell;
        }
        
        
    }
    static NSString *identy = @"complaintDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*
     title	标题
     satisfaction	是否满意
     declareId	装修项目Id
     CreateTime	提出问题的时间
     EnterpriseFile	施工方回复附件
     gccReturn	施工方回复内容
     gccReturnTime	回复时间
     ownerFile	业主上传的附件
     ownerRemark	业主提交的内容*/
    if (1==indexPath.section){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"标题：";
                cell.detailTextLabel.text = self.model.title;
                break;
            case 1:
                cell.textLabel.text = @"备注：";
                cell.detailTextLabel.text = self.model.ownerRemark;
                break;
                
            default:
                break;
        }
        cell.textLabel.textColor = [UIColor darkTextColor];
            
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


- (void)showPic:(UIButton *)sender{
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = sender.currentImage;
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}


- (IBAction)upload:(id)sender{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    [self requestForPostWithURLString:image];
}

-(void)requestForPostWithURLString:(UIImage*)image
{
    [HNUploadImage UploadImage:image block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (msg) {
            self.imagePath = msg;
            self.uploadImage = image;
            [self.uploadButton setImage:image forState:UIControlStateNormal];
        }
    }];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    self.tableView.contentSize = CGSizeMake(self.view.width,self.tableView.contentSize.height+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.tableView];//把当前的textField的坐标映射到scrollview上
    if(self.tableView.contentOffset.y-pt.y<=0)//判断最上面不要去滚动
        [self.tableView setContentOffset:CGPointMake(0, pt.y) animated:YES];//华东
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.gccReturn = textField.text;
    [UIView animateWithDuration:0.30f animations:^{
        self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width, self.tableView.contentSize.height-216);
    }];
}

#pragma mark commitclicked
-(void)commitclicked:(id)sender
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    //{"fileid":"","declareid":"","EnterpriseFile":"","EnterpriseReturn":""}
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.model.declareId,@"declareid",self.model.fileid,@"fileid", self.imagePath,@"EnterpriseFile",self.model.gccReturn,@"EnterpriseReturn",nil];//self.dID
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.archives.details" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didcommitclicked:) withObject:data waitUntilDone:YES];
    }];
}



- (void)didcommitclicked:(NSData *)data
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr)
            [self showBadServer];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        NSString *msg = nil;
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            NSDictionary *dicData = [array objectAtIndex:0];
            NSNumber *state = [dicData objectForKey:@"state"];
            msg = [dicData objectForKey:@"msg"];
            if (state&&state.integerValue) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }

        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"失败", nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
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
