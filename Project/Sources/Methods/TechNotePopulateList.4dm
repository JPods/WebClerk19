//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-07-22T00:00:00, 13:00:39
// ----------------------------------------------------
// Method: TechNotePopulateList
// Description
// Modified: 07/22/18
// Structure: gkgkgk
// 
//
// Parameters
// ----------------------------------------------------

If (Records in selection:C76([TechNote:58])=0)
	QUERY:C277([TechNote:58]; [TechNote:58]name:2="TableOfContents")
End if 
SELECTION TO ARRAY:C260([TechNote:58]name:2; aTNName; [TechNote:58]subject:6; aTNSub; [TechNote:58]; aTNRec; [TechNote:58]chapter:14; aTNChap; [TechNote:58]section:15; aTNSect)
// MULTI SORT ARRAY(aTNChap;>;aTNSect;>;aTNName;aTNSub;aTNRec)
If (Records in selection:C76([TechNote:58])>1)
	REDUCE SELECTION:C351([TechNote:58]; 0)
	SORT ARRAY:C229(aTNChap; aTNSect; aTNName; aTNSub; aTNRec)
End if 
ARRAY LONGINT:C221(aTNRecSel; 1)
aTNRecSel{1}:=1
GOTO RECORD:C242([TechNote:58]; aTNRec{aTNRecSel{1}})
FIRST RECORD:C50([TechNote:58])

srTNName:=[TechNote:58]name:2
srTNSubject:=[TechNote:58]subject:6
srTnKey:=""
vi2:=[TechNote:58]chapter:14
//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)



If (False:C215)
	C_LONGINT:C283($pathOK)
	C_TEXT:C284($theText; $theURL; $thePage)
	$theText:="Chap_"+String:C10([TechNote:58]chapter:14; "000")
	$thePage:=String:C10([TechNote:58]chapter:14)+"_"+String:C10([TechNote:58]section:15)+".html"
	
	$theURL:="Users/williamjames/CommerceExpert/jitHelp/technotes/Chap_001/"+$thePage
	$pathOK:=Test path name:C476($theURL)
	
	$theURL:=<>jitHelpFolder+"technotes/"+$theText+"/"+$thePage
	$pathOK:=Test path name:C476($theURL)
	$theURL:="file:///"+$theURL
	
	tinyMCE_Content_t:=[TechNote:58]bodyText:23
	C_TEXT:C284($wa_htmlEditor_path_t)
	// $wa_htmlEditor_path_t:=Get 4D folder(Current resources folder)+"tinymce"+Folder separator+"htmleditor.html"
	// $wa_htmlEditor_path_t:=Convert path system to POSIX($wa_htmlEditor_path_t)
	// WA OPEN URL(myWebArea;"file:///"+$wa_htmlEditor_path_t)
	WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "setContent"; *; tinyMCE_cleanCR(tinyMCE_Content_t))
End if 