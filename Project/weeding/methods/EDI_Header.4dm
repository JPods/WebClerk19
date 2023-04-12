//%attributes = {}

//Script EDI_Header.4d

//<declarations>
//==================================
//  Type variables
//==================================

// $atGS;$atISA
C_LONGINT:C283($vi1; $vi2; $viGS; $viISA)
C_TEXT:C284($vtDateString6; $vtDateString8; $vtDelimiter; $vtGS; $vtID; $vtISA; $vtReceiverID)
C_TEXT:C284($vtReceiverIDQualifier; $vtSenderID; $vtSenderQualifier; $vtTimeString)

//==================================
//  Initialize variables
//==================================

$vi1:=0
$vi2:=0
$viGS:=0
$viISA:=0
$vtDateString6:=""
$vtDateString8:=""
$vtDelimiter:=""
$vtGS:=""
$vtID:=""
$vtISA:=""
$vtReceiverID:=""
$vtReceiverIDQualifier:=""
$vtSenderID:=""
$vtSenderQualifier:=""
$vtTimeString:=""
//</declarations>
TRACE:C157
$vtSenderQualifier:=OB Get:C1224([EDISetID:76]obGeneral:16; "SenderIDQualifier")
$vtSenderID:=OB Get:C1224([EDISetID:76]obGeneral:16; "SenderID")
$vtReceiverIDQualifier:=OB Get:C1224([EDISetID:76]obGeneral:16; "ReceiverIDQualifier")
$vtReceiverID:=OB Get:C1224([EDISetID:76]obGeneral:16; "ReceiverID")
$vtDelimiter:=OB Get:C1224([EDISetID:76]obGeneral:16; "Delimiter")
$vtDocumentType:=OB Get:C1224([EDISetID:76]obGeneral:16; "DocumentType")
$viISA:=OB Get:C1224([EDISetID:76]obGeneral:16; "ISA")+1
$viGS:=OB Get:C1224([EDISetID:76]obGeneral:16; "GS")+1
$vtDateString6:=Substring:C12(String:C10(Year of:C25(Current date:C33)); 3; 2)+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")
$vtDateString8:=String:C10(Year of:C25(Current date:C33); "0000")+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")
$vtTimeString:=Replace string:C233(String:C10(Current time:C178; 2); ":"; "")

OB SET:C1220([EDISetID:76]obGeneral:16; "ISA"; $viISA)
OB SET:C1220([EDISetID:76]obGeneral:16; "GS"; $viGS)
OB SET:C1220([EDISetID:76]obGeneral:16; "Modified"; String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178))
OB SET:C1220([EDISetID:76]obGeneral:16; "DateString"; $vtDateString8)
OB SET:C1220([EDISetID:76]obGeneral:16; "TimeString"; $vtTimeString)

Case of 
	: ($vtDocumentType="Invoice@")
		OB SET:C1220([EDISetID:76]obGeneral:16; "DocumentNum"; [Invoice:26]idNum:2)
	: ($vtDocumentType="Order@")
		OB SET:C1220([EDISetID:76]obGeneral:16; "DocumentNum"; [Order:3]idNum:2)
End case 

SAVE RECORD:C53([EDISetID:76])

ARRAY TEXT:C222($atISA; 0)
APPEND TO ARRAY:C911($atISA; "ISA")  // segment header
APPEND TO ARRAY:C911($atISA; "00")  // ISA01Authorization Information Qualifier00 Not UsedM ID 2/ 2
APPEND TO ARRAY:C911($atISA; (" "*10))  // ISA02Authorization Information M AN 10/ 10
APPEND TO ARRAY:C911($atISA; "00")  // ISA03Security Information Qualifier00 Not UsedM ID 2/ 2
APPEND TO ARRAY:C911($atISA; (" "*10))  // ISA04Security InformationM AN 10/ 10
APPEND TO ARRAY:C911($atISA; $vtSenderQualifier)  // ISA05Sender ID QualifierM ID 2/ 2
$vtID:=Change string:C234((" "*15); $vtSenderID; 1)
APPEND TO ARRAY:C911($atISA; $vtID)  // ISA06Sender IDM AN 15/ 15
APPEND TO ARRAY:C911($atISA; $vtReceiverIDQualifier)  // ISA07ReceiverID QualifierM ID 2/ 2
$vtID:=Change string:C234((" "*15); $vtReceiverID; 1)
APPEND TO ARRAY:C911($atISA; $vtID)  // ISA08ReceiverIDM AN 15/ 15
APPEND TO ARRAY:C911($atISA; $vtDateString6)  // ISA09Date M DT 6/ 6
APPEND TO ARRAY:C911($atISA; $vtTimeString)  // ISA10TimeM TM 4/ 4
APPEND TO ARRAY:C911($atISA; "U")  // ISA11Interchange Control Standards IdentifierU U.S. EDI
APPEND TO ARRAY:C911($atISA; "00400")  // ISA12Interchange Control Version NumberM ID 5/ 5
$vtISA:=String:C10($viISA; ("0"*9))
APPEND TO ARRAY:C911($atISA; $vtISA)  // ISA13Interchange Control NumberM N0 9/ 9
APPEND TO ARRAY:C911($atISA; "1")  // ISA14Acknowledgement RequestedM ID 1/ 1
APPEND TO ARRAY:C911($atISA; "P")  // ISA15Usage Indicator P=production T=testM ID 1/ 1
APPEND TO ARRAY:C911($atISA; "^")  // ISA16Component Element SeparatorM AN 1/ 1

$vtISA:=""
$vi2:=Size of array:C274($atISA)
For ($vi1; 1; $vi2)
	If ($vi1>1)
		$vtISA:=$vtISA+$vtDelimiter
	End if 
	$vtISA:=$vtISA+$atISA{$vi1}
End for 

ARRAY TEXT:C222($atGS; 0)
APPEND TO ARRAY:C911($atGS; "GS")  // segment header
APPEND TO ARRAY:C911($atGS; "IN")  // GS01Code Identifying Information Type IN = InvoiceM ID 2/ 2
APPEND TO ARRAY:C911($atGS; $vtSenderID)  // GS02Sender ID Code M AN 2/ 15
APPEND TO ARRAY:C911($atGS; $vtReceiverID)  // GS03ReceiverIDM AN 2/ 15
APPEND TO ARRAY:C911($atGS; $vtDateString8)  // GS04Transmission Date.M AN 8/ 8
APPEND TO ARRAY:C911($atGS; $vtTimeString)  // GS05TimeM TM 4/ 4
$vtGS:=String:C10($viGS)
APPEND TO ARRAY:C911($atGS; $vtGS)  // GS06Group Control NumberM N0 1/ 9
APPEND TO ARRAY:C911($atGS; "X")  // GS07Transaction Type CodeM ID 1/ 2
APPEND TO ARRAY:C911($atGS; "004010")  // GS08Version and ReleaseM AN 1/ 12

$vtGS:=""
$vi2:=Size of array:C274($atGS)
For ($vi1; 1; $vi2)
	If ($vi1>1)
		$vtGS:=$vtGS+$vtDelimiter
	End if 
	$vtGS:=$vtGS+$atGS{$vi1}
End for 

$0:=$vtISA+"\r\n"+$vtGS+"\r\n"
//ConsoleLog(vText)
