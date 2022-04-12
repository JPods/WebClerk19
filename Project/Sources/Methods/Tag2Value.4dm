//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-06T00:00:00, 09:32:30
// ----------------------------------------------------
// Method: Tag2Value
// Description
// Modified: 12/06/15
// Structure: CEv13_131005
// Ref:  
//    TP_ParseTags
// TP_ProcessTags
//  etc...
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; echo_t)

If (<>WebRealFormat="")
	<>vlWebRealPr:=2
	<>WebRealFormat:=("###,###,###,##0.00")
End if 
Case of 
	: (vWebTagTableNum=-6)  //page executable
		echo_t:=""
		ExecuteText(0; vWebTagField)
		$0:=echo_t
		echo_t:=""
	: (vWebTagTableNum=-3)  //page executable
		$0:=TagsToObjects
	: (vWebTagTableNum=-1)  //Arrays      
		$0:=TagsToArray
	: (vWebTagTableNum=0)  //Variables
		$0:=TagValueVariable
	: (vWebTagTableNum=-2)  //array elements
		$0:=TagValueArrayElement
		// not currently capturing element number, is it in the format tag? qqqq
	: (vWebTagTableNum>0)
		$0:=TagValueField
	Else 
		$0:="error_Tag Table: "+vWebTagTable+" Field: "+vWebTagField
End case 
// ((<>consoleDirection#0) & (<>consoleDirection#4) & (<>viDebugMode>0)) // ### jwm ### 20160927_1435 double check this
