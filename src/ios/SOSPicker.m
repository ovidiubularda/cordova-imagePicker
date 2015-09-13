//
//  SOSPicker.m
//  SyncOnSet
//
//  Created by Ovidiu Bularda
//
//

#import "SOSPicker.h"


@implementation SOSPicker

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)imageByScalingNotCroppingForSize:(UIImage *)anImage toSize:(CGSize)frameSize {
    return nil;
}

- (void) getPictures:(CDVInvokedUrlCommand *)command {

    NSDictionary *options = [command.arguments objectAtIndex: 0];
	NSInteger maximumImagesCount = [[options objectForKey:@"maximumImagesCount"] integerValue];

    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.mediaType = QBImagePickerMediaTypeAny;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    imagePickerController.maximumNumberOfSelection = maximumImagesCount;

    self.callbackId = command.callbackId;

    [self.viewController presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark - QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    NSMutableArray *resultStrings = [[NSMutableArray alloc] init];
    PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.synchronous = YES;
    

    for (PHAsset *asset in assets) {
        // Do something with the asset
        if(asset.mediaType == PHAssetMediaTypeImage)
        {
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                //NSString *encodedString = [imageData base64Encoding];

                NSString *encodedString = [imageData base64EncodedStringWithOptions:0];
                [resultStrings addObject: encodedString];
            }];
        }
    }

    // Close view
    [self.viewController dismissViewControllerAnimated:YES completion:NULL];

    //Run cordova
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsArray: resultStrings];
    [self.commandDelegate sendPluginResult:result callbackId: self.callbackId];

}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self.viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
