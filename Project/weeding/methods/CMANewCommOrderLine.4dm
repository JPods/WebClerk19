//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/21/12, 16:51:31
// ----------------------------------------------------
// Method: CMANewCommOrderLine
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $pathManage; $7; $inTest)
C_REAL:C285($2; $backlog; $3; $valueInvoiced; $8; $commission; $9; $split)
C_DATE:C307($4; $lastDate)
C_TEXT:C284($5; $lastInvoice; $6; $lastCriteria)

QUERY:C277([Item:4]; [Item:4]itemNum:1="com"+[Order:3]mfrID:52+"@")
FIRST RECORD:C50([Item:4])

C_LONGINT:C283($i; $k; $inTest)
$pathManage:=$1
$backlog:=$2
$valueInvoiced:=$3
$lastDate:=$4
$lastInvoice:=$5
$lastCriteria:=$6
$inTest:=viOrdLnCnt
$commission:=$8
$split:=$9
Case of 
	: ($pathManage=-1)  //OrderComm Window
		
		
		CREATE RECORD:C68([OrderLine:49])
		
		[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
		viOrdLnCnt:=viOrdLnCnt+1
		[OrderLine:49]seq:30:=viOrdLnCnt
		[OrderLine:49]orderNum:1:=[Order:3]orderNum:2
		
		[OrderLine:49]itemNum:4:="OS_"+[Item:4]itemNum:1
		[OrderLine:49]location:22:=[Item:4]location:9
		
		[OrderLine:49]commRep:16:=Round:C94($backlog*$commission*0.01*$split*0.01; 2)
		[OrderLine:49]commSales:17:=Round:C94($backlog*$commission*0.01*((100-$split)*0.01); 2)
		[OrderLine:49]commRateRep:18:=Round:C94([OrderLine:49]commRep:16/$valueInvoiced*100; 2)  //changed from vAmount
		[OrderLine:49]commRateSales:29:=Round:C94([OrderLine:49]commSales:17/$valueInvoiced*100; 2)  //changed from vAmount
		
		If (False:C215)
			[OrderLine:49]commRep:16:=Round:C94($valueInvoiced*$commission*0.01*$split*0.01; 2)
			[OrderLine:49]commSales:17:=Round:C94($valueInvoiced*$commission*0.01*((100-$split)*0.01); 2)
			[OrderLine:49]commRateRep:18:=Round:C94([OrderLine:49]commRep:16/vAmount*100; 2)  //changed from vAmount
			[OrderLine:49]commRateSales:29:=Round:C94([OrderLine:49]commSales:17/vAmount*100; 2)  //changed from vAmount
		End if 
		If (False:C215)  //CMAComOrderOneLine
			[OrderLine:49]commRep:16:=Round:C94(vR3; <>tcDecimalTt)
			[OrderLine:49]commSales:17:=Round:C94(vR1-vR3; <>tcDecimalTt)
			[OrderLine:49]commRateSales:29:=Round:C94((vR1-vR3)/vAmount*100; 1)
			[OrderLine:49]commRateRep:18:=Round:C94(vR3/vAmount*100; 1)
			
			[OrderLine:49]commRateRep:18:=([Item:4]priceMSR:109-[Item:4]costMSC:110)*[Item:4]indicator1:95
			[OrderLine:49]commRateSales:29:=([Item:4]priceMSR:109-[Item:4]costMSC:110)*[Item:4]indicator2:96
		End if 
		
		[OrderLine:49]dateRequired:23:=$lastDate
		[OrderLine:49]description:5:=$lastInvoice+" BackLogOffset "+$lastCriteria
		[OrderLine:49]unitWt:20:=[Item:4]weightAverage:8
		[OrderLine:49]unitofMeasure:19:=[Item:4]unitOfMeasure:11
		
		[OrderLine:49]unitPrice:9:=-$backlog
		[OrderLine:49]qty:6:=1
		[OrderLine:49]qtyShipped:7:=1
		[OrderLine:49]extendedPrice:11:=-$backlog
		[OrderLine:49]qtyBackLogged:8:=0
		
		[OrderLine:49]unitCost:12:=[Item:4]costAverage:13
		[OrderLine:49]extendedCost:13:=[OrderLine:49]unitCost:12*[OrderLine:49]qty:6
		[OrderLine:49]qtyCancelled:51:=0
		[OrderLine:49]typeSale:28:=[Order:3]typeSale:22
		
		[OrderLine:49]unitofMeasure:19:="Com"
		
		SAVE RECORD:C53([OrderLine:49])
		
		
		
	: ($pathManage=1)  //from web
		
		
		
		
End case 