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

@interface HNDecoratePayModel()
@end
@implementation HNDecoratePayModel

-(void)updataDic:(NSDictionary *)dic;
{
    self.dic = dic;
    
    [self setValue:[dic objectForKey:@"bank_type"] forKey:@"bank_type"];
    [self setValue:[dic objectForKey:@"bargainor_id"] forKey:@"bargainor_id"];
    [self setValue:[dic objectForKey:@"callback_url"] forKey:@"callback_url"];
    [self setValue:[dic objectForKey:@"charset"] forKey:@"charset"];
    [self setValue:[dic objectForKey:@"desc"] forKey:@"desc"];
    [self setValue:[dic objectForKey:@"notify_url"] forKey:@"notify_url"];
    [self setValue:[dic objectForKey:@"sp_billno"] forKey:@"sp_billno"];
    [self setValue:[dic objectForKey:@"total_fee"] forKey:@"total_fee"];
    
    [self setValue:[dic objectForKey:@"ver"] forKey:@"ver"];
    [self setValue:[dic objectForKey:@"mysign"] forKey:@"mysign"];
    [self setValue:[dic objectForKey:@"privateKey"] forKey:@"privateKey"];
    
}
-(NSString *)getToken
{
    NSString * ONLINE_PAY_KEY = @"key";
    NSString * ONLINE_PAY_INIT = @"https://www.tenpay.com/app/mpay/wappay_init.cgi";
    NSString * ONLINE_PAY = @"https://www.tenpay.com/app/mpay/mp_gate.cgi";
    NSString * ADDRESS_CONNECTOR = @"?";
    NSString * PARAM_CONNECTOR = @"&";
    NSString * VALUES_CONNECTOR = @"=";
    NSString * ONLINE_PAY_SIGN = @"sign";
    NSString * ONLINE_PAY_TOKEN = @"token_id";
    
    NSString *str = nil;
    
    
    NSString *m_Ver = [NSString stringWithFormat:@"%@=%@",@"ver",self.ver];
    NSString *m_CharSet = [NSString stringWithFormat:@"%@=%@",@"charset",self.charset];
    NSString *m_Bank_Type = [NSString stringWithFormat:@"%@=%@",@"bank_type",self.bank_type];
    NSString *m_Desc = [NSString stringWithFormat:@"%@=%@",@"desc",self.desc];
    NSString *m_Bargainor = [NSString stringWithFormat:@"%@=%@",@"bargainor_id",self.bargainor_id];
    NSString *m_Billno = [NSString stringWithFormat:@"%@=%@",@"sp_billno",self.sp_billno];
    NSString *m_Total = [NSString stringWithFormat:@"%@=%ld",@"total_fee",self.total_fee.integerValue];
    NSString *m_FeeType = [NSString stringWithFormat:@"%@=%@",@"fee_type",@"1"];
    NSString *m_Notify = [NSString stringWithFormat:@"%@=%@",@"notify_url",self.notify_url];
    NSString *m_Callback = [NSString stringWithFormat:@"%@=%@",@"callback_url",self.callback_url];
    
    NSArray *keys = [NSArray arrayWithObjects:m_Ver,m_CharSet,m_Bank_Type,m_Desc,m_Bargainor,m_Billno,m_Total,m_FeeType,m_Notify,m_Callback, nil];
    
    NSComparator cmptr = ^(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        switch(result)
        {
            case NSOrderedAscending:
                return NSOrderedAscending;
            case NSOrderedDescending:
                return NSOrderedDescending;
            case NSOrderedSame:
                return NSOrderedSame;
            default:
                return NSOrderedSame;
        }
    };
    NSArray *sortArray = [keys sortedArrayUsingComparator:cmptr];
    NSString *desString = nil;
    for (int i=0; i<sortArray.count; i++) {
        NSString *sstring = [sortArray objectAtIndex:i];
        if (desString) {
            desString = [NSString stringWithFormat:@"%@%@%@",desString,sstring,PARAM_CONNECTOR];
        }
        else
            desString = [NSString stringWithFormat:@"%@%@",sstring,PARAM_CONNECTOR];
    }
    
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",desString,ONLINE_PAY_KEY,VALUES_CONNECTOR,self.mysign];
    NSLog(@"%@",sign);
    sign = [[sign stringFromMD5] uppercaseString];
    
    
    NSString *param = [NSString stringWithFormat:@"%@%@%@%@",desString,ONLINE_PAY_SIGN,VALUES_CONNECTOR,sign];
    str = [NSString stringWithFormat:@"%@%@%@",ONLINE_PAY_INIT,ADDRESS_CONNECTOR,param];
    
//    param += ONLINE_PAY_SIGN + VALUES_CONNECTOR + sign;
//    return ONLINE_PAY_INIT + ADDRESS_CONNECTOR
//    + param;
    return str;
}

@end


@implementation HNDecorateChoiceModel
@end

@interface HNDecorateChoiceView()<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
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
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice)];
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

-(void)doDecorateData:(NSData *)data
{
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
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
                model.status = [dataArr[i] objectForKey:@"assessorstate"];
                model.roomName = [NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"roomnumber"]];
                model.declareId = [dataArr[i] objectForKey:@"declareId"];
                [self.decorateList addObject:model];
            }
            [self.selectPicker reloadAllComponents];
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
    if(!self.updataDecorateInformation)
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

-(void)doLoadingPay:(NSData *)data
{
    [MBProgressHUD hideHUDForView:self.superview animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSInteger count = [[dic objectForKey:@"total"] integerValue];
        if (0!=count)
        {
            HNDecoratePayModel *pay = [[HNDecoratePayModel alloc]init];
            self.model.payModel = pay;
            NSArray *dataArr = [dic objectForKey:@"data"];
            NSDictionary *dicData = [dataArr objectAtIndex:0];
            [pay updataDic:dicData];
            
            
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
    
    if ([self.delegate respondsToSelector:@selector(didGetPayToken:)])
    {
        [self.delegate didGetPayToken:[self.model.payModel getToken]];
    }
}

-(void) getPayToken:(NSString*)connid
{
    if (self.payType) {
        NSMutableDictionary *sendDic = [[NSMutableDictionary alloc] init];
        [sendDic setObject:[HNLoginData shared].mshopid forKey:@"mshopid"];
        [sendDic setObject:self.model.declareId forKey:@"id"];
        [sendDic setObject:connid forKey:@"connid"];
        [sendDic setObject:[NSNumber numberWithInteger:(self.payType-1)]forKey:@"type"];
        NSString *sendJson = [sendDic JSONString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.pay.info" Params:sendJson]];
        NSString *contentType = @"text/html";
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
            
            [self performSelectorOnMainThread:@selector(doLoadingPay:) withObject:data waitUntilDone:YES];
        }];
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
