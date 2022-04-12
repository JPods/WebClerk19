//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/24/06, 09:53:17
// ----------------------------------------------------
// Method: SRE_CallBack
// Description
// 
//
// Parameters
// ----------------------------------------------------
//   Dov13
// C_BLOB(reportDefinitionBlob)
C_BLOB:C604(reportDefinitionBlob)



C_LONGINT:C283($1; $2; $3)
//$1 -- Area reference
//$2 -- Event type 
//$3 -- Additional information; zoomed area, 
Case of 
	: ($2=11)  //Area Zoomed
		C_PICTURE:C286(vpZoom)
		C_LONGINT:C283(eZoom)
		$result:=SR Get Area($1; reportDefinitionBlob)
		eZoom:=$3
		$result:=SR Set Area(eZoom; reportDefinitionBlob)
	: ($2=12)  //Zoomed area collapsed
		TRACE:C157
		$result:=SR Get Area(eZoom; reportDefinitionBlob)
		$result:=SR Set Area($1; reportDefinitionBlob)
	: ($2=13)  //zoomed window to front
	: ($2=14)  //orig window to front
	: ($2=20)  //switching to editor mode
	: ($2=21)  //switching to preview
	: ($2=30)  //preview:  1st page
	: ($2=31)  //preview: previous page
	: ($2=32)  //preview: next page
	: ($2=33)  //preview last page
	: ($2=34)  //print one page
	: ($2=35)  //preview:  close preview
		//CRASH if "CLOSE WINDOW" is called from this command.
End case 