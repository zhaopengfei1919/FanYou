//
//  FYInformationViewController.h
//  FanYou
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FYInformationViewController : UIViewController{
    UIImagePickerController *Picker;
    BOOL ststushidden;
}
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
- (IBAction)btnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *SexLabel;
@property (weak, nonatomic) IBOutlet UILabel *CardLabel;




@end
