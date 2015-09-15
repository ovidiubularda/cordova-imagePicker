//
//  ViewController.m
//  ImagePicker
//
//  Created by Ovidiu Bularda on 12.09.15.
//  Copyright (c) 2015 Qualitance. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <QBImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)open:(id)sender {
    
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.mediaType = QBImagePickerMediaTypeAny;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.showsNumberOfSelectedAssets = YES;

    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    
    NSLog(@"Selected assets:");
    NSLog(@"%@", assets);
    NSMutableArray *resultStrings = [[NSMutableArray alloc] init];
    
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.synchronous = YES;

    float width = 375;
    __block float height = 500;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        // Perform async operation
        // Call your method/function here
        // Example:
        
        for (PHAsset *asset in assets) {
            // Do something with the asset
            if(asset.mediaType == PHAssetMediaTypeImage)
            {
//                [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
//                    
//                    UIImage *image = [UIImage imageWithData:imageData];
//                    // NSString *imgData = [self encodeToBase64String:image];
//                    [resultStrings addObject:image];
//                }];
                
                
                float imageWidth =  asset.pixelWidth;
                float imageHeight = asset.pixelHeight;
                CGSize newImageSize;
                
                // Keep aspect ratio
                if(width){
                    height = (width * imageHeight) / imageWidth;
                    newImageSize = CGSizeMake(width, height);
                }
                else{
                    newImageSize = CGSizeMake(imageWidth, imageHeight);
                }
                
                // Resize the image
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:newImageSize contentMode:PHImageContentModeAspectFit options:imageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                    
                    [resultStrings addObject:[self encodeToBase64String:result]];
                }];
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Update UI
            // Example:
            // self.myLabel.text = result;
            [self dismissViewControllerAnimated:YES completion:NULL];
        });
    });
    
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Canceled.");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
