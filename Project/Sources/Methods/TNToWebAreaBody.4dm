//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/15/18, 13:18:07
// ----------------------------------------------------
// Method: TNToWebAreaBody
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $typeOfArea)
If (Count parameters:C259=1)
	$typeOfArea:=$1
Else 
	$typeOfArea:=""  // tinyMCE
End if 

C_TEXT:C284($myText; vtTNPathSystem; vtTNPathURL)
C_TEXT:C284(tinyMCE_Content_t)
srTNName:=[TechNote:58]name:2
srTNSubject:=[TechNote:58]subject:6
srTnKey:=""
vi2:=[TechNote:58]chapter:14
<>vTN_OutSide:=""  // assured this is cleared

If (<>jitHelpFolder="")
	<>jitHelpFolder:=<>jitHelpLocal
End if 

C_TEXT:C284($theChapterFolder; tinyMCE_Content_t; vtTNPathSystem)
$theChapterFolder:="Chap_"+String:C10([TechNote:58]chapter:14; "000")
vtTNPathSystem:=<>jitHelpFolder+"technotes"+Folder separator:K24:12+$theChapterFolder+Folder separator:K24:12+"images"+Folder separator:K24:12

// switch from web to drive paths
C_TEXT:C284($techPath; $resourcePath; $theChapterFolder; $findImage; tinyMCE_Content_t)
tinyMCE_Content_t:=[TechNote:58]bodyText:23
vtTNPathURL:="file://"+Convert path system to POSIX:C1106(vtTNPathSystem; *)
tinyMCE_Content_t:=Tx_ReplaceURLstrings(tinyMCE_Content_t; "src=\""; "\""; vtTNPathURL; "/,./,../")

If (False:C215)  //  (tinyMCE_Content_t="") this may be more hassle than it is worth
	tinyMCE_Content_t:="No content"
End if 

// reset the WebTech every time, then allow : (Form event=On End URL Loading) 
// to fill with tinyMCE_Content_t
If ($typeOfArea="WebArea")
	If (False:C215)  // failing to display
		// ### bj ### 20191217_0139
		WA SET PAGE CONTENT:C1037(WebTech; tinyMCE_Content_t; "file:///")  // no tinyMCE
	End if 
	WAtinymceCall("WebTech"; tinyMCE_Content_t; "editorTechNotes.html")
	// WAtinymceCall ("WebTech";tinyMCE_Content_t;"editorDiscussions")
Else 
	WAtinymceCall("WebTech"; tinyMCE_Content_t; "editorTechNotes.html")
End if 


// note on macs this clips the "DriveName folder name
// uncertain on PCs. Need to document
//replace the image path

