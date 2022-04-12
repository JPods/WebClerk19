//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/29/21, 17:14:27
// ----------------------------------------------------
// Method: Learn_SharedObjects
// Description
// 
//
// Parameters
// ----------------------------------------------------
//https://kb.4d.com/assetid=78197
// To copy the object defined at the top into an shared object, using OB_CopyToShar
#DECLARE($voData : Object)
If (Count parameters:C259=0)
	$voData:=New shared object:C1526
End if 
var $jitF; $serverF; $saveF : Text
$voData:=New shared object:C1526("user"; System folder:C487(Documents folder:K41:18); "ComEx"; $jitF; \
"shareName"; ""; \
"server"; System folder:C487(Documents folder:K41:18)+"CommerceExpert"+Folder separator:K24:12; \
"remote"; ""; \
"jitAudits"; $jitF+Folder separator:K24:12+"jitAudits"+Folder separator:K24:12; \
"jitCatalog"; $jitF+Folder separator:K24:12+"jitCatalog"+Folder separator:K24:12; \
"jitDebug"; $jitF+Folder separator:K24:12+"jitDebug"+Folder separator:K24:12; \
"jitjDocs"; $jitF+Folder separator:K24:12+"jitjDocs"+Folder separator:K24:12; \
"jitExports"; $jitF+Folder separator:K24:12+"jitExports"+Folder separator:K24:12; \
"jitFAX"; $jitF+Folder separator:K24:12+"jitFAX"+Folder separator:K24:12; \
"jitHelp"; $jitF+Folder separator:K24:12+"jitHelp"+Folder separator:K24:12; \
"jitLabels"; $jitF+Folder separator:K24:12+"jitLabels"+Folder separator:K24:12; \
"jitLetters"; $jitF+Folder separator:K24:12+"jitLetters"+Folder separator:K24:12; \
"jitReports"; $jitF+Folder separator:K24:12+"jitReports"+Folder separator:K24:12; \
"jitSearches"; $jitF+Folder separator:K24:12+"jitSearches"+Folder separator:K24:12; \
"jitShip"; $jitF+Folder separator:K24:12+"jitShip"+Folder separator:K24:12; \
"jitWeb"; $jitF+Folder separator:K24:12+"jitWeb"+Folder separator:K24:12)


Use (Storage:C1525)
	Storage:C1525.paths:=$voData
End use 

Use (Storage:C1525.jitF)
	Storage_ValuesToObject($voData; Storage:C1525.jitF)
End use 
