//
//  HNDecorateChoiceView.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-29.
//
//

#import "HNDecorateChoiceView.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "NSString+Crypt.h"
#import "HNLoginData.h"

@implementation HNDecorateChoiceModel
@end

@interface HNDecorateChoiceView()<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,HNDecoratePayModelDelegate>
@property (nonatomic, strong) UITextField* textFiled;
@property (nonatomic, strong) UIButton* button;
@property (strong, nonatomic) UIPickerView *selectPicker;
@end

@implementation HNDecorateChoiceView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.updataDecorateInformation = FALSE;
    UIImage* image = [UIImage imageNamed:@"down_box_triangle.png"];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(self.width-image.size.width-10, (self.height-image.size.height)/2.0, image.size.width, image.size.height);
    [self.button setImage:image forState:UIControlStateNormal];
    [self addSubview:self.button];
    
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:self.textFiled];
    self.textFiled.delegate = self;
    self.textFiled.borderStyle = UITextBorderStyleNone;
    self.textFiled.backgroundColor = [UIColor clearColor];
    self.textFiled.font = [UIFont systemFontOfSize:15];
    self.textFiled.textColor = [UIColor whiteColor];
    
    self.selectPicker = [[UIPickerView alloc]init];
    self.textFiled.inputView = self.selectPicker;
    //self.textFiled.inputAccessoryView = doneToolbar;
    self.selectPicker.delegate = self;
    self.selectPicker.dataSource = self;
    self.selectPicker.frame = CGRectMake(0, 480, 320, 216);
    self.decorateList = [[NSMutableArray alloc]init];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    self.textFiled.inputAccessoryView = topView;
    self.textFiled.placeholder = @"请选择地址";
    
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(doDecorateData:) withObject:data waitUntilDone:YES];
    }];
    
    self.payType = KHNPayTypeNo;
    
    return self;
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
-(void)doDecorateData:(NSData *)data
{
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
        NSInteger count = [[dic objectForKey:@"total"] integerValue];
        if (0!=count)
        {
            NSArray *dataArr = [dic objectForKey:@"data"];
            [self.decorateList removeAllObjects];
            for (int i=0; i<count; i++) {
                HNDecorateChoiceModel *model = [[HNDecorateChoiceModel alloc] init];
                model.alldata = [dataArr[i] copy];
                model.assessorstate = [dataArr[i] objectForKey:@"assessorstate"];
                model.processstep = [dataArr[i] objectForKey:@"processstep"];
                model.paystate = [dataArr[i] objectForKey:@"paystate"];
                model.createTime = [dataArr[i] objectForKey:@"createTime"];
                model.roomName = [NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"roomnumber"]];
                model.declareId = [dataArr[i] objectForKey:@"declareId"];
                if (model.processstep.integerValue != 0 && model.assessorstate.integerValue !=0 && model.paystate.integerValue!=0)
                    [self.decorateList addObject:model];
            }
            [self.selectPicker reloadAllComponents];
        }
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

-(void)doneChoice
{
    [self.textFiled resignFirstResponder];
}


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if (self.delegate) {
//        <#statements#>
//    }
//    return NO;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    HNDecorateChoiceModel *model = (HNDecorateChoiceModel*)[self.decorateList objectAtIndex:row];
    label.text = model.roomName;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.decorateList count];
}
//-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    HNDecorateChoiceModel *model = (HNDecorateChoiceModel*)[self.decorateList objectAtIndex:row];
//    return model.roomName;
//}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger row = [self.selectPicker selectedRowInComponent:0];
    self.model = (HNDecorateChoiceModel*)[self.decorateList objectAtIndex:row];
    self.textFiled.text = self.model.roomName;
    
    
    if (!self.delegate) {
        return;
    }
    //if(!self.updataDecorateInformation)
    {
        [self.delegate updataDecorateInformation:self.model];
        return;
    }
    
    if (self.model.ownername) {
        if ([self.delegate respondsToSelector:@selector(updataDecorateInformation:)])
        {
            [self.delegate updataDecorateInformation:self.model];
        }
        return;
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    [[HNDecorateData shared] loadingDetail:[HNLoginData shared].mshopid declare:self.model.declareId block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
//        [self performSelector:@selector(doLoadingDetail:) withObject:data afterDelay:YES];
        [self performSelectorOnMainThread:@selector(doLoadingDetail:) withObject:data waitUntilDone:YES];
    }];
}

-(void)doLoadingDetail:(NSData *)data
{
    
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr){
            [self showBadServer];
            return;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        //NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSInteger count = [[dic objectForKey:@"total"] integerValue];
        if (0!=count)
        {
            NSArray *dataArr = [dic objectForKey:@"data"];
            NSDictionary *dicData = [dataArr objectAtIndex:0];
            self.model.ownername = [dicData objectForKey:@"ownername"];
            self.model.ownerphone = [dicData objectForKey:@"ownerphone"];
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
    
        [MBProgressHUD hideHUDForView:self.superview animated:YES];
        [self.delegate updataDecorateInformation:self.model];
}



-(void) getPayToken:(NSString*)connid
{
    [HNPaySupport shared].delegate = self;
    [[HNPaySupport shared] getPayToken:self.model.declareId cid:connid payType:self.payType];
}

- (void)didGetPayUrl:(NSString*)url
{
    if ([self.delegate respondsToSelector:@selector(didGetPayToken:)])
    {
        [self.delegate didGetPayToken:url];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
