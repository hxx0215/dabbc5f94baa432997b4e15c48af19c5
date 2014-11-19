//
//  HNNewCheckViewController.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNNewCheckViewController.h"
#import "HNDecorateChoiceView.h"
#import "HNLoginData.h"
#import "HNNewCheckTableViewCell.h"
#import "HNUploadImage.h"
#import "MBProgressHUD.h"
@interface HNSeprateCheckView : UIView
@property (nonatomic, weak) UIView *hiddenWith;
@property (nonatomic, weak) UIView *hiddenWith2;
@end

@implementation HNSeprateCheckView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
    self.hiddenWith.hidden = YES;
    self.hiddenWith2.hidden = YES;
}
@end
@interface HNNewCheckViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSString *curDeclareId;
@property (nonatomic, strong) NSIndexPath *curIndexPath;
@property (nonatomic, strong) NSMutableArray *pickViewData;
@property (nonatomic, assign) NSInteger curPickViewIndex;
@property (nonatomic, assign) BOOL firstIn;
@property (nonatomic, strong) UIPickerView *listPick;
@property (nonatomic, strong) HNSeprateCheckView *sepView;
@property (nonatomic, strong) UIButton *showPick;
@property (nonatomic, strong) NSMutableDictionary *imageSet;
@end

@implementation HNNewCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.pickViewData = [[NSMutableArray alloc] init];
    self.dataArr = [[NSMutableArray alloc] init];
    self.imageSet = [[NSMutableDictionary alloc] init];
    self.firstIn = YES;
    [self initPickView];
    [self loadList];
}
- (void)initPickView{
    self.listPick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.height - 216, self.view.width, 216)];
    self.sepView = [[HNSeprateCheckView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 216)];
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
    self.showPick = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.showPick addTarget:self action:@selector(showPick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)loadList{
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0 != count){
                [self.pickViewData removeAllObjects];
                for (int i=0;i<count;i++){
                    int processstep = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"processstep"] integerValue];
                    if (processstep != 0)
                    {
                        [self.pickViewData addObject:[[retDic objectForKey:@"data"] objectAtIndex:i]];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.showPick setTitle:[self.pickViewData[0] objectForKey:@"roomnumber"] forState:UIControlStateNormal];
                    self.curPickViewIndex = 0;
                    [self loadTableData:[self.pickViewData[0] objectForKey:@"declareId"]];
                });
            }
        }
    }];
    
}
- (void)loadTableData:(NSString *)declareId{
    if (!declareId || [declareId isEqualToString:@""])
        return ;
    NSDictionary *sendDic = @{@"mshopid": [HNLoginData shared].mshopid,@"declareid" : declareId};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.acceptance.details" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0 != count){
                [self.dataArr removeAllObjects];
                for (int i = 0;i<count;i++)
                    [self.dataArr addObject:[[retDic objectForKey:@"data"] objectAtIndex:i]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
            else
                [self showNoData];
        }else
            [self showNoNet];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    self.listPick.bottom = self.view.height;
    self.sepView.top = 0;
    self.sepView.height = self.view.height - self.listPick.height;
    if (self.firstIn){
        self.firstIn = NO;
        if ([self.pickViewData count]>0){
            self.curPickViewIndex = 0;
            [self.showPick setTitle:[self.pickViewData[0] objectForKey:@"roomnumber"] forState:UIControlStateNormal];
            [self loadTableData:[self.pickViewData[0] objectForKey:@"declareId"]];
        }
    }
    else{
        [self.tableView reloadData];
    }
}

- (void)showNoNet{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}

- (void)showNoData{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    });
    
//    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    if ([self.pickViewData count]<1)
        return view;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    if (section==0 || (section > 1 &&[ self.dataArr[section - 2] count]==0))
        maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    [view addSubview:contentView];
    UILabel *label = [[UILabel alloc] init];
    if (section == 0)
    {
//        label.text = [self.pickViewData[self.curPickViewIndex] objectForKey:@"roomnumber"];
        self.showPick.frame = contentView.bounds;
        self.showPick.layer.cornerRadius = 7.0;
        [contentView addSubview:self.showPick];
        return view;
    }
    else
    if (section == 1)
        label.text = NSLocalizedString(@"装修验收", nil);
    else
        label.text = [self.dataArr[section - 2] objectForKey:@"typename"];
    [label sizeToFit];
    label.textColor = [UIColor whiteColor];
    label.left = 5;
    label.centerY = contentView.height / 2;
    [contentView addSubview:label];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.pickViewData count]<1) return 0;
    return [self.dataArr count] + 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 0;
    if (section == 1)
        return 2;
    return [[self.dataArr[section - 2] objectForKey:@"ItemBody"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.imageSet objectForKey:indexPath])
        return 84;
    else
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"newCheckCell";
    HNNewCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNNewCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section > 1)
    {
        cell.name.text = [[self.dataArr[indexPath.section - 2] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodyname"];
        cell.type = [[self.dataArr[indexPath.section - 2] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodytype"];
        cell.itemId =[self.dataArr[indexPath.section - 2] objectForKey:@"itemId"];
    }
    else{
        if (indexPath.row == 0){
            cell.name.text = NSLocalizedString(@"施工方备注", nil);
            cell.type = @"1";
            
        }
        else{
            cell.name.text = NSLocalizedString(@"施工方附件", nil);
            cell.type = @"2";
        }
    }
    if ([cell.type isEqualToString:@"2"])
    {
        cell.upload.tag = indexPath.section * 100 + indexPath.row;
        [cell.upload addTarget:self action:@selector(uploadImg:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableArray *imgArr = [self.imageSet objectForKey:indexPath];
        if (imgArr)
        {
            cell.del.hidden = NO;
            cell.curImageView.hidden = NO;
            cell.curImageView.image = imgArr[0];
        }
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
- (void)submitData:(id)sender{
    if ([self.dataArr count]<1)
        return;
    NSMutableDictionary *sendDic = [@{@"declareid": self.curDeclareId, @"processtep" : [self.dataArr[0] objectForKey:@"processtep"],@"shopreason" : @"noreason" ,@"shopaccessory" :@"/Picture/201409/041700468686.jpg"} mutableCopy];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0;i< [self.dataArr count];i++){
        for (int j = 0;j< [[self.dataArr[i] objectForKey:@"ItemBody"] count];j++){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[self.dataArr[i] objectForKey:@"itemId"] forKey:@"itemid"];
            [dic setObject:[[self.dataArr[i] objectForKey:@"ItemBody"][j] objectForKey:@"bodyname"] forKey:@"name"];
            [dic setObject:[[self.dataArr[i] objectForKey:@"ItemBody"][j] objectForKey:@"bodytype"] forKey:@"type"];
            [dic setObject:@"/Picture/201409/041700468686.jpg" forKey:@"img"];
            [arr addObject:dic];
        }
    }
    [sendDic setObject:arr forKey:@"ItemBody"];
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.acceptance.details" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSDictionary *retDic = [retJson objectFromJSONString];
        NSLog(@"%@",[retDic objectForKey:@"error"]);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UIPickerView Delegate && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickViewData count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickViewData[row] objectForKey:@"roomnumber"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.curPickViewIndex = row;
    self.listPick.hidden = YES;
    self.sepView.hidden = YES;
    [self.showPick setTitle:[self.pickViewData[self.curPickViewIndex] objectForKey:@"roomnumber"] forState:UIControlStateNormal];
    [self loadTableData:[self.pickViewData[row] objectForKey:@"declareId"]];
}
#pragma mark - UIImagePickController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSMutableArray *imageArr = [self.imageSet objectForKey:self.curIndexPath];
    if (!imageArr)
        imageArr = [[NSMutableArray alloc] init];
    [imageArr addObject:image];
    [self.imageSet setObject:imageArr forKey:self.curIndexPath];
    [picker dismissViewControllerAnimated:YES completion:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"上传中", nil);
        CGFloat maxWH = 480;
        CGFloat maxImg = MAX(image.size.width, image.size.height);
        CGFloat scale = MIN(1, maxWH / maxImg);
        UIImage *img = [HNUploadImage ScaledImage:image scale:scale];
        [HNUploadImage UploadImage:img block:^(NSString *msg){
            NSLog(@"%@",msg);
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.labelText = NSLocalizedString(@"上传成功", nil);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView reloadData];
            });
        }];
    }];
}
#pragma mark - ButtonActions
- (void)showPick:(UIButton *)sender{
    [self.listPick reloadAllComponents];
    self.listPick.hidden = NO;
    self.sepView.hidden = NO;
}
- (void)uploadImg:(UIButton *)sender{
    NSInteger section = sender.tag / 100;
    NSInteger row = sender.tag % 100;
    self.curIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.view.tag = sender.tag;
    pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:^{
        
    }];
}
@end
