//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/31/07, 11:24:59
// ----------------------------------------------------
// Method: RptUsageItemMonth
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($itemNum; $1; $stringYearMonth)
C_LONGINT:C283($yearOf; $2)
C_LONGINT:C283($monthOf; $3)
$stringYearMonth:=String:C10($yearOf)+String:C10($monthOf)
QUERY:C277([TallyResult:73]; [TallyResult:73]Purpose:2="EOM_InventoryReport"; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]Name:1="EOM_"+$stringYearMonth)
Case of 
	: (Records in selection:C76([TallyResult:73])=0)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]Purpose:2:="EOM_InventoryReport"
		[TallyResult:73]Name:1:="EOM_"+$stringYearMonth
		
		
End case 