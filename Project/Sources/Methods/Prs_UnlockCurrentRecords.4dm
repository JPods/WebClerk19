//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-03T00:00:00, 13:00:56
// ----------------------------------------------------
// Method: Prs_UnlockCurrentRecords
// Description
// Modified: 08/03/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// Records locked by this, are to be worked on in a new process. 
// When that child process closes, 
// the parent process records should be unlocked
// and the Title bar reset


// MustFixQQQZZZ: Bill James (2021-12-09T06:00:00Z)

C_LONGINT:C283($cntTables; $incTable)

ARRAY LONGINT:C221(<>aPrsRelatedParentTable; 0)
ARRAY LONGINT:C221(<>aPrsRelatedParentRecord; 0)
C_LONGINT:C283(vHere)
// make sure there are not locked records. Ignor the control table
If (vHere>1)
	// Modified by: William James (2013-08-03T00:00:00)
	// fixThis  commented out the unload record as it was 
	// was unloading unsaved changes and the current record
	// we want the records in the next process to have access to the data and change the current records
	AcceptPrint
	$cntTables:=Get last table number:C254
	For ($incTable; 2; $cntTables)
		If (Record number:C243(Table:C252($incTable)->)>-1)
			INSERT IN ARRAY:C227(<>aPrsRelatedParentTable; 1; 1)
			INSERT IN ARRAY:C227(<>aPrsRelatedParentRecord; 1; 1)
			<>aPrsRelatedParentTable{1}:=$incTable
			<>aPrsRelatedParentRecord{1}:=Record number:C243(Table:C252($incTable)->)
			If (False:C215)
				If (Table:C252($incTable)=ptCurTable)  //  ????? Intended to unlock the customer record in an opening recording.
					READ ONLY:C145(ptCurTable->)
					LOAD RECORD:C52(ptCurTable->)
					SET WINDOW TITLE:C213("LOCKED BY NEW PROCESS")
				Else 
					UNLOAD RECORD:C212(Table:C252($incTable)->)
				End if 
			End if 
		End if 
	End for 
Else 
	$cntTables:=Get last table number:C254
	For ($incTable; 2; $cntTables)
		UNLOAD RECORD:C212(Table:C252($incTable)->)
	End for 
End if 