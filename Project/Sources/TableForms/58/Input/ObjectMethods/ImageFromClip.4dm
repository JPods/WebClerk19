
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-06T00:00:00, 15:06:50
// ----------------------------------------------------
// Method: [TechNote].InputTinymce.Button
// Description
// Modified: 05/06/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($myText; $imageName; $offerName)
C_LONGINT:C283($myPosition)
ARRAY TEXT:C222($atType; 0)
ARRAY TEXT:C222($atNative; 0)
ARRAY TEXT:C222($atFormat; 0)
GET PASTEBOARD DATA TYPE:C958($atType; $atNative; $atFormat)
C_PICTURE:C286($myClipImage)
C_LONGINT:C283($myOK; viWidth)
// If ((Pasteboard data size("com.4d.private.picture.jpeg")>0) | (Pasteboard data size("com.4d.private.picture.gif")>0))
GET PICTURE FROM PASTEBOARD:C522($myClipImage)
PICTURE PROPERTIES:C457($myClipImage; $viWidth; $viHeight)
If ($viWidth=0)
	ALERT:C41("The pasteboard does not contain any pictures.")
Else 
	C_REAL:C285($viWidth; $viHeight; $viResolution; $viScale; $viCrop)
	PICTURE PROPERTIES:C457($myClipImage; $viWidth; $viHeight)
	Case of 
		: (viWidth>$viWidth)
			// do not scale
			
		: ((viWidth#0) & (viWidth#$viWidth))
			$viScale:=viWidth/$viWidth
			TRANSFORM PICTURE:C988($myClipImage; Scale:K61:2; $viScale; $viScale)
	End case 
	
	C_LONGINT:C283($happy)  // test to see if the path exists
	$happy:=Test path name:C476(vtTNPathSystem)
	If ($happy<0)
		CREATE FOLDER:C475(vtTNPathSystem; *)  // create missing hierarchy of folders
	End if 
	
	
	// $myPath:=PathtoUniversal (vtTNPathSystem+iLoText3)
	$myPath:=vtTNPathSystem+iLoText3  // keep it simple for documentation writing
	// need to store things relative to where they are being written
	
	WRITE PICTURE FILE:C680($myPath; $myClipImage)
	
	//  file:////Users/williamjames/CommerceExpert/jitHelp/technotes/Chap_001/images/1_9001.jpg
	C_TEXT:C284($myPath)
	
	If (Is macOS:C1572)
		// $myPath
	End if 
	$myPath:=vtTNPathSystem+iLoText3
	$myPath:="file://"+Convert path system to POSIX:C1106($myPath; *)
	
	// not the "documents" folder and drive names are removed on a Mac
	// file:  ///Users/williamjames/CommerceExpert/jitHelp/technotes/Chap_001/images/imageName.png
	
	ALERT:C41("Path on Clipboard and Console")
	ConsoleMessage([TechNote:58]name:2+<>VCR+" image path: "+"On Clipboard"+<>VCR+$myPath)
	SET TEXT TO PASTEBOARD:C523($myPath)
	
End if 