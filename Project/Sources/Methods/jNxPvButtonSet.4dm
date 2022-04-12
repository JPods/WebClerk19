//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/06/17, 11:05:16
// ----------------------------------------------------
// Method: jNxPvButtonSet
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($cntParam)
C_POINTER:C301($1)
//TRACE
If (Count parameters:C259>0)
	If ((vHere>2) & (Size of array:C274($1->)>0))  //
		Case of 
			: ((Record number:C243(ptCurTable->)=-3) | (Size of array:C274($1->)<2))
				OBJECT SET ENABLED:C1123(bPrevious; False:C215)
				OBJECT SET ENABLED:C1123(bNext; False:C215)
			: ($1->=1)  //2 or more records
				OBJECT SET ENABLED:C1123(bPrevious; False:C215)
				OBJECT SET ENABLED:C1123(bNext; True:C214)
			: ($1->=Size of array:C274($1->))
				OBJECT SET ENABLED:C1123(bPrevious; True:C214)
				OBJECT SET ENABLED:C1123(bNext; False:C215)
			Else 
				OBJECT SET ENABLED:C1123(bPrevious; True:C214)
				OBJECT SET ENABLED:C1123(bNext; True:C214)
		End case 
		$doRecBut:=False:C215
	Else 
		$doRecBut:=True:C214
	End if 
Else 
	$doRecBut:=True:C214
End if 
If ($doRecBut)
	Case of 
		: ((Record number:C243(ptCurTable->)=-3) | (Records in selection:C76(ptCurTable->)<2))
			OBJECT SET ENABLED:C1123(bPrevious; False:C215)
			OBJECT SET ENABLED:C1123(bNext; False:C215)
		: (Selected record number:C246(ptCurTable->)=1)  //2 or more records
			OBJECT SET ENABLED:C1123(bPrevious; False:C215)
			OBJECT SET ENABLED:C1123(bNext; True:C214)
		: (Selected record number:C246(ptCurTable->)=Records in selection:C76(ptCurTable->))
			OBJECT SET ENABLED:C1123(bPrevious; True:C214)
			OBJECT SET ENABLED:C1123(bNext; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(bPrevious; True:C214)
			OBJECT SET ENABLED:C1123(bNext; True:C214)
	End case 
End if 
booPreNext:=False:C215
C_LONGINT:C283($Process)
C_TEXT:C284($User; $Machine; $Name)
If (False:C215)
	
End if 

If (ptCurTable#(->[Control:1]))
	Set_Window_Title(ptCurTable)
End if 