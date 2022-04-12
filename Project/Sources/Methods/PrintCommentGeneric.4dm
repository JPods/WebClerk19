//%attributes = {"publishedWeb":true}
If (False:C215)
	//TCStrong_prf_v310
	//03/30/04.prf 
	//New method to make logging of printing and FAXing generic
	//Covers "SRE", "QRpt", "Ltr", "Doc" types
	//Handles 1 record selections or many record selections
	TCStrong_prf_v312
	//04/13/04.prf
	//Added FR scripts to PrintCommentGeneric
End if 

C_TEXT:C284($1; $ReportType_t)
$ReportType_t:=$1  //"SRE", "QRpt", "Ltr", "Doc", "FR"
C_TEXT:C284($2; $ReportName_t)
$ReportName_t:=$2  //name of report or letter
C_POINTER:C301($3; $pTable; $pIdentifierField)
$pTable:=$3  //pointer to table report or letter was printed for
C_TEXT:C284($4; $ReportMode_t)
$ReportMode_t:=$4  //"FAX", "Print", "RunFR"
C_TEXT:C284($tableName; $Identifier_t; $RecordIDOrTotal; $Comment; $CommentLog)
$tableName:=""
$Identifier_t:=""
$RecordIDOrTotal:=""
$Comment:=""
$CommentLog:=""
C_LONGINT:C283($RIS)

If (($ReportType_t="SRE") | ($ReportType_t="QRpt") | ($ReportType_t="Ltr") | ($ReportType_t="Doc") | ($ReportType_t="FR"))  //these types supported right now
	
	$RIS:=Records in selection:C76($pTable->)
	
	//Set table name variable and remove "s" if necessary
	$tableName:=Table name:C256($pTable)
	If ($tableName[[Length:C16($tableName)]]="s")
		$tableName:=Substring:C12($tableName; 1; Length:C16($tableName)-1)
	End if 
	
	//If 1 record selection, get identifier and convert it to text, else report # of r
	If ($RIS=1)
		$pIdentifierField:=GetIdentifierFieldPointer($pTable)
		Case of 
				
			: (Is nil pointer:C315($pIdentifierField))  //It is possible to get a nil pointer from GetIdentifierFieldPointer
				$Identifier_t:="No Identifier Field in method GetIdentifierFieldPointer!"
				
			: (Type:C295($pIdentifierField->)=Is alpha field:K8:1)
				$Identifier_t:=$pIdentifierField->
				
			: (Type:C295($pIdentifierField->)=Is longint:K8:6)
				$Identifier_t:=String:C10($pIdentifierField->; "0000-0000")
				
		End case 
		$RecordIDOrTotal:=$tableName+" "+$Identifier_t
	Else 
		$RecordIDOrTotal:=String:C10($RIS)+" "+$tableName+" records"
	End if 
	
	//Create log text with correct verbage
	Case of 
		: ($ReportMode_t="FAX")
			$Comment:=DateTimeofDT+"; "+Current user:C182+" - Faxed "+$RecordIDOrTotal+" as "+$ReportName_t
			$CommentLog:=Current user:C182+" - "+$ReportName_t+" faxed "+$RecordIDOrTotal
		: ($ReportMode_t="Print")
			$Comment:=DateTimeofDT+"; "+Current user:C182+" - Printed "+$RecordIDOrTotal+" as "+$ReportName_t
			$CommentLog:=Current user:C182+" - "+$ReportName_t+" printed "+$RecordIDOrTotal
		: ($ReportMode_t="RunFR")
			$Comment:=DateTimeofDT+"; "+Current user:C182+" - Processed "+$RecordIDOrTotal+" as "+$ReportName_t
			$CommentLog:=Current user:C182+" - "+$ReportName_t+" processed "+$RecordIDOrTotal
	End case 
	
	//Elog type of report
	Case of 
			
		: ($ReportType_t="SRE")
			ELog_NewRecord(0; "SuperRpt"; $CommentLog)
		: ($ReportType_t="QRpt")
			ELog_NewRecord(0; "QuickRpt"; $CommentLog)
		: ($ReportType_t="Ltr")
			ELog_NewRecord(0; "LetterRpt"; $CommentLog)
		: ($ReportType_t="Doc")
			ELog_NewRecord(0; "DocRpt"; $CommentLog)
		: ($ReportType_t="FR")
			ELog_NewRecord(0; "Script"; $CommentLog)
	End case 
	
	//Finally add text to CommentProcess for those tables that we have decided to do t
	If (($ReportType_t="SRE") & ($RIS=1))
		Case of 
				
			: ($pTable=(->[Order:3]))
				
				If ([Order:3]commentProcess:12#"")
					[Order:3]commentProcess:12:=Char:C90(13)+[Order:3]commentProcess:12
				End if 
				[Order:3]commentProcess:12:=$Comment+[Order:3]commentProcess:12
				SAVE RECORD:C53([Order:3])
				
			: ($pTable=(->[Proposal:42]))
				
				If ([Proposal:42]commentProcess:64#"")
					[Proposal:42]commentProcess:64:=Char:C90(13)+[Proposal:42]commentProcess:64
				End if 
				[Proposal:42]commentProcess:64:=$Comment+[Proposal:42]commentProcess:64
				SAVE RECORD:C53([Proposal:42])
				
			: ($pTable=(->[Invoice:26]))
				
				If ([Invoice:26]commentProcess:73#"")
					[Invoice:26]commentProcess:73:=Char:C90(13)+[Invoice:26]commentProcess:73
				End if 
				[Invoice:26]commentProcess:73:=$Comment+[Invoice:26]commentProcess:73
				SAVE RECORD:C53([Invoice:26])
				
			: ($pTable=(->[PO:39]))
				
				If ([PO:39]commentProcess:63#"")
					[PO:39]commentProcess:63:=Char:C90(13)+[PO:39]commentProcess:63
				End if 
				[PO:39]commentProcess:63:=$Comment+[PO:39]commentProcess:63
				SAVE RECORD:C53([PO:39])
				
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[PO:39]orderNum:18)
				If (Records in selection:C76([Order:3])=1)
					If ([Order:3]commentProcess:12#"")
						[Order:3]commentProcess:12:=Char:C90(13)+[Order:3]commentProcess:12
					End if 
					[Order:3]commentProcess:12:=$Comment+[Order:3]commentProcess:12
					SAVE RECORD:C53([Order:3])
				End if 
				
		End case 
	End if 
	
End if 

//End of routine