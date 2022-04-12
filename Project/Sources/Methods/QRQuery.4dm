//%attributes = {}
//Method QRQUERY - arkware.dmb 7/26/05

C_LONGINT:C283($i; $QueryCount)
C_BOOLEAN:C305($firstOne)
C_POINTER:C301(${1})  // See the 4D Compiler manual.

C_POINTER:C301(aQryTable)

// use the passed parameters to set up the arrays used in the 
//   QuickFind dialog, even if they're marked as invisible or non-indexed.    
$QueryCount:=Count parameters:C259
ARRAY POINTER:C280(aQueryFlds; $QueryCount)  // A pointer to the field available in the query.

For ($i; 1; $QueryCount)
	aQueryFlds{$i}:=${$i}
End for 
aQryTable:=Table:C252(Table:C252(aQueryFlds{1}))

$firstOne:=True:C214  // Oh, the joys of constructing a built query.  :-)

For ($i; 1; $QueryCount-1)
	
	$fieldType:=Type:C295(aQueryFlds{$i})
	
	//If (bQuerySelection=0)
	If ($firstOne)
		QUERY:C277(aQryTable->; aQueryFlds{$i}->=aQueryFlds{$i+1}->; *)
		$firstOne:=False:C215
	Else 
		QUERY:C277(aQryTable->;  & ; aQueryFlds{$i}->=aQueryFlds{$i+1}->; *)
	End if 
	
	$i:=$i+1  //skip every other one.
End for 

QUERY:C277(aQryTable->)

$0:=Records in selection:C76(aQryTable->)


