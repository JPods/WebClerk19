//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/19/14, 14:46:27
// ----------------------------------------------------
// Method: RECORDS IN NAMED SELECTION
// Description
// 
//
// Parameters
// ---------------------------------------------------

// Method Name: RECORDS IN NAMED SELECTION
// Description: Returns the number of records in the named selection
// A return value of -1 represents the named selection does not exist
// A return value of -2 represents an invalid table name
// A return value of -5 means an error happened for which it is not defined in this code
// ### jwm ### 20180116_1606 cjhanged the name of the method from NamedSelectionRecordsIn to RECORDS IN NAMED SELECTION
// This Method name could be changed to CAmel Case without the spaces at a later time.

//  Referenced object   Parameters                                      
//                      varName                 tableNum                fieldNum
//  None (NIL pointer)  "" (empty string)       0                       0
//  Variable            Name of the variable    -1                      -1
//  Array               Name of the array       -1                      -1
//  Array element       Name of the array       Element number          -1
//  2D array element    Name of the 2D array    Element row number      Element column number
//  Table               "" (empty string)       Table number            0                      <----<<
//  Field               "" (empty string)       Table number            Field number

If (Count parameters:C259=2)
	
	C_LONGINT:C283($0)  // number of records found
	C_POINTER:C301($1)  // pointer to table
	C_TEXT:C284($2)  // name of selection
	C_LONGINT:C283(recError; undefinedError; $viTableNum; $viFieldNum)
	C_TEXT:C284($methOnErrCurrent; $vtName)
	ARRAY LONGINT:C221($rec_al; 0)
	
	undefinedError:=-5
	recError:=0
	
	$methOnErrCurrent:=Method called on error:C704
	ON ERR CALL:C155("NamedSelectionError")
	RESOLVE POINTER:C394($1; $vtName; $viTableNum; $viFieldNum)
	If (($vtName="") & ($viTAbleNum>0) & ($viFieldNum=0))  // resolves to valid table pointer
		LONGINT ARRAY FROM SELECTION:C647($1->; $rec_al; $2)
	Else 
		recError:=59
	End if 
	
	ON ERR CALL:C155($methOnErrCurrent)
	
	Case of 
		: (recError=0)
			// no error
			$0:=Size of array:C274($rec_al)
			
		: (recError=-9977)
			// -9977 = no named selection matching that name
			$0:=-1
			
		: (recError=59)
			// 59 = 4D was expecting a table
			$0:=-2
			
		Else 
			// some other error that is not yet defined in these case statements
			// for now we will return -5 but this code can be improved later
			$0:=undefinedError
			
	End case 
	
End if 


