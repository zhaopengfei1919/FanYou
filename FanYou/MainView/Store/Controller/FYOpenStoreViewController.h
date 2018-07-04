//
//  FYOpenStoreViewController.h
//  FanYou
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYOpenStoreViewController : UIViewController{
    UIImagePickerController *Picker;
    BOOL ststushidden;
    BOOL ishaveimage;
}
@property (weak, nonatomic) IBOutlet UITextField *TitleTF;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *DescTextview;

@property (weak, nonatomic) IBOutlet UIButton *ChosenBtn;
- (IBAction)ChosenImage:(id)sender;

- (IBAction)sure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;

@end
