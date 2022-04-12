//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:19:11
// ----------------------------------------------------
// Method: TIO_ParseFRDoc
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160201_1519 commented out test for document type

C_POINTER:C301($0; $Ptr)  //Resulting pointer to a picture w/ tokenized FR
C_POINTER:C301($1)  //pointer to Info from a FR File Row of a TextOut Doc
$0:=<>cptNilPoint
$Ptr:=TIO_ParseString($1)
If (Not:C34(Is nil pointer:C315($Ptr)))
	C_LONGINT:C283($pos)
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
		// ### jwm ### 20160113_1616
		// OBSOLETE Mac OS X does not always have document Type
		//If (Is macOS)
		//$isText:=(Document type($Path)="TEXT")
		//Else 
		//$isText:=True
		//End if 
		// ### jwm ### 20160113_1616 Always parse script if it exists
		//If ($isText)  
		C_TIME:C306($FileID)
		$FileID:=Open document:C264($Path)
		If (OK=1)
			<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
			RECEIVE PACKET:C104($FileID; tTIOPath; <>vEoF)  //get the whole doc  // ### jwm ### 20160816_1602
			//RECEIVE PACKET($FileID;tTIOPath;32766)  //get the whole doc
			$0:=TIO_ParseFRText(->tTIOPath)
			CLOSE DOCUMENT:C267($FileID)
		End if 
		//End if 
	End if 
End if 