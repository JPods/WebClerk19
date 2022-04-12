//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 00:58:36
// ----------------------------------------------------
// Method: Image_Download
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BLOB:C604($vblWebImage)
C_LONGINT:C283($viResult)
C_OBJECT:C1216($1; $voPayload)
C_TEXT:C284($vtURL; $vtPathToSave)
ARRAY TEXT:C222($aHeaderNames_at; 0)
ARRAY TEXT:C222($aHeaderValues_at; 0)
$voPayload:=$1
$vtURL:=$voPayload.url
$vtPathToSave:=$voPayload.path

$vtURL:="https://www.jpods.com/sites/all/themes/danland/images/slideshows/JPodsGallery1.jpg"
$viResult:=HTTP Get:C1157($vtURL; $vblWebImage; $aHeaderNames_at; $aHeaderValues_at)
$voPayload.result:=$viResult
$voPayload.size:=BLOB size:C605($vblWebImage)
BLOB TO DOCUMENT:C526($vtPathToSave; $vblWebImage)
$0:=$voPayload
