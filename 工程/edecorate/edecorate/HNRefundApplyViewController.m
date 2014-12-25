//
//  HNRefundApplyViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import "HNRefundApplyViewController.h"
#import "HNDecorateChoiceView.h"
#import "UIView+AHKit.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNImageUploadTableViewCell.h"
#import "HNRefundCardCountTableViewCell.h"
#import "HNPicTableViewCell.h"

@interface HNRefundApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,HNPicTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;

@property (nonatomic, strong)UIImagePickerController *imagePicker;

@property (strong, nonatomic) NSString *imageName;
//@property (strong, nonatomic) IBOutlet HNDecorateChoiceView *choiceDecorateView;
@property (strong, nonatomic) UIView *commitView;
@property (nonatomic) CGFloat contentSizeHeight;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) UITextField* cardMunTextField;
@property (strong, nonatomic) UIToolbar *topView;
@end

@implementation HNRefundApplyViewController

-(id)initWithModel:(HNRefundData *)model
{
    self = [super init];
    self.temporaryModel = model;
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =self;
    self.imagePicker.sourceType = sourceType;
    self.imagePicker.allowsEditing = NO;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 25)];
//    [self.view addSubview:self.choiceDecorateView];
//    self.choiceDecorateView.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.title = NSLocalizedString(@"Deposit refund", nil);
    
    self.topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    self.topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [self.topView setItems:buttonsArray];
    
}

- (void)updataImage:(NSString*)images heightChange:(BOOL)change
{
    self.imageName = images;
    if (change) {
        [self.tableView reloadData];
        [self movewButton];
    }
}

- (void)dismissKeyBoard
{
    [self.cardMunTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commit:(id)sender
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithModel] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.deposit.refund" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){

        [self performSelectorOnMainThread:@selector(didCommit:) withObject:data waitUntilDone:YES];
        
    }];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}

-(void)didCommit:(NSData*)data
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
        if ([[dic objectForKey:@"total"] intValue])
        {
            NSArray *arry = [dic objectForKey:@"data"];
            NSDictionary* dicData = [arry objectAtIndex:0];
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:[dicData objectForKey:@"msg"] delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
            alert.tag=1;
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (NSDictionary *)encodeWithModel{
    /*
     declareid		报建编号
     cardnum		回收出入证数量
     cardimg		回收照片
     */
    NSString *imageNameStr = @"";
    if (self.imageName) {
        imageNameStr = self.imageName;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.temporaryModel.declareId,@"declareid", imageNameStr,@"cardimg",nil];//self.cardMunTextField.text,@"cardnum",
    return dic;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)upload:(id)sender{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *scaledImage = [HNUploadImage ScaledImage:image scale:0.5];
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    //[self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];;
    [HNUploadImage UploadImage:scaledImage block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (msg) {
            self.imageName = msg;
            self.image = image;
            [self.uploadButton setImage:self.image forState:UIControlStateNormal];
        }
    }];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.frame = self.view.bounds;
    self.commitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:NSLocalizedString(@"申请退款", nil) forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitView addSubview:purchase];
    [self.tableView addSubview:self.commitView];
    [self movewButton];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.commitView removeFromSuperview];
}

-(void)movewButton
{
    CGSize size = self.tableView.contentSize;
    self.commitView.top = size.height;
    self.contentSizeHeight = size.height + self.commitView.height;
    self.tableView.contentSize = CGSizeMake(size.width, self.contentSizeHeight);
}

#pragma mark - textField


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width,self.contentSizeHeight +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.tableView];//把当前的textField的坐标映射到scrollview上
    if(self.tableView.contentOffset.y-pt.y+self.navigationController.navigationBar.height<=0)//判断最上面不要去滚动
        [self.tableView setContentOffset:CGPointMake(0, pt.y-self.navigationController.navigationBar.height) animated:YES];//华东
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{

    [UIView animateWithDuration:0.30f animations:^{
        self.tableView.frame = self.view.bounds;
        self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width,self.contentSizeHeight);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        
        return 3;
    }
    else if(3==section)
        return 1;
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
        label.text = self.temporaryModel.refundModel.roomName;
    }else if(section == 1)
    {
        label.text = NSLocalizedString(@"可退款", nil);
    }
    else if(section == 2)
    {
        label.text = NSLocalizedString(@"罚款", nil);
    }
    else if(section == 3)
    {
        label.text = NSLocalizedString(@"回收照片", nil);
    }
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
    if(3==indexPath.section)
    {
        if (indexPath.row==3) {
            return 40;
        }
        else
        {
            if (self.imageName&&self.imageName.length>0) {
                return 97;
            }
            else return 40;
        }
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *identy = @"refun1Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *titleString = nil;
            NSString *detailString = nil;
            switch (indexPath.row) {
                case 0:
                {
                    titleString = @"可退款金额：";
                    detailString = [NSString stringWithFormat:@"¥ %@",self.temporaryModel.projectrefund];
                }
                    break;
                case 1:
                {
                    titleString = @"罚款金额：";
                    detailString = [NSString stringWithFormat:@"¥ %@",self.temporaryModel.finefund];
                }
                    break;
                case 2:
                {
                    titleString = @"出入证数量：";
                    detailString = self.temporaryModel.cardnumber;
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
        case 3:
        {
            UITableViewCell *cell = nil;
            switch (indexPath.row) {
                case 2:
                {
                    static NSString *identy = @"refun3_0Cell";
                    HNRefundCardCountTableViewCell *cardCell = [tableView dequeueReusableCellWithIdentifier:identy];
                    if (!cardCell)
                    {
                        cardCell = [[HNRefundCardCountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
                    }
                    cell = cardCell;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cardCell.title.text = @"回收出入证数量:";
                    self.cardMunTextField = cardCell.card;
                    self.cardMunTextField.delegate = self;
                    self.cardMunTextField.inputAccessoryView = self.topView;
                }
                    break;
                case 0:
                {
                    static NSString *identy = @"refun3_1Cell";
                    HNPicTableViewCell* imageCell = [tableView dequeueReusableCellWithIdentifier:identy];
                    if (!imageCell)
                    {
                        imageCell = [[HNPicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
                    }
                    cell = imageCell;
                    imageCell.name.text = @"回收照片";
                    [imageCell setImages:self.imageName];
                    imageCell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
            
        default:
        {
            static NSString *identy = @"refun1Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
            break;
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
