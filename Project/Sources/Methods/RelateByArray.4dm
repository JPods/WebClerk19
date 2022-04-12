//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-19T00:00:00, 13:34:13
// ----------------------------------------------------
// Method: RelateByArray
// Description
// Modified: 10/19/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2; $ptTable)
$ptTable:=Table:C252(Table:C252($2))

Case of 
	: (Count parameters:C259<2)
		// drop out without doing anything
	: ((Type:C295($1->)=String array:K8:15) | (Type:C295($1->)=Text array:K8:16))  // string array or text array
		If (Size of array:C274($1->)>0)
			QUERY WITH ARRAY:C644($2->; $1->)  // pointer to the field to be searched
			If (Records in selection:C76($ptTable->)>0)
				ProcessTableOpen(Table:C252($2))
			End if 
		End if 
	: (Type:C295($1->)=LongInt array:K8:19)  // longint array
		If (Size of array:C274($1->)>0)
			QUERY WITH ARRAY:C644($2->; $1->)  // pointer to the field to be searched
			If (Records in selection:C76($ptTable->)>0)
				ProcessTableOpen(Table:C252($2))
			End if 
		End if 
	: (Type:C295($1->)=Is alpha field:K8:1)
		//[Item] Show [ItemSpec] 20131017.4d
		ARRAY TEXT:C222($aQueryByText; 0)
		SELECTION TO ARRAY:C260($1->; $aQueryByText)  // pointer to the value to search for
		QUERY WITH ARRAY:C644($2->; $aQueryByText)  // pointer to the field to be searched
		If (Records in selection:C76($ptTable->)>0)
			ProcessTableOpen(Table:C252($2))
		End if 
		ARRAY TEXT:C222($aQueryByText; 0)
	: (Type:C295($1->)=Is longint:K8:6)
		ARRAY LONGINT:C221($aQueryByLong; 0)
		SELECTION TO ARRAY:C260($1->; $aQueryByLong)  // pointer to the value to search for
		QUERY WITH ARRAY:C644($2->; $aQueryByLong)  // pointer to the field to be searched
		If (Records in selection:C76($ptTable->)>0)
			ProcessTableOpen(Table:C252($2))
		End if 
		ARRAY LONGINT:C221($aQueryByLong; 0)
End case 
CANCEL:C270