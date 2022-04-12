//%attributes = {}
If (False:C215)
	//WccItemSalesByZip
	Version_0508
	
End if 
C_LONGINT:C283($1; $mfrLocationID)
C_POINTER:C301($2)
C_TEXT:C284($3; $mfrAccount)
If (Count parameters:C259=3)
	$mfrAccount:=$3
	QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerid:1=$mfrAccount; *)
	QUERY:C277([ManufacturerTerm:111];  & [ManufacturerTerm:111]active:3=True:C214)
	If ((Records in selection:C76([ManufacturerTerm:111])=1) & ([ManufacturerTerm:111]locationid:2<-10000))
		$mfrLocationID:=[ManufacturerTerm:111]locationid:2
	End if 
End if 
$dateBeg:=Date:C102(WCapi_GetParameter("DateBegin"; ""))
$dateEnd:=Date:C102(WCapi_GetParameter("DateEnd"; ""))
$zipBegin:=WCapi_GetParameter("ZipBegin"; "")
$zipEnd:=WCapi_GetParameter("ZipEnd"; "")
$itemNum:=WCapi_GetParameter("ItemNum"; "")
QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=$itemNum; *)
If ($mfrLocationID<-10000)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]location:22=$mfrLocationID; *)
End if 
QUERY:C277([OrderLine:49])
RELATE ONE SELECTION:C349([OrderLine:49]; [Customer:2])
Srch_SetBefore("Search Selection")
QUERY SELECTION:C341([Customer:2]; [Customer:2]zip:8>=$zipBegin; *)
QUERY SELECTION:C341([Customer:2];  & [Customer:2]zip:8<=$zipEnd; *)
QUERY SELECTION:C341([Customer:2])
Srch_SetEnd("Search Selection")
//