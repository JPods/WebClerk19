//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/19, 22:28:25
// ----------------------------------------------------
// Method: FixTableNamesUserReports
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(vHere)
C_LONGINT:C283($incRec; $cntRec; $lastTable)
$lastTable:=Get last table number:C254
QUERY:C277([UserReport:46]; [UserReport:46]tableNum:3>0; *)
QUERY:C277([UserReport:46];  & ; [UserReport:46]tableNum:3<=$lastTable; *)
QUERY:C277([UserReport:46];  & ; [UserReport:46]TableName:47="")
$cntRec:=Records in selection:C76([UserReport:46])
FIRST RECORD:C50([UserReport:46])
For ($incRec; 1; $cntRec)
	[UserReport:46]TableName:47:=Table name:C256([UserReport:46]tableNum:3)
	SAVE RECORD:C53([UserReport:46])
	NEXT RECORD:C51([UserReport:46])
End for 
If (vHere<1)
	REDUCE SELECTION:C351([UserReport:46]; 0)
End if 



ARRAY TEXT:C222(<>yURptTypes; 15)
ARRAY TEXT:C222(<>yURptDTypes; 15)  //created on the Fly to hold a distinct set of Doc Types
ARRAY TEXT:C222(<>yURptCreatr; 15)
<>yURptTypes{1}:="Other"  //1 must always be other
<>yURptCreatr{1}:=""
<>yURptTypes{2}:="SuperReport"
<>yURptCreatr{2}:="GTSR"
<>yURptTypes{3}:="QuickReport"
<>yURptCreatr{3}:="JITA"
<>yURptTypes{4}:="Script"
<>yURptCreatr{4}:="FRmk"
<>yURptTypes{5}:="Text-Out"
<>yURptCreatr{5}:="TxtO"
<>yURptTypes{6}:="EDI-Out"
<>yURptCreatr{6}:="EDIO"
<>yURptTypes{7}:="EDI In"
<>yURptCreatr{7}:="EDII"
<>yURptTypes{8}:="Script"
<>yURptCreatr{8}:="EDIx"
<>yURptTypes{9}:="Service"
<>yURptCreatr{9}:="MySv"
<>yURptTypes{10}:="Schedule"
<>yURptCreatr{10}:="ScOp"
<>yURptTypes{11}:="TinyMCE"
<>yURptCreatr{11}:="TMCE"
<>yURptTypes{12}:="Email"
<>yURptCreatr{12}:="Mail"
<>yURptTypes{13}:="Fax Attachment"
<>yURptCreatr{13}:="4com"
<>yURptTypes{14}:="Browser"
<>yURptCreatr{14}:="Brow"
<>yURptTypes{15}:="Clipboard"
<>yURptCreatr{15}:="Clip"


ALL RECORDS:C47([UserReport:46])
$cntRec:=Records in selection:C76([UserReport:46])
FIRST RECORD:C50([UserReport:46])
For ($incRec; 1; $cntRec)
	
	URpt_SetTypePop
	
	SAVE RECORD:C53([UserReport:46])
	NEXT RECORD:C51([UserReport:46])
End for 
If (vHere<1)
	REDUCE SELECTION:C351([UserReport:46]; 0)
End if 


