

#import "ViewController.h"
#import "AFNetworking.h"


@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) UIImagePickerController *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    BOOL isPicker = NO;
    
    switch (sender.tag) {
        case 10000:
//            打开相机
            isPicker = true;
//            判断相机是否可用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                isPicker = true;
            }
            break;
            
        case 10001:
//            打开相册
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            isPicker = true;
            break;
            
        default:
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            isPicker = true;
            break;
    }
    
    if (isPicker) {
        [self presentViewController:self.picker animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
    }
    return _picker;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image2 = info[UIImagePickerControllerOriginalImage];
    self.image.image = image2;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //网址
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        
        [manager POST:@"http://112.74.67.161:8080/" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //测试
            NSString * imgpath = [NSString stringWithFormat:@"%@",self.image.image];
            
            UIImage *image = [UIImage imageWithContentsOfFile:imgpath];
            NSData *data = UIImageJPEGRepresentation(image,0.7);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:data name:@"Filedata" fileName:fileName mimeType:@"image/jpg"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //成功 后处理,处理返回数据
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            NSLog(@"Success: %@", responseObject);
            
            NSString * str = [responseObject objectForKey:@"fileId"];
            if (str != nil) {
    //            [self.delegate uploadImgFinish:str];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //失败
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
            NSLog(@"Error: %@", error);
        }];
        
    
    
//    获取图片

//    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
