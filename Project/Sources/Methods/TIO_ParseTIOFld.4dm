//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/01/16, 15:20:47
// ----------------------------------------------------
// Method: TIO_ParseTIOFld
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160201_1520 commented out test for document type

C_POINTER:C301($0)  //Resulting pointer to a field
C_POINTER:C301($1)  //pointer to Info from a Field Row of a TextOut Doc
C_LONGINT:C283($soa)
C_POINTER:C301($Ptr)
$Ptr:=TIO_ParseString($1)
If (Not:C34(Is nil pointer:C315($Ptr)))
	If (Is macOS:C1572)
		$pos:=Position:C15(":"; $Ptr->)  //look for folder name dividers ":"
	Else 
		$pos:=Position:C15("\\"; $Ptr->)  //look for folder name dividers "\"
	End if 
	C_TEXT:C284($Path)
	If ($pos=0)
		$Path:=tPlugInPath+$Ptr->
	Else 
		$Path:=$Ptr->
	End if 
	If (Test path name:C476($Path)>=0)
		//If (Document type($Path)="TEXT")
		$soa:=Size of array:C274(aTIOText)+1
		INSERT IN ARRAY:C227(aTIOText; $soa)
		aTIOText{$soa}:=$Path
		$0:=->aTIOText{$soa}
		//End if 
	End if 
End if 