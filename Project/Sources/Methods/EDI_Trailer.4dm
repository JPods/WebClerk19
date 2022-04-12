//%attributes = {}
//Script EDI_Trailer.4d

//<declarations>
//==================================
//  Type variables
//==================================

// $atGE;$atIEA
C_LONGINT:C283($vi1; $vi2; $viGS; $viISA)
C_TEXT:C284($vtDateString; $vtDelimiter; $vtGE; $vtIEA; $vtTimeString)

//==================================
//  Initialize variables
//==================================

$vi1:=0
$vi2:=0
$viGS:=0
$viISA:=0
$vtDateString:=""
$vtDelimiter:=""
$vtGE:=""
$vtIEA:=""
$vtTimeString:=""
//</declarations>

$vtDelimiter:=OB Get:C1224([EDISetID:76]ObGeneral:16; "Delimiter")
$viISA:=OB Get:C1224([EDISetID:76]ObGeneral:16; "ISA")
$viGS:=OB Get:C1224([EDISetID:76]ObGeneral:16; "GS")
$vtDateString:=OB Get:C1224([EDISetID:76]ObGeneral:16; "DateString")
$vtTimeString:=OB Get:C1224([EDISetID:76]ObGeneral:16; "TimeString")

//retrieve EDI Control Numbers
$vtIEA:=String:C10($viISA; "000000000")  //Interchange Control Number
$vtGE:=String:C10($viGS)  //Group Control Number

ARRAY TEXT:C222($atGE; 0)
APPEND TO ARRAY:C911($atGE; "GE")  // segment header
APPEND TO ARRAY:C911($atGE; "1")  // GE01Number of Functional groups in transactionM ID 1/ 6
APPEND TO ARRAY:C911($atGE; $vtGE)  // GE02Group Control NumberM NO 1/ 9

ARRAY TEXT:C222($atIEA; 0)
APPEND TO ARRAY:C911($atIEA; "IEA")  // segment header
APPEND TO ARRAY:C911($atIEA; "1")  // IEA01Number of Functional groups in transactionM ID 1/ 5
APPEND TO ARRAY:C911($atIEA; $vtIEA)  // IEA02Interchange Control Number M NO 1/ 9

$vtIEA:=""
$vi2:=Size of array:C274($atIEA)
For ($vi1; 1; $vi2)
	If ($vi1>1)
		$vtIEA:=$vtIEA+$vtDelimiter
	End if 
	$vtIEA:=$vtIEA+$atIEA{$vi1}
End for 

$vtGE:=""
$vi2:=Size of array:C274($atGE)
For ($vi1; 1; $vi2)
	If ($vi1>1)
		$vtGE:=$vtGE+$vtDelimiter
	End if 
	$vtGE:=$vtGE+$atGE{$vi1}
End for 

$0:=$vtGE+"\r\n"+$vtIEA+"\r\n"

//ConsoleMessage(vText)
