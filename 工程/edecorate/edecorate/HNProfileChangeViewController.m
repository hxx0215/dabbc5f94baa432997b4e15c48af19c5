//
//  ProfileChangeViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNProfileChangeViewController.h"
#import "HNAreaPickerView.h"

@interface HNProfileChangeViewController ()<UITextFieldDelegate, HNAreaPickerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (retain, nonatomic) IBOutlet UITextField *cityText;
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HNAreaPickerView *locatePicker;
@property (strong, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopkeeperTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *onlineServiceTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopkeeperLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *onlineServiceLabel;
@end

@implementation HNProfileChangeViewController
@synthesize areaText;
@synthesize cityText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.areaText.delegate = self;
}


-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        _areaValue = areaValue;
        self.areaText.text = areaValue;
    }
}

-(void)setCityValue:(NSString *)cityValue
{
    if (![_cityValue isEqualToString:cityValue]) {
        _cityValue = cityValue;
        self.cityText.text = cityValue;
    }
}

- (void)viewDidUnload
{
    [self setAreaText:nil];
    [self setCityText:nil];
    [self cancelLocatePicker];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HNAreaPickerView *)picker
{
    if (picker.pickerStyle == HNAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    } else{
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.areaText]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HNAreaPickerView alloc] initWithStyle:HNAreaPickerWithStateAndCityAndDistrict delegate:self];
        [self.locatePicker showInView:self.view];
    } else {
        [self cancelLocatePicker];
        self.locatePicker = [[HNAreaPickerView alloc] initWithStyle:HNAreaPickerWithStateAndCity delegate:self];
        [self.locatePicker showInView:self.view];
    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
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
