//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/04/19, 10:05:51
// ----------------------------------------------------
// Method: Blob_To_Document
// Description
//   Removed Mac creator and document type
//
// Parameters
// ----------------------------------------------------



C_TIME:C306($vDocref)
C_BLOB:C604($1; $BLOB)
$BLOB:=$1
C_TEXT:C284($2; $myDocName)
$myDocName:=$2
C_LONGINT:C283($0)

If (BLOB size:C605($BLOB)>0)  //04/11/03.prf
	
	$vDocref:=Create document:C266($myDocName)
	
	If (OK=1)
		CLOSE DOCUMENT:C267($vDocref)
		BLOB TO DOCUMENT:C526($myDocName; $BLOB)
		
	End if 
	
	$0:=Num:C11(OK=0)
	
Else 
	
	$0:=-1  //04/11/03.prf
	
End if 