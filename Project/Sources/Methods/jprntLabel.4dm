//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/01/14, 16:44:48
// ----------------------------------------------------
// Method: jprntLabel
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141201_1644 updated to fix label printing errors

//(P)    jprntLabel
If (False:C215)
	TCStrong_prf_v142_ProcExt
	//01/31/03.prf
	//replaced Proc.Ext commands with native commands or removed if not available
End if 

C_LONGINT:C283($recNum; $sizeWindow; $i; vlongCnt; $cntLabels; $incVar)
C_BOOLEAN:C305($doReport)
MESSAGES OFF:C175
TRACE:C157
If (False:C215)  //Is macOS)
	KeyModifierCurrent
	$doReport:=P_vHereBegin(->rptRecNum; ->doCurFile)  //;vbSelRecNum)//doCurFile could also be affected by P_Primary procedure
	If ($doReport)
		ARRAY LONGINT:C221(aRecNums; 0)
		ARRAY TEXT:C222(SLVarNames; 0)
		ARRAY LONGINT:C221(SLVarTypes; 0)
		If (OptKey=1)
			Label_CoStar
		Else 
			If (vlongCnt>-1)
				$recNum:=vlongCnt
			End if 
			vlongCnt:=0
			$doOne:=False:C215
			$doMulti:=False:C215
			If ((ptCurTable=(->[Invoice:26])) | (ptCurTable=(->[Order:3])))
				BEEP:C151
				jCenterWindow(248; 46; 1)
				DIALOG:C40([Control:1]; "LabelCntSelect")
				CLOSE WINDOW:C154
				If (OK=1)
					$doMulti:=True:C214
				Else 
					$doOne:=True:C214
				End if 
			Else 
				$doOne:=True:C214
			End if 
			If (Screen height:C188>390)
				$sizeWindow:=1024+512
			Else 
				$sizeWindow:=1+512
			End if 
			Path_Set(Storage:C1525.folder.jitLabelsF)
			$lastLabel:=Storage:C1525.folder.jitLabelsF+vtLastLabel  //            look for a way to autoLoad the layout.
			C_LONGINT:C283($incVar)
			ARRAY TEXT:C222(SLVarNames; 23)
			ARRAY LONGINT:C221(SLVarTypes; 23)
			For ($incVar; 1; 10)
				SLVarNames{$incVar}:="vText"+String:C10($incVar)
				SLVarTypes{$incVar}:=2
				SLVarNames{($incVar+10)}:="vR"+String:C10($incVar)
				SLVarTypes{($incVar+10)}:=1
			End for 
			SRDate:=Current date:C33
			SRTime:=Current time:C178*1
			SLVarNames{21}:="SRDate"
			SLVarTypes{21}:=4
			SLVarNames{22}:="SRTime"
			SLVarTypes{22}:=11
			SLVarNames{23}:="vLabelCnt"
			SLVarTypes{23}:=8
			Case of 
				: ($doOne)
					SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
					
					//01/31/03.prf
					//SuperLabel(Table(ptCurTable);"";$sizeWindow;1;1;"Label_Address")
					ALERT:C41("SuperLabel no longer supported")
					
				: ($doMulti)
					If (vHere=1)
						CREATE SET:C116(ptCurTable->; "Current")
					End if 
					ARRAY LONGINT:C221(aRecNums; 0)
					
					Case of 
						: (ptCurTable=(->[Order:3]))
							$ptField:=->[Order:3]labelCount:32
							$doLableRay:=True:C214
						: (ptCurTable=(->[Invoice:26]))
							$ptField:=->[Invoice:26]labelCount:25
							$doLableRay:=True:C214
						Else 
							$doLableRay:=False:C215
					End case 
					If ($doLableRay)
						FIRST RECORD:C50(ptCurTable->)
						For ($i; 1; Records in selection:C76(ptCurTable->))
							If ($ptField-><1)
								INSERT IN ARRAY:C227(aRecNums; 31000; 1)
								aRecNums{Size of array:C274(aRecNums)}:=Record number:C243(ptCurTable->)
							Else 
								If ($ptField->>10)
									CONFIRM:C162("Do you want "+String:C10($ptField->)+" labels for Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+"?")
									If (OK=1)
										$cntLabels:=$ptField->
									Else 
										$cntLabels:=Num:C11(Request:C163("Enter label count for Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000"); "1"))
										If (OK=0)
											$cntLabels:=0
										End if 
									End if 
								Else 
									$cntLabels:=$ptField->
								End if 
								For ($ii; 1; $cntLabels)
									INSERT IN ARRAY:C227(aRecNums; 31000; 1)
									aRecNums{Size of array:C274(aRecNums)}:=Record number:C243(ptCurTable->)
								End for 
							End if 
							NEXT RECORD:C51(ptCurTable->)
						End for 
					End if 
					vlongCnt:=0
					SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
					
					//01/31/03.prf
					
					ALERT:C41("SuperLabel no longer supported")
					
					ARRAY LONGINT:C221(aRecNums; 0)
					ARRAY TEXT:C222(SLVarNames; 0)
					ARRAY LONGINT:C221(SLVarTypes; 0)
					vLabelCnt:=0
					vlongCnt:=0
					vText1:=""
					vText2:=""
					vText3:=""
					vText4:=""
					vText5:=""
					vText6:=""
					vText7:=""
					vText8:=""
			End case 
		End if 
		P_vHereEnd(rptRecNum; doCurFile)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	End if 
	ARRAY LONGINT:C221(aRecNums; 0)
	ARRAY TEXT:C222(SLVarNames; 0)
	ARRAY LONGINT:C221(SLVarTypes; 0)
	
Else 
	$doReport:=True:C214
	If (vHere>1)
		$doReport:=(RecordAcceptTest(booAccept; ptCurTable))  //jStartup0  
	End if 
	If ($doReport)
		// ### jwm ### 20141201_1644 updated to fix label printing errors
		// $doReport:=P_vHereBegin (->rptRecNum;->doCurFile)  // vbSelRecNumdoCurFile could also be affected by P_Primary procedure
		P_vHereBegin  // current version has no parameters
		If ($doReport)
			PRINT LABEL:C39(ptCurTable->; "xyzzxcv")
			// P_vHereEnd (rptRecNum;doCurFile)
			P_vHereEnd  // current version has no parameters
		End if 
	End if 
End if 