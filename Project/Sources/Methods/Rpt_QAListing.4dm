//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/03/20, 12:30:27
// ----------------------------------------------------
// Method: Rpt_QAListing
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283(<>vlCalc; $theFile)
C_TEXT:C284($theAcct)
C_TEXT:C284($commo)

//If (<>vlCalc=0)
KeyModifierCurrent
Rpt_RayManage(0)
If ((Size of array:C274(aSrvLines)>0) & (ptCurTable=(->[Control:1])))
	Case of 
		: ((aServiceTableName{aSrvLines{1}}="S") | (aServiceTableName{aSrvLines{1}}="C"))
			$dofile:=2
		: (aServiceTableName{aSrvLines{1}}="L")
			$dofile:=Table:C252(->[zzzLead:48])
	End case 
Else 
	$dofile:=Table:C252(ptCurTable)
End if 
Case of 
	: ($dofile=2)
		$theFile:=2
		$theAcct:=[Customer:2]customerID:1
		QUERY:C277([TallyResult:73]; [TallyResult:73]tableNum:3=$theFile; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2=$theAcct; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1="Q&ARays")
		CustAddress:=PVars_AddressFull("Customer")
		pvPhone:=Format_Phone([Customer:2]phone:13)
		pvFAX:=Format_Phone([Customer:2]fax:66)
		$commo:="Phone: "+pvPhone+"\r"+"FAX: "+pvPhone+"\r"+"eMail: "+[Customer:2]email:81
	: ($dofile=Table:C252(->[zzzLead:48]))
		$theFile:=Table:C252(->[zzzLead:48])
		$theAcct:=String:C10([zzzLead:48]idNum:32)
		QUERY:C277([TallyResult:73]; [TallyResult:73]tableNum:3=$theFile; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2=$theAcct; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1="Q&ARays")
		CustAddress:=PVars_AddressFull("Lead")
		pvPhone:=Format_Phone([zzzLead:48]phone:4)
		pvFAX:=Format_Phone([zzzLead:48]fax:29)
		$commo:="Phone: "+pvPhone+"\r"+"FAX: "+pvPhone+"\r"+"eMail: "+[zzzLead:48]email:33
End case 
C_PICTURE:C286($emptyPict)
//[TallyResult]PictBlk1:=$emptyPict
$k:=Size of array:C274(aQaQuest)
C_LONGINT:C283($maxWide; $keyQuest)
C_LONGINT:C283($spacer; $filler; $end)
C_POINTER:C301($ptRayElem)
$spacer:=0
$filler:=0
$baseQust:=""
$doQuest:=True:C214
$makeLoop:=(Size of array:C274(aQaQuest)>0)
$i:=Num:C11(Size of array:C274(aQaAnsweredBy)>0)
While (($i<=$k) & ($makeLoop))
	
	If (aQaQuest{$i}#$baseQust)
		$endLoop:=False:C215
		$baseQust:=aQaQuest{$i}
		$baseRow:=aQaGroup{$i}
		$filler:=Size of array:C274(<>aText1)+1
		Rpt_RayManage(-3; $filler; 1)
		$incRay:=$i
		Repeat 
			$ptRayElem:=Get pointer:C304("<>aText"+String:C10(aQaAnsweredBy{$incRay}))
			$ptRayElem->{$filler}:=aQaQuest{$incRay}
			If ($incRay<$k)
				$incRay:=$incRay+1
			Else 
				$endLoop:=True:C214
				$makeLoop:=False:C215
			End if 
		Until ($endLoop)
	End if 
	If (($i<=$k) & ($k>0))
		$baseRow:=aQaGroup{$i}
		$filler:=Size of array:C274(<>aText1)+1
		Rpt_RayManage(-3; $filler; 1)
		Repeat 
			$ptRayElem:=Get pointer:C304("<>aText"+String:C10(aQaAnsweredBy{$i}))
			$ptRayElem->{$filler}:=aQaAnswr{$i}
			If ($i<$k)
				$i:=$i+1
			Else 
				$endLoop:=True:C214
				$makeLoop:=False:C215
			End if 
		Until ($endLoop)
	End if 
End while 