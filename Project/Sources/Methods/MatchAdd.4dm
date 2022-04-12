//%attributes = {"publishedWeb":true}
//Procedure: MatchAdd
C_LONGINT:C283(bAddToImpor; $2; $i; $k; $inc; $raySize)
C_BOOLEAN:C305($1)
C_LONGINT:C283($viVertMatch; $viHorzMatch; $currentaMatchType)
$currentaMatchType:=aMatchType
//  CHOPPED  AL_GetScroll(eMatchList; $viVertMatch; $viHorzMatch)
ARRAY LONGINT:C221(aMatchLine; 0)
//  StructureFields  field characteristics

// ### bj ### 20181127_2228
$k:=Size of array:C274(aFieldLns)
For ($i; $k; 1; -1)
	If ((theTypes{aFieldLns{$i}}="*") | (theTypes{aFieldLns{$i}}=" "))
		// Modified by: Bill James (2016-05-19T00:00:00 removed noisy messaging
		// jAlertMessage (9211)
	Else 
		If (Find in array:C230(aMatchNum; theFldNum{aFieldLns{$i}})#-1)
			// Modified by: Bill James (2016-05-19T00:00:00 removed noisy messaging
			// jAlertMessage (9212)
		End if 
		If (((doSearch=2) & ($2=Size of array:C274(aMatchField))) | ($2=0))
			$raySize:=$2+1
		Else 
			$raySize:=$2
		End if 
		INSERT IN ARRAY:C227(aMatchField; $raySize)
		INSERT IN ARRAY:C227(aMatchType; $raySize)
		INSERT IN ARRAY:C227(aMatchNum; $raySize)
		aMatchField{$raySize}:=theFields{aFieldLns{$i}}
		aMatchType{$raySize}:=theTypes{aFieldLns{$i}}
		aMatchNum{$raySize}:=theFldNum{aFieldLns{$i}}
	End if 
End for 
aMatchType:=Size of array:C274(aMatchType)


If (Size of array:C274(aMatchType)>0)
	APPEND TO ARRAY:C911(aMatchLine; Size of array:C274(aMatchType))
End if 


C_LONGINT:C283($inc; $sizeCounterRay)
$sizeCounterRay:=Size of array:C274(aMatchField)
ARRAY LONGINT:C221(aCntMatFlds; $sizeCounterRay)
For ($inc; 1; $sizeCounterRay)
	aCntMatFlds{$inc}:=$inc
End for 
If (eMatchList>0)
	ARRAY LONGINT:C221($selectedArray; 1)
	//  --  CHOPPED  AL_UpdateArrays(eMatchList; Size of array(aCntMatFlds))
	If (doSearch=3)  // inserting
		$selectedArray{1}:=$currentaMatchType
		// -- AL_SetSelect(eMatchList; $selectedArray)
		// -- AL_SetScroll(eMatchList; $currentaMatchType; $viHorzMatch)
	Else 
		$selectedArray{1}:=$sizeCounterRay
		// -- AL_SetSelect(eMatchList; $selectedArray)
		// -- AL_SetScroll(eMatchList; $sizeCounterRay; $viHorzMatch)
	End if 
End if 
If (Size of array:C274(aFieldLns)>0)
	If (eExportFlds#0)
		//  CHOPPED  AL_GetScroll(eExportFlds; viVert; viHorz)
	End if 
	$i:=aFieldLns{1}
	If ($i<Size of array:C274(theFields))
		Repeat 
			$i:=$i+1
		Until (((theTypes{$i}#"*") & (theTypes{$i}#" ")) | ($i=Size of array:C274(theFields)))
		ARRAY LONGINT:C221(aFieldLns; 1)
		aFieldLns{1}:=$i
		viVert:=viVert+1
	Else 
		aFieldLns{1}:=1
		viVert:=1
	End if   //
	If (eExportFlds#0)
		//  --  CHOPPED  AL_UpdateArrays(eExportFlds; -2)
		// // -- AL_SetSelect (eExportFlds;aFieldLns)
		// // -- AL_SetScroll (eExportFlds;viVert;viHorz)
	End if 
	If (eMatchList#0)
		//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
		// -- AL_SetSelect(eExportFlds; aFieldLns)
		// -- AL_SetScroll(eExportFlds; viVert; viHorz)
	End if 
End if   //
