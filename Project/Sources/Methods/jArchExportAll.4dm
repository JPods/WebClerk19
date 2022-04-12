//%attributes = {"publishedWeb":true}
//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/28/11, 17:03:00
// ----------------------------------------------------
// Method: jArchExportAll
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
If (Count parameters:C259=1)
	myDocName:=$1
Else 
	myDocName:=""
End if 
C_TEXT:C284($fieldStr; $delim)
C_LONGINT:C283(bExportAll; vIndicFreq)
//Procedure: jArchExportAll
//January 2, 1997
C_LONGINT:C283($c; $k; $i; $theEnd; $myOK)
$k:=Records in selection:C76(Table:C252(curTableNum)->)
$c:=Size of array:C274(aMatchField)
If (($k>0) & ($c>0))
	READ ONLY:C145(Table:C252(curTableNum)->)
	FIRST RECORD:C50(Table:C252(curTableNum)->)
	If (myDocName="")
		$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
	Else 
		myDoc:=Create document:C266(myDocName)
		$myOK:=OK
	End if 
	If ($myOK=1)
		ConsoleMessage(Table name:C256(curTableNum)+" records: "+String:C10($k))
		//    ON EVENT CALL("jotcCmdQAction")
		//ThermoInitExit (("Exporting from File:  "+Table name(curTableNum));$k;True)
		
		ARRAY LONGINT:C221(aExportFormat; 0)
		$delim:=vFldDelim
		For ($i; 1; $c)
			INSERT IN ARRAY:C227(aExportFormat; $i; 1)
			$fieldStr:=vFldSepBeg+aMatchField{$i}+vFldSepEnd
			Case of 
				: (Position:C15("email"; $fieldStr)>0)
					aExportFormat{$i}:=2
				: (Position:C15("phone"; $fieldStr)>0)
					aExportFormat{$i}:=1
				: (Position:C15("fax"; $fieldStr)>0)
					aExportFormat{$i}:=1
				Else 
					aExportFormat{$i}:=0
			End case 
			If (<>vbExportEndRecord)
				$delim:=vFldDelim
			Else 
				If ($i=$c)
					$delim:=vRecDelim
					//TRACE
				Else 
					$theDelim:=vFldDelim
				End if 
			End if 
			SEND PACKET:C103(myDoc; $fieldStr+$delim)
		End for 
		If (<>vbExportEndRecord)
			SEND PACKET:C103(myDoc; vFldSepBeg+"EndRecord"+vFldSepEnd+vRecDelim)
		End if 
		ExportMultipleI($k; $c)
		CLOSE DOCUMENT:C267(myDoc)
		ARRAY LONGINT:C221(aExportFormat; 0)
		//Thermo_Close 
	Else 
		Case of 
			: ($k=0)
				ConsoleMessage("There are no records in File "+Table name:C256(curTableNum)+" to export.")
			: ($c<0)
				ConsoleMessage("There are no fields selected to export.")
		End case 
		OK:=$myOK
	End if 
	//  ON EVENT CALL("")
	READ WRITE:C146(Table:C252(curTableNum)->)
End if 