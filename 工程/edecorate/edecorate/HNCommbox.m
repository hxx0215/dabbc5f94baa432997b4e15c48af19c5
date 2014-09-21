//
//  HNCommbox.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import "HNCommbox.h"

@interface HNCommbox()
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) UITextField *textField;
@end
@implementation HNCommbox

@synthesize tv,tableArray,textField;

- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray*)array
{
    tableArray = array;
    if (frame.size.height<200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    NSInteger count = [array count];
    tabheight = 35*count;
    
    frame.size.height = 30.0f;
    frameHeight = tabheight + 27;
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //textField.delegate = self;
    }
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 26, frame.size.width , 0)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor whiteColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        tv.layer.borderWidth = 1;
        tv.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:tv];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width , 27)];
        textField.font = [UIFont systemFontOfSize:12.0f];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField.placeholder = @"点击请选择";
        //textField.userInteractionEnabled = NO;
        textField.borderStyle=UITextBorderStyleNone;//设置文本框的边框风格
        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:textField];
        
    }
    self.backgroundColor = [UIColor whiteColor];
    self.selectRow = -1;
    return self;
}

-(NSString*)currentText
{
    return textField.text;
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoBoardHidden:) name:UIKeyboardWillShowNotification object:nil];
//    return YES;
//}
//
//- (void)keyBoBoardHidden:(NSNotification *)Notification{
//    //[self.textField resignFirstResponder];
//    return;
//}

-(void)dropdown{
    [textField resignFirstResponder];
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        tv.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        tv.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    textField.text = [tableArray objectAtIndex:[indexPath row]];
    showList = NO;
    tv.hidden = YES;
    self.selectRow = indexPath.row;
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
