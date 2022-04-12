//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/21/19, 23:34:44
// ----------------------------------------------------
// Method: PictureResize
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_PICTURE:C286($vPictWorking)

C_TEXT:C284($vtPathIncoming; $vtDestination)
C_TIME:C306($myDoc)
$vtSource:=Select folder:C670("Select a folder of images to process to 720.")
If (OK=1)
	C_LONGINT:C283($viTest)
	$viTest:=0
	Repeat 
		$viTest:=$viTest+1
	Until (Test path name:C476($vtSource+"Scaled-"+String:C10($viTest))=0)
	CREATE FOLDER:C475($vtSource+"Scaled-"+String:C10($viTest))
	$vtDestination:=$vtSource+"Scaled-"+String:C10($viTest)
	ARRAY TEXT:C222($aTextDocs; 0)
	DOCUMENT LIST:C474($vtFolder; $aTextDocs; Absolute path:K24:14+Ignore invisible:K24:16)
	C_LONGINT:C283($cntImages; $incImages)
	$cntImages:=Size of array:C274($aTextDocs)
	For ($incImages; 1; $cntImages)
		READ PICTURE FILE:C678($aTextDocs{$incImages}; $vPictWorking; *)
		
		//CREATE THUMBNAIL 
		C_LONGINT:C283($viWidth; $viHeight; $vihOffset; $vivOffset; $viMode)
		PICTURE PROPERTIES:C457($vPictWorking; $viWidth; $viHeight; $vihOffset; $vivOffset; $viMode)
		
		C_REAL:C285($vrVerticalScale; $vrHorizontalScale)
		$vrHorizontalScale:=720/$viWidth
		$vrVerticalScale:=$vrHorizontalScale
		TRANSFORM PICTURE:C988($vPictWorking; Scale:K61:2; $vrHorizontalScale; $vrVerticalScale)
		
		WRITE PICTURE FILE:C680($vtDestination; $vPictWorking)
	End for 
End if 