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

@interface HNDecorateChoiceView()<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UITextField* textFiled;
@property (nonatomic, strong) UIButton* button;
@property (strong, nonatomic) UIPickerView *selectPicker;
@end

@implementation HNDecorateChoiceView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UIImage* image = [UIImage imageNamed:@"down_box_triangle.png"];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(self.width-image.size.width-10, (self.height-image.size.height)/2.0, image.size.width, image.size.height);
    [self.button setImage:image forState:UIControlStateNormal];
    [self addSubview:self.button];
    
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:self.textFiled];
    self.textFiled.delegate = self;
    self.textFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.textFiled.backgroundColor = [UIColor clearColor];
    
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
    self.textFiled.placeholder = @"请选择";
    
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
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
        
    }];

    return self;
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.decorateList count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    HNDecorateChoiceModel *model = (HNDecorateChoiceModel*)[self.decorateList objectAtIndex:row];
    return model.roomName;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger row = [self.selectPicker selectedRowInComponent:0];
    HNDecorateChoiceModel *model = (HNDecorateChoiceModel*)[self.decorateList objectAtIndex:row];
    self.textFiled.text = model.roomName;
    if (!self.delegate) {
        return;
    }
    if (model.ownername) {
        [self.delegate updataDecorateInformation:model];
        return;
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    [[HNDecorateData shared] loadingDetail:[HNLoginData shared].mshopid declare:model.declareId block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
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
                NSArray *dataArr = [dic objectForKey:@"data"];
                NSDictionary *dicData = [dataArr objectAtIndex:0];
                model.ownername = [dicData objectForKey:@"ownername"];
                model.ownerphone = [dicData objectForKey:@"ownerphone"];
                
                [self.delegate updataDecorateInformation:model];
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
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
