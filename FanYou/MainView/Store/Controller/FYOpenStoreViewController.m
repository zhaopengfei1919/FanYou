//
//  FYOpenStoreViewController.m
//  FanYou
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOpenStoreViewController.h"

NSString *UPLOAD_IMAGE=@"";

@interface FYOpenStoreViewController ()<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation FYOpenStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请开店";
    ishaveimage = NO;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, 240, 40);
    [self.SureBtn.layer addSublayer:gradientLayer];
    
    self.DescTextview.placeholder = @"限160个字符";
    self.DescTextview.layer.cornerRadius = 2;
    self.DescTextview.layer.borderWidth = 0.5;
    self.DescTextview.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.TitleTF) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 32) {
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.DescTextview resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ChosenImage:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self LocalPhoto];
    }];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self takePhoto];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [otherAction setValue:UIColorFromRGB(0x2a57d8) forKey:@"titleTextColor"];
    [SureAction setValue:UIColorFromRGB(0x2a57d8) forKey:@"titleTextColor"];
    [cancel setValue:UIColorFromRGB(0x2a57d8) forKey:@"titleTextColor"];
    [alertController addAction:otherAction];
    [alertController addAction:SureAction];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        Picker = [[UIImagePickerController alloc] init];
        Picker.delegate = self;
        //设置拍照后的图片可被编辑
        Picker.allowsEditing = YES;
        Picker.sourceType = sourceType;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        ststushidden = YES;
        [self prefersStatusBarHidden];
        [self presentViewController:Picker animated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(BOOL)prefersStatusBarHidden{
    return ststushidden;
}
//打开本地相册
-(void)LocalPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        Picker = [[UIImagePickerController alloc] init];
        Picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        Picker.delegate = self;
        //设置选择后的图片可被编辑
        Picker.allowsEditing = YES;
        [self presentViewController:Picker animated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置-->隐私-->相册，中开启本应用的相册访问权限！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    ststushidden = NO;
    [self prefersStatusBarHidden];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ststushidden = NO;
    [self prefersStatusBarHidden];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image;
        if (info[UIImagePickerControllerEditedImage]) {
            image =info[UIImagePickerControllerEditedImage];
        }
        else
        {
            image = info[UIImagePickerControllerOriginalImage];
        }

        [picker dismissViewControllerAnimated:YES completion:nil];
        ishaveimage = YES;
        [self.ChosenBtn setImage:image forState:0];
    }
}

- (IBAction)sure:(id)sender {
    if (self.TitleTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入店铺名称"];
        return;
    }
    if (self.DescTextview.text.length == 0 || self.DescTextview.text.length > 160) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的店铺描述"];
        return;
    }
    if (!ishaveimage) {
        [SVProgressHUD showErrorWithStatus:@"请选择店铺logo"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.TitleTF.text forKey:@"shop_name"];
    [paraDic setObject:self.DescTextview.text forKey:@"desc"];
//    [paraDic setObject:[FYUser userInfo].userId forKey:@"is_mine"];
    [paraDic setObject:[NSNumber numberWithInt:1] forKey:@"is_hot"];
    
    NSData * data = UIImageJPEGRepresentation(self.ChosenBtn.imageView.image, 0.4);
    [paraDic setObject:data forKey:@"shop_logo"];
    
    self.SureBtn.enabled = NO;
    [NetWorkManager requestWithMethod:POST Url:ShopOpen Parameters:paraDic success:^(id responseObject) {
        self.SureBtn.enabled = YES;
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"开店成功"];
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
        
    }];
}
@end
