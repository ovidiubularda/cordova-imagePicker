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
    
    PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.synchronous = YES;
    
    for (PHAsset *asset in assets) {
        // Do something with the asset
        if(asset.mediaType == PHAssetMediaTypeImage)
        {
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                NSString *imgData = [self encodeToBase64String:image];
                [resultStrings addObject:imageData];
            }];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Canceled.");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
