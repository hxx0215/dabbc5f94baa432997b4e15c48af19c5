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

@interface HNNewCheckViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HNDecorateChoiceViewDelegate>
@property (nonatomic, strong) HNDecorateChoiceView *pickView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIButton *submit;
@property (nonatomic, strong) NSString *curDeclareId;
@property (nonatomic, strong) NSIndexPath *curIndexPath;
@end

@implementation HNNewCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pickView = [[HNDecorateChoiceView alloc] initWithFrame:CGRectMake(12, 12, self.view.width - 24, 25)];
    self.pickView.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.pickView.bottom + 5, self.view.width, 300)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submit setTitle:@"提交" forState:UIControlStateNormal];
    self.submit.backgroundColor = [UIColor orangeColor];
    self.submit.width = 100;
    self.submit.height = 60;
    self.submit.right = self.view.right - 5;
    [self.submit addTarget:self action:@selector(submitData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submit];
    [self.view addSubview:self.pickView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.submit.centerY = self.tableView.bottom +(self.view.height - self.tableView.bottom) / 2;
}
- (void)updataDecorateInformation:(HNDecorateChoiceModel *)model{
    if (!model || [model.declareId isEqualToString:@""]){
        [self showNoData];
    }else{
        NSDictionary *sendDic = @{@"mshopid": [[HNLoginData shared] mshopid],@"declareid" : model.declareId};
        self.curDeclareId = model.declareId;
        NSString *sendJson = [sendDic JSONString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.acceptance.details" Params:sendJson]];
        NSString *contentType = @"text/html";
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
            [self performSelectorOnMainThread:@selector(testOnMain:) withObject:data waitUntilDone:YES];
        }];
    }
}
- (void)testOnMain:(NSData *)data{
    if (data){
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSDictionary *retDic = [retJson objectFromJSONString];
        NSInteger count = [[retDic objectForKey:@"total"] integerValue];
        if (0 != count){
            [self.dataArr removeAllObjects];
            self.dataArr = [[retDic objectForKey:@"data"] mutableCopy];
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
        else{
            [self.dataArr removeAllObjects];
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            [self showNoData];
        }
    }else{
        [self showNoNet];
    }
}
- (void)showNoNet{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//    [alert show];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
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
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 50)];
    view.backgroundColor = [UIColor colorWithRed:144/255.0 green:197/255.0 blue:31/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.0];
    label.text = [self.dataArr[section] objectForKey:@"typename"];
    [label sizeToFit];
    [view addSubview:label];
    label.left = 5;
    label.centerY = view.height / 2;
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArr[section] objectForKey:@"ItemBody"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"newCheckCell";
    HNNewCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNNewCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.name.text = [[self.dataArr[indexPath.section] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodyname"];
    cell.type = [[self.dataArr[indexPath.section] objectForKey:@"ItemBody"][indexPath.row] objectForKey:@"bodytype"];
    cell.itemId =[self.dataArr[indexPath.section] objectForKey:@"itemId"];
    return cell;
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
    self.curIndexPath = indexPath;
    HNNewCheckTableViewCell *cell = (HNNewCheckTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([cell.type isEqualToString:@"2"]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate = self;
        picker.allowsEditing = NO;
        self.view.userInteractionEnabled = NO;
        [self presentViewController:picker animated:YES completion:^{
            self.view.userInteractionEnabled = YES;
        }];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *scaledImage = [HNUploadImage ScaledImage:image scale:0.5];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Uploading", nil);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [HNUploadImage UploadImage:scaledImage block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            });
        }
    }];
}
@end
