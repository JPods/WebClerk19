//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/09/20, 21:24:51
// ----------------------------------------------------
// Method: CloneLines
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
C_TEXT:C284($vtPubComments; $vtStatus)
C_OBJECT:C1216($obClone)
$obClone:=New object:C1471
C_LONGINT:C283($viParentNum)
KeyModifierCurrent
If ((Record number:C243($1->)#-3) & (Not:C34((CmdKey=1) & (OptKey=1))))
	ALERT:C41("This feature works only on unsaved documents")
Else 
	//PUSH RECORD([Order])
	//jStart3 
	//POP RECORD([Order])
	doSearch:=0
	jCenterWindow(820; 730; 1)
	DIALOG:C40([Order:3]; "CloneDialog")
	CLOSE WINDOW:C154
	If (myOK=1)
		C_TEXT:C284($putComments)
		Case of 
			: (ptCurTable=(->[Order:3]))
				
				// ### bj ### 20210513_0835  fix this
				PUSH RECORD:C176([Order:3])
				QUERY:C277([Order:3]; [Order:3]idNum:2=aTmpLong1{aTmpLong1})
				
				
				
				OrdLnFillRays
				POP RECORD:C177([Order:3])
				$k:=Size of array:C274(aoUniqueID)  // OrdLnAdd
				For ($i; 1; $k)
					aoLineAction{$i}:=-3
					aoUniqueID{$i}:=-3
					aOLineNum{$i}:=$i
				End for 
				viOrdLnCnt:=$k
				OrderCopy(aTmpLong1{aTmpLong1})
				
				
				OrdLnReCalc(1)
				
				//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
				//  --  CHOPPED  AL_UpdateArrays(eOrdLn2POs; -2)
			: (ptCurTable=(->[Proposal:42]))
				CloneProposalLines(aTmpLong1{aTmpLong1})
				
				//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
				
			: (ptCurTable=(->[PO:39]))
				
		End case 
		
	End if 
End if 

ARRAY TEXT:C222(aTmp20Str1; 0)
ARRAY LONGINT:C221(aTmpLong1; 0)