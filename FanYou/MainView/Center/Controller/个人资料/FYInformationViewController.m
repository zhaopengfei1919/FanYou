//
//  FYInformationViewController.m
//  FanYou
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYInformationViewController.h"
#import "FYChangeNameViewController.h"
#import "FYChangePwdViewController.h"

NSString *UPLOAD_IMG=@"";
@interface FYInformationViewController ()<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation FYInformationViewController
-(void)userdetail{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    
    [NetWorkManager requestWithMethod:POST Url:UserDetail Parameters:paraDic success:^(id responseObject) {
        NSDictionary * result = [responseObject objectForKey:@"result"];
        if ([result count] == 0) {
            return;
        }
        [weakself.headerImage sd_setImageWithURL:[NSURL URLWithString:[result safeObjectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"默认头像-"]];
        weakself.nickName.text = [result safeObjectForKey:@"nickname"];
        weakself.NameLabel.text = [result safeObjectForKey:@"name"];
        weakself.PhoneLabel.text = [result safeObjectForKey:@"user_phone"];
        weakself.CardLabel.text = [result safeObjectForKey:@"id_card_no"];
        NSString * gender = [result safeObjectForKey:@"gender"];
        if ([gender isEqualToString:@""]) {
            weakself.SexLabel.text = @"请选择";
        }else if ([gender intValue] == 1) {
            weakself.SexLabel.text = @"男";
        }else
            weakself.SexLabel.text = @"女";
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self userdetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)btnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 1) {
        [self headerbtn];
    }else if (btn.tag == 2){
        FYChangeNameViewController * change = [[FYChangeNameViewController alloc]init];
        change.nickname = self.nickName.text;
        [self.navigationController pushViewController:change animated:YES];
    }else if (btn.tag == 3){

    }else if (btn.tag == 4){
        
    }else if (btn.tag == 5){
        [self changeSex];
    }else if (btn.tag == 6){
        
    }else if (btn.tag == 7){
        FYChangePwdViewController *changepwd = [[FYChangePwdViewController alloc]init];
        [self.navigationController pushViewController:changepwd animated:YES];
    }
}
-(void)changeSex{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self surechangeSex:@"男"];
    }];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self surechangeSex:@"女"];
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
-(void)surechangeSex:(NSString *)sex{
    
}
-(void)headerbtn{
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
    }else
    {
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
        
        self.headerImage.image = image;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        NSMutableDictionary * oderParams = [[NSMutableDictionary alloc] init];
        [oderParams setObject:[FYUser userInfo].userId forKey:@"user_id"];
        NSData * data = UIImageJPEGRepresentation(image, 0.4);
        [oderParams setObject:data forKey:@"avatar"];
        
//        WS(weakself);
        [NetWorkManager requestWithMethod:POST Url:SetAvatar Parameters:oderParams success:^(id responseObject) {
            NSString * succeeded = [responseObject objectForKey:@"succeeded"];
            if ([succeeded intValue] == 1) {
                
            }else
                [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        } requestRrror:^(id requestRrror) {
        }];
    }
}
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.01);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    UPLOAD_IMG=fullPathToFile;
    [imageData writeToFile:fullPathToFile atomically:NO];
}
@end
