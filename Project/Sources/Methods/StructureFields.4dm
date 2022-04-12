//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/19/11, 09:29:17
// ----------------------------------------------------
// Method: StructureFields
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1)
C_LONGINT:C283($typeFld; $lenField; $numFld; $k; $w; $tableNum)
C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
$tableNum:=$1
C_TEXT:C284($TList)
If ($tableNum>0)  // should not need this any more
	$TList:="ARTPD B*IL H1234567890qweyuosXfghjkzcvnm"  //5 and 10 are missing in from the Field Type number code  
	//Blobs have a value of 30
	$k:=Get last field number:C255($tableNum)
	ARRAY TEXT:C222(theFields; 0)
	ARRAY TEXT:C222(theTypes; 0)
	ARRAY TEXT:C222(theUniques; 0)
	ARRAY LONGINT:C221(theFldNum; 0)
	//
	For ($numFld; 1; $k)  //Loop for fields
		If (Is field number valid:C1000($tableNum; $numFld))
			
			APPEND TO ARRAY:C911(theFldNum; $numFld)
			APPEND TO ARRAY:C911(theFields; Field name:C257($tableNum; $numFld))  //fill in field and type arrays
			
			// Modified by: Bill James (2015-11-05T00:00:00 v14Convert)
			GET FIELD PROPERTIES:C258($tableNum; $numFld; $typeFld; $lenField; $indexed; $isUnique; $isInvisible)  // file #, field #, type, length, index
			
			APPEND TO ARRAY:C911(theUniques; "i"*Num:C11($indexed))
			Case of 
				: ($typeFld=38)  //object
					APPEND TO ARRAY:C911(theTypes; "*")  // ### jwm ### 20190111_1331
				: ($typeFld=30)  //blob
					APPEND TO ARRAY:C911(theTypes; "*")
				: ($typeFld<12)  //blob
					APPEND TO ARRAY:C911(theTypes; ($TList[[$typeFld+1]]))
				Else 
					APPEND TO ARRAY:C911(theTypes; "")
			End case 
		End if 
	End for 
	StructUnique_u($tableNum)
	$w:=Find in array:C230(<>aTableNums; $tableNum)
	viRecordsInTable:=Records in table:C83(Table:C252($tableNum)->)
	viRecordsInSelection:=Records in selection:C76(Table:C252($tableNum)->)
	vCount:=0
	//  SORT ARRAY(theFields;theTypes;theUniques;theFldNum)
End if 
ARRAY TEXT:C222(aMatchField; 0)
ARRAY TEXT:C222(aMatchType; 0)
ARRAY LONGINT:C221(aMatchNum; 0)
ARRAY LONGINT:C221(aCntMatFlds; 0)
aMatchType:=0