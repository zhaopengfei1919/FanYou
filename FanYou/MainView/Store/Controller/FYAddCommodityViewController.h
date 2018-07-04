//
//  FYAddCommodityViewController.h
//  FanYou
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYAddCommodityViewController : UIViewController{
    UIImagePickerController *Picker;
    BOOL ststushidden;
    BOOL ishaveimage;
}
@property (weak, nonatomic) IBOutlet UITextField *TitleTF;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *DescTextView;
@property (weak, nonatomic) IBOutlet UITextField *PriceTF;

- (IBAction)ChosenImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ChosenBtn;

- (IBAction)sure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;

@property (strong ,nonatomic) NSNumber * shopId;
@end
