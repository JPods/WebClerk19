//%attributes = {"publishedWeb":true}
//Method: EDI_OrdLnDupCheck
C_BOOLEAN:C305($0)  //True if there is a duplicate of the item for the customerID
C_TEXT:C284($1; $customerID)
$customerID:=$1
C_TEXT:C284($2; $ItemNum)
$ItemNum:=$2

QUERY:C277([OrderLine:49]; [OrderLine:49]customerid:2=$customerID; *)
QUERY:C277([OrderLine:49];  & ; [OrderLine:49]itemNum:4=$ItemNum)
If (Records in selection:C76([OrderLine:49])>0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 