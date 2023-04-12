//%attributes = {}
// SET DATABASE PARAMETER for logging errors

// setRemoteContextInfo
// Blog

//  https://www.youtube.com/watch?v=0d_a-9iNV8s

// https://4dmethod.com/2020/11/11/november-18-meeting-quickly-open-things-in-4d-development-environment-and-sync-code-between-projects-cannon-smith/

//  Data Explorer
//  https://www.youtube.com/watch?v=0d_a-9iNV8s

//https://blog.4d.com/system-worker-vs-launch-external-process/
//https://blog.4d.com/system-worker-file-transfer-class-to-use-curl-for-ftp-ftps-sftp-http
//https://blog.4d.com/system-worker-file-transfer-class-to-use-dropbox-or-gdrive/


// running a background application 
var $sw : Object
If (Is macOS:C1572)
	$sw:=4D:C1709.SystemWorker.new("ping -c 1 www.google.com")
Else 
	$sw:=4D:C1709.SystemWorker.new("ping -n 1 www.google.com")
End if 

// can pass additional attributes
If (Is macOS:C1572)
	$sw:=4D:C1709.SystemWorker.new("ping -c 1 www.google.com"; New object:C1471("onData"; Formula:C1597(MESSAGE:C88($2.data))))
Else 
	$sw:=4D:C1709.SystemWorker.new("ping -n 1 www.google.com"; New object:C1471("encoding"; "IBM437"; "onData"; Formula:C1597(MESSAGE:C88($2.data))))
End if 
// https://youtu.be/RZvj8RfosMw
// ProgressBar example at 12:00

// HOWTO:ProgressBar

//var $para : cs.cSystemWorker_callback
//$para:=cs.cSystemWorker_callback.new(Formula(ProgressCallback); 
//$sw:=cs.cSystemWorker_callback.new()
//If (Is macOS)
//$sw:=4D.SystemWorker.new("ping -c 1 www.google.com"; New object("onData"; Formula(MESSAGE($2.data))))
//Else 
//$sw:=4D.SystemWorker.new("ping -n 1 www.google.com"; New object("encoding"; "IBM437"; "onData"; Formula(MESSAGE($2.data))))
//End if 




// HOWTO:images

/*  
Just found a simple workaround: CONVERT PICTURE($img; ".bmp") 
CONVERT PICTURE($img; ".jpg") rotates a jpeg picture with TIFF 
orientation different from 1, creating a brand new correctly 
rotated image with no orientation metadata. No slower than 
a rotation with SVG or SIPS. The size (KB) of the image grows, 
but no more than with a rotation with SVG or SIPS.

https://discuss.4d.com/t/picture-rotation-4d-for-ios/20254/7
You can use PHP with the GD Library (already included in 4D) and imagerotate, which will rotate the picture on a specific angle. This is a centered rotation, image is rotated around its center. For rotating 1 picture, it’s heavy, for 4D has to load the PHP package.
I’ve distributed an example on how to use GD library in 4D along with the V17 training some years ago. It was named PictureEffects.4dbase.
You can use SVG and SVG_ROTATION_CENTERED which will do the same, with approximatively the same time.
You can use components dedicated to picture manipulations.

https://doc.4d.com/4Dv18/4D/18.4/SET-PICTURE-METADATA.301-5233427.en.html

*/

