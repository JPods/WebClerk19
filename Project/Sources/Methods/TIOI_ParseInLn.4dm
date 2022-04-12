//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/01/16, 15:25:15
// ----------------------------------------------------
// Method: TIOI_ParseInLn
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160201_1525 commented out test for document type

C_LONGINT:C283($0)  //Error in In-Line Parse
C_POINTER:C301($1)  //pointer to Info from a Field Row of a TextOut Doc
C_LONGINT:C283($soa)
$0:=-1
C_POINTER:C301($Ptr)
$Ptr:=TIO_ParseString($1)
If (Not:C34(Is nil pointer:C315($Ptr)))
	If (Is macOS:C1572)
		$pos:=Position:C15(":"; $Ptr->)  //look for folder name dividers ":"
	Else 
		$pos:=Position:C15("\\"; $Ptr->)  //look for folder name dividers "\"
	End if 
	C_TEXT:C284(tTIOPath)
	If ($pos=0)
		tTIOPath:=tPlugInPath+$Ptr->
	Else 
		tTIOPath:=$Ptr->
	End if 
	If (Test path name:C476(tTIOPath)>=0)
		C_BOOLEAN:C305($isText)
		//If (Is macOS)  //only check for doc type on mac
		//$isText:=(Document type(tTIOPath)="TEXT")
		//Else 
		//$isText:=True
		//End if 
		//If ($isText)
		$0:=TIOI_Parse(->tTIOPath; True:C214)  //true:parse in-line
		//End if 
	End if 
End if 