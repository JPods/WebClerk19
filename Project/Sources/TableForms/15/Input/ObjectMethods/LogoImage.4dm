C_TEXT:C284($tempFold; $testName; $testPath; $longName)

C_PICTURE:C286($myClipImage)
C_LONGINT:C283($myOK; viWidth)

If (False:C215)
	// If ((Pasteboard data size("com.4d.private.picture.jpeg")>0) | (Pasteboard data size("com.4d.private.picture.gif")>0))
	GET PICTURE FROM PASTEBOARD:C522($myClipImage)
	[DefaultQQQ:15]Logo:10:=$myClipImage
	SAVE RECORD:C53([DefaultQQQ:15])
	// SET PICTURE TO LIBRARY(<>pNavPalletChange;2127;"PalletNavigation")
End if 
C_REAL:C285($viWidth; $viHeight; $viResolution; $viScale; $viCrop)
PICTURE PROPERTIES:C457([DefaultQQQ:15]Logo:10; $viWidth; $viHeight)

viWidth:=360
$viScale:=viWidth/$viWidth


TRANSFORM PICTURE:C988([DefaultQQQ:15]Logo:10; Scale:K61:2; $viScale; $viScale)