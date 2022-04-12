//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/18/18, 11:16:52
// ----------------------------------------------------
// Method: TNHTMLheaderFooter
// Description
// 
// grgrgrgr  tranfer by from v40
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0; $1; $bodyText; $2; $name; $3; $purpose; $5; $title)
C_TEXT:C284($clipText)
C_LONGINT:C283($4; $publish)
$publish:=1
$title:="_jit_TechNotes_Namejj"
If (Count parameters:C259>3)
	$publish:=$4
	If (Count parameters:C259>4)
		$title:=$5
	End if 
End if 
$0:=""
$bodyText:=$1
$name:=$2
$purpose:=$3
C_TEXT:C284($doRecordPop)
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$2; *)  //  "TechNoteTemplate";*)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$3; *)  // "Admin";*)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
If (Records in selection:C76([TallyMaster:60])=0)
	CREATE RECORD:C68([TallyMaster:60])
	[TallyMaster:60]name:8:=$name  // "TechNoteTemplate"
	[TallyMaster:60]purpose:3:=$purpose  // "Admin"
	[TallyMaster:60]publish:25:=$publish  //  1
	
	$clipText:="<!--ContentClip-->"
	[TallyMaster:60]build:6:="<html><head><title>"+$title+"</title></head><body>"+"\r"+"<div id=\"TechNoteBody wrapper\">"+"\r"+$clipText+"\r"
	[TallyMaster:60]after:7:="\r"+$clipText+"\r"+"</div></body></html>"
	SAVE RECORD:C53([TallyMaster:60])
	$doRecordPop:="Pop"
End if 
FIRST RECORD:C50([TallyMaster:60])
$0:=[TallyMaster:60]build:6+$bodyText+[TallyMaster:60]after:7
If ($doRecordPop="Pop")
	ProcessTableOpen(Table:C252(->[TallyMaster:60]); ""; "Head by Foot Template")
End if 
REDUCE SELECTION:C351([TallyMaster:60]; 0)