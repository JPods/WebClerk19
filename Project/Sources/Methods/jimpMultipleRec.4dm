//%attributes = {"publishedWeb":true}
//(P)   jimpMultipleRec
//October 25, 1995
C_LONGINT:C283($i; $Match; $Continue)
error:=0
vCount:=0
If ((Size of array:C274(aImpFields)>0) & (Size of array:C274(aImpFields)=Size of array:C274(aMatchField)))
	
	
	
	
	C_LONGINT:C283($estRecs; $lengthAll; $myCount; vCount; $cntActual)
	$estRecs:=0
	$lengthAll:=0
	$myCount:=0
	//$k:=0Num(Request("Enter the approximate number of Records to be
	// imported."))
	//ThermoInitExit ("Testing record count";20;True)
	$viProgressID:=Progress New
	ProgressUpdate($viProgressID; 0; 100; "Testing record count")
	
	If (vSearchBy#"")
		C_LONGINT:C283($fld; $SrFld)
		$fld:=Find in array:C230(aMatchField; vSearchBy)
		$SrFld:=Find in array:C230(theFields; vSearchBy)
		If (($fld=-1) | ($SrFld=-1))
			vSearchBy:=""
		End if 
	End if 
	$cntActual:=0
	$Continue:=1
	While ($Continue>0)
		$cntActual:=$cntActual+1
		$Continue:=jimportSaveRec(1)
		If ($myCount<15)
			$myCount:=$myCount+1
			For ($indexRay; 1; Size of array:C274(aImpFields))
				$lengthAll:=$lengthAll+Length:C16(aImpFields{$indexRay})
			End for 
			If ($myCount=14)
				$estRecs:=Trunc:C95(Get_FileLogSize(vDiaCom)*16/$lengthAll; 0)  //16 not 14 to pad the count
				If ($estRecs<10)
					$estRecs:=1000
				End if 
				//ThermoInitExit (("Estimated Records into Table "+Table name(curTableNum));$estRecs;False)
			End if 
		End if 
		//Thermo_Update (vCount)
		ProgressUpdate($viProgressID; vCount; $estRecs; "Estimated Records into Table ")
		
		If (<>ThermoAbort)
			$Continue:=0
		End if 
	End while 
	ConsoleMessage("Records "+String:C10($cntActual))
	//Thermo_Close 
	Progress QUIT($viProgressID)
	
	
Else 
	If (Size of array:C274(aImpFields)=0)
		ALERT:C41("You must import the first record before data can be saved.")
	Else 
		ALERT:C41("The number of Import Fields and Matching Fields are not equal.")
	End if 
End if 