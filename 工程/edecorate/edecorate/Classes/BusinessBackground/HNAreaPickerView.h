//
//  HZAreaPickerView.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNBusinessBackgroundModel.h"

typedef enum {
    HNAreaPickerWithStateAndCity,
    HNAreaPickerWithStateAndCityAndDistrict
} HNAreaPickerStyle;

@class HNAreaPickerView;

@protocol HNAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(HNAreaPickerView *)picker;

@end

@interface HNAreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (assign, nonatomic) id <HNAreaPickerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (strong, nonatomic) HNLocation *locate;
@property (nonatomic) HNAreaPickerStyle pickerStyle;

- (id)initWithStyle:(HNAreaPickerStyle)pickerStyle delegate:(id <HNAreaPickerDelegate>)delegate;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
