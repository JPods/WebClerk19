//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-19T00:00:00, 09:29:44
// ----------------------------------------------------
// Method: URpt_DocLocPath
// Description
// Modified: 08/19/13
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)  //File Type to Confirm
C_TEXT:C284($2)  //Find File Message
C_BOOLEAN:C305($fix; $0)
$0:=False:C215
Case of 
	: ([UserReport:46]template:7="")
		$fix:=True:C214
	: (HFS_Exists([UserReport:46]template:7)=0)
		$fix:=True:C214
	Else 
		$fix:=False:C215
End case 
If ($fix)
	myDocName:=""
	C_LONGINT:C283($myOK)
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; $2; "TEXT"; Storage:C1525.folder.jitQRsF)
	If ($myOK=1)
		[UserReport:46]template:7:=myDocName
		$0:=True:C214
	Else 
		<>yURptTypes:=1  //other
		If (Size of array:C274(aLoText5)>1)  // in the iLo UserReports
			aLoText5:=1
		End if 
	End if 
End if 