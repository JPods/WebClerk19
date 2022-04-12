//%attributes = {"publishedWeb":true}
//Method: Method: Cust_srAltSrchCustLoad
//Noah Dykoski   August 28, 1999 / 2:17 PM
C_POINTER:C301($1; $SrField)
$SrField:=$1
C_POINTER:C301($2; $SrVar)
$SrVar:=$2
C_BOOLEAN:C305($3; $PayByAmtAvail)
$PayByAmtAvail:=$3
C_LONGINT:C283($4; $PayAreaListID)
$PayAreaListID:=$4

C_TEXT:C284($srCustomer)
C_TEXT:C284($srAcct)
C_TEXT:C284($srPhone)
C_TEXT:C284($srZip)
C_TEXT:C284($srDiv)
$srCustomer:=srCustomer
$srPhone:=srPhone
$srZip:=srZip
$srAcct:=srAcct
$srDiv:=srDivision
$doPop:=False:C215

If (Records in selection:C76([Customer:2])=1)
	PUSH RECORD:C176([Customer:2])
	$doPop:=True:C214
End if 
jSrchCustLoad(->[Customer:2]; $SrField; $SrVar)  //use alt vare
If (Records in selection:C76([Customer:2])=1)
	sAltCo:=[Customer:2]company:2
	sAltPhone:=[Customer:2]phone:13
	//  Put  the formating in the form  jFormatPhone(->sAltPhone)
	sAltZip:=[Customer:2]zip:8
	sAltAcct:=[Customer:2]customerID:1
	sAltDivision:=String:C10(Cust_GetDivision)
	//  should we care -- //  CHOPPED DivD_SetFieldColor(->sAltDivision; Num(sAltDivision))
	//  should we care -- //  CHOPPED DivD_SetFieldColor(->sAltAcct; Num(sAltDivision))
	If ($PayByAmtAvail)
		QUERY:C277([Payment:28]; [Payment:28]customerID:4=sAltAcct)
	Else 
		QUERY:C277([Payment:28]; [Payment:28]customerID:4=sAltAcct; *)
		QUERY:C277([Payment:28];  & [Payment:28]amountAvailable:19#0)
	End if 
	//  //  CHOPPED FillPayArrays(Records in selection([Payment]); 0; 0; $PayAreaListID)
End if 
If ($doPop)
	POP RECORD:C177([Customer:2])
End if 
srCustomer:=$srCustomer
srPhone:=$srPhone
//  Put  the formating in the form  jFormatPhone(->srPhone)
srZip:=$srZip
srAcct:=$srAcct
srDivision:=$srDiv
