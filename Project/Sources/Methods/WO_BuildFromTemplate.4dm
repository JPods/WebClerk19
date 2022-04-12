//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/19/06, 10:52:46
// ----------------------------------------------------
// Method: WO_BuildFromTemplate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($index; $rayCnt; $thetaskID)
$rayCnt:=Size of array:C274(aWoStepLns)

Case of 
	: ((ptCurTable=(->[Order:3])) | (ptCurTable=(->[Control:1])))
		TaskIDAssign(->[Order:3]taskid:85)
		$thetaskID:=[Order:3]taskid:85
	: (ptCurTable=(->[Proposal:42]))
		TaskIDAssign(->[Proposal:42]taskid:70)
		$thetaskID:=[Proposal:42]taskid:70
End case 

For ($index; 1; $rayCnt)
	$k:=Size of array:C274(aWoRecNum)+1
	WO_FillArrays(-3; $k; 1)
	aWoDescrpt{$k}:=aWsDescpt{aWoStepLns{$index}}
	aWoNameID{$k}:=aWsWho{aWoStepLns{$index}}
	aWoActivity{$k}:=aWsActive{aWoStepLns{$index}}
	aWoRate{$k}:=aWsRate{aWoStepLns{$index}}
	aWoOrdertaskID{$k}:=$thetaskID
	aWoDurationPlan{$k}:=aWsDura{aWoStepLns{$index}}
	aWoNature{$k}:=aWsNature{aWoStepLns{$index}}
	aWoTemplateUniqueID{$k}:=aWsUniqueID{aWoStepLns{$index}}
	aWoSeq{$k}:=$k
	aWoRecNum{$k}:=-3
	//
	aWoTimeNd{$k}:=Current time:C178*1
	aWoDateNd{$k}:=Current date:C33+1
	//
	aWoTimeCmp{$k}:=?00:00:00?*1
	aWoDateCmp{$k}:=!00-00-00!
	aWoCause{$k}:=<>aCostCause{<>aCostCause}
	aWoPublish{$k}:=aWsPublish{aWoStepLns{$index}}
End for 
vbdWos:=True:C214
[Order:3]orderNum:2:=[Order:3]orderNum:2
doSearch:=0