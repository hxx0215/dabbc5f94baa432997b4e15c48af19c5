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

@interface HNDecorateChoiceView()<UIPickerViewDelegate,UIPickerViewDataSource>
//@property (nonatomic, strong) UITextField* textFiled;
@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UIButton* selectButton;
@property (strong, nonatomic) UIPickerView *selectPicker;
@property (nonatomic, strong) UIView *backPickerview;
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
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectButton.frame=CGRectMake(0, 0, self.width, self.height);
    [self addSubview:self.selectButton];
    self.selectButton.layer.cornerRadius = 5.0;
    self.selectButton.backgroundColor = [UIColor clearColor];
    self.selectButton.layer.borderWidth = 1.0;
    self.selectButton.layer.borderColor = [UIColor colorWithWhite:173.0/255.0 alpha:1.0].CGColor;
    [self.selectButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    //self.selectButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.selectButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    CGRect rect = [[[UIApplication sharedApplication] keyWindow]bounds];
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, rect.size.height-216-30, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    
    
    self.backPickerview = [[UIView alloc]initWithFrame:rect];
    self.backPickerview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickView)];
    [self.backPickerview addGestureRecognizer:singleTap];
    self.selectPicker = [[UIPickerView alloc]init];
    self.selectPicker.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    self.selectPicker.delegate = self;
    self.selectPicker.dataSource = self;
    self.selectPicker.frame = CGRectMake(0, rect.size.height-216, 320, 216);
    self.selectPicker.hidden = NO;
    [self.backPickerview addSubview:topView];
    [self.backPickerview addSubview:self.selectPicker];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backPickerview];
    
    self.decorateList = [[NSMutableArray alloc]init];
    

    //self.textFiled.inputAccessoryView = topView;
    //self.textFiled.placeholder = @"请选择";
    
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

-(void)hidePickView
{
    self.backPickerview.hidden = YES;
}

-(void)btnClick
{
    self.backPickerview.hidden = NO;
}


-(void)doneChoice
{
    [self hidePickView];
    NSInteger row = [self.selectPicker selectedRowInComponent:0];
    HNDecorateChoiceModel *model = (HNDecorateChoiceModel*)[self.decorateList objectAtIndex:row];
    [self.selectButton setTitle:model.roomName forState:UIControlStateNormal];
    //self.textFiled.text = model.roomName;
    if (!self.delegate) {
        return;
    }
    if (model.ownername) {
        if ([self.delegate respondsToSelector:@selector(updataDecorateInformation:)])
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
                if ([self.delegate respondsToSelector:@selector(updataDecorateInformation:)])
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
