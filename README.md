cordova-obimagepicker
===================

Cordova Plugin For Multiple Image Selection - implemented for iOS and Android 4.0 and above.
It can be used as a replacement for http://ngcordova.com/docs/plugins/imagePicker/

## Installing the plugin

The plugin conforms to the Cordova plugin specification, it can be installed
using the Cordova / Phonegap command line interface.

    phonegap plugin add cordova-obimagepicker
    cordova plugin add cordova-obimagepicker


## Using the plugin

The plugin creates the object `window.imagePicker` with the method `getPictures(success, fail, options)`

Example - Get Full Size Images (all default options):
```javascript
window.imagePicker.getPictures(
	function(results) {
		for (var i = 0; i < results.length; i++) {
			console.log('Image URI: ' + results[i]);
		}
	}, function (error) {
		console.log('Error: ' + error);
	}
);
```

Example - Get at most 10 images scaled to width of 800:
```javascript
window.imagePicker.getPictures(
	function(results) {
		for (var i = 0; i < results.length; i++) {
			console.log('Image URI: ' + results[i]);
		}
	}, function (error) {
		console.log('Error: ' + error);
	}, {
		maximumImagesCount: 10
	}
);
```

### Options

    options = {
        // max images to be selected, defaults to 0 (infinity)
    	maximumImagesCount: int,
    };
    
### Note for Android Use

The plugin returns images that are stored in a temporary directory.  These images will often not be deleted automatically though.  The files should be moved or deleted after you get their filepaths in javascript.

## Libraries used

#### QBImagePicker

For iOS this plugin uses the QBImagePicker, with slight modifications for the iOS image picker.
QBImagePicker uses the MIT License which can be found in the file LICENSE.

### The following libraries are required:
- QuartzCore.framework
- Photos.framework


https://github.com/questbeat/QBImagePicker

#### MultiImageChooser

For Android this plugin uses MultiImageChooser, with modifications.  MultiImageChooser uses the BSD 2-Clause License which can be found in the file BSD_LICENSE.  Some code inside MultImageChooser is licensed under the Apache license which can be found in the file APACHE_LICENSE.

https://github.com/derosa/MultiImageChooser

#### FakeR

Code(FakeR) was also taken from the phonegap BarCodeScanner plugin.  This code uses the MIT license.

https://github.com/wildabeast/BarcodeScanner

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.