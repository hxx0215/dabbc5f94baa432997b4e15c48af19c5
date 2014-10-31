//
//  HNRefundApplyViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import "HNRefundApplyViewController.h"
#import "HNDecorateChoiceView.h"

@interface HNRefundApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,HNDecorateChoiceViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;

@property (nonatomic, strong)UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet HNDecorateChoiceView *choiceDecorateView;
@end

@implementation HNRefundApplyViewController

-(id)init
{
    self = [super init];
    self.temporaryModel = [[HNRefundData alloc]init];
    
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
    
    self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 25)];
    [self.view addSubview:self.choiceDecorateView];
    self.choiceDecorateView.delegate = self;
}

- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
//    self.houseInfLabel.text = model.roomName;
//    self.ownersPhoneNumberLabel.text = model.ownerphone;
//    self.ownersLabel.text = model.ownername;
//    [self.ownersPhoneNumberLabel sizeToFit];
//    [self.ownersLabel sizeToFit ];
//    self.ownersPhoneNumberLabel.right = self.view.width - 14;
//    self.ownersLabel.right = self.ownersPhoneNumberLabel.left-5;
    self.temporaryModel.declareId = model.declareId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commit:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"已提交审核" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag=1;
    [alert show];
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
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    //[self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];;
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
