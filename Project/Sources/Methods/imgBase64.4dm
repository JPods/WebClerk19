//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/25/19, 16:38:21
// ----------------------------------------------------
// Method: imgBase64
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	ARRAY TEXT:C222($aCodex; 0)
	ARRAY TEXT:C222($aNamesOfCodex; 0)
	PICTURE CODEC LIST:C992($aCodex; $aNamesOfCodex)
End if 

C_BLOB:C604($sourceBlob)
C_BLOB:C604($targetBlob)
C_PICTURE:C286($mypicture)
C_TIME:C306($myImg)
C_TEXT:C284($base64Text; $base64Trimmed; $pathTN)

C_OBJECT:C1216($1; $0; $return_o; $base_o)
$0:=New object:C1471
$return_o:=New object:C1471

If (Count parameters:C259=0)  // testing
	$myImg:=Open document:C264("")
	If (OK=1)
		CLOSE DOCUMENT:C267($myImg)
		DOCUMENT TO BLOB:C525(document; $sourceBlob)
		BASE64 ENCODE:C895($sourceBlob; $base64Text)  //Encoding of text
	End if 
Else 
	$base_o:=$1
End if 

If (Length:C16($base_o.photo)>0)
	C_LONGINT:C283($w)
	C_TEXT:C284($docType; $docExt)
	$w:=Position:C15(";base64,"; $base_o.photo)
	If ($w>0)
		$docType:=Substring:C12($base_o.photo; 1; $w-1)  // capture the doctype
		$base64Trimmed:=Substring:C12($base_o.photo; $w+8)  // clip the header
	Else 
		$base64Trimmed:=$base_o.photo
	End if 
	
	$w:=Position:C15("/"; $docType)
	If ($w>0)
		$docExt:=Substring:C12($docType; $w+1)
	Else 
		$docExt:=$docType
	End if 
	
	
	BASE64 DECODE:C896($base64Trimmed; $targetBlob)  //Decoding of text
	
	
	C_PICTURE:C286($pictureWorking_p)
	BLOB TO PICTURE:C682($targetBlob; $pictureWorking_p)
	
	C_TIME:C306($vhDocRef)
	C_TEXT:C284($pathDoc)
	C_TEXT:C284($pathFolder; $pathFolderTn; $pathFolderHiRes; $docName)
	
	$pathFolder:=$base_o.path
	
	If ($docExt="")
		$docExt:=".txt"
	End if 
	If (Position:C15("."; $docExt)#1)
		$docExt:="."+$docExt
	End if 
	$docName:=$base_o.nameTag+$docExt
	
	If (Test path name:C476($pathFolder)#0)
		CREATE FOLDER:C475($pathFolder; *)
	End if 
	$pathFolderTn:=$pathFolder+"tn"+Folder separator:K24:12
	If (Test path name:C476($pathFolderTn)#0)
		CREATE FOLDER:C475($pathFolderTn; *)
	End if 
	
	$pathFolderHiRes:=$pathFolder+"hiRes"+Folder separator:K24:12
	If (Test path name:C476($pathFolderHiRes)#0)
		CREATE FOLDER:C475($pathFolderHiRes; *)
	End if 
	
	
	// HOWTO: Size a image
	
	If (BLOB size:C605($targetBlob)>600000)
		// $docName:=PathName_Unique($pathFolderHiRes;$docName;$docExt)
		WRITE PICTURE FILE:C680($pathFolderHiRes+$docName; $pictureWorking_p)
	End if 
	
	If (($docExt="@jpg@") | ($docExt="@jpeg@") | ($docExt="@png@"))
		C_REAL:C285($vrScale)
		
		// PictureResize
		
		C_LONGINT:C283($viWidth; $viHeight; $vihOffset; $vivOffset; $viMode)
		PICTURE PROPERTIES:C457($pictureWorking_p; $viWidth; $viHeight; $vihOffset; $vivOffset; $viMode)
		
		C_REAL:C285($vrVerticalScale; $vrHorizontalScale)
		$vrHorizontalScale:=720/$viWidth
		$vrVerticalScale:=$vrHorizontalScale
		TRANSFORM PICTURE:C988($pictureWorking_p; Scale:K61:2; $vrHorizontalScale; $vrVerticalScale)
		
		C_PICTURE:C286($vPicture; $vPictTN)
		
		CREATE THUMBNAIL:C679($pictureWorking_p; $vPictTN; 100; 100; 6)
		If (OK=1)  // If a document has been created
			CONVERT PICTURE:C1002($vPictTN; ".jpg"; 0.7)
			//  TRANSFORM PICTURE ( picture ; operator {; param1 {; param2 {; param3 {; param4}}}} ) 
			
			
			WRITE PICTURE FILE:C680($pathFolderTn+$docName; $vPictTN)
			$return_o.imagePathTn:=$pathFolderTn+$docName
		End if 
	End if 
	
	WRITE PICTURE FILE:C680($pathFolder+$docName; $pictureWorking_p)
	$return_o.imagePath:=$pathFolder+$docName
	$0:=$return_o
	
End if 