//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WOCalendarFillList
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_DATE:C307($1; $beginDate; $2; $endDate; clickDate)
If (Count parameters:C259=2)
	$beginDate:=$1
	$endDate:=$2
Else 
	$beginDate:=clickDate
	$endDate:=clickDate
End if 


C_LONGINT:C283($findEmployee)
If (eSerCal>0)
	C_LONGINT:C283($i; $k; $w)
	$k:=Records in selection:C76([WorkOrder:66])
	FIRST RECORD:C50([WorkOrder:66])
	ARRAY DATE:C224(aCalActDts; 0)
	ARRAY TEXT:C222(aCalActs; 0)
	ARRAY TEXT:C222(aFonts; 0)
	ARRAY TEXT:C222(aStyles; 0)
	ARRAY TEXT:C222(aColors; 0)
	ARRAY TEXT:C222(aSizes; 0)
	For ($i; 1; $k)
		$w:=Size of array:C274(aCalActDts)+1
		INSERT IN ARRAY:C227(aCalActDts; $w)
		INSERT IN ARRAY:C227(aCalActs; $w)
		INSERT IN ARRAY:C227(aFonts; $w)
		INSERT IN ARRAY:C227(aStyles; $w)
		INSERT IN ARRAY:C227(aColors; $w)
		INSERT IN ARRAY:C227(aSizes; $w)
		
		aCalActDts{$w}:=jDateTimeRDate([WorkOrder:66]dtAction:5)
		//QUERY([Order];[Order]OrderNum=[WorkOrder]SaleOrderNum)
		aCalActs{$w}:=String:C10([WorkOrder:66]durationPlanned:10)+","+Substring:C12([WorkOrder:66]activity:7; 1; 3)+","+Substring:C12([WorkOrder:66]actionBy:8; 1; 4)
		//$findEmployee:=Find in array(<>aNameID;[WorkOrder]ActionBy)
		aFonts{$w}:="Arial"
		aSizes{$w}:="9"
		aStyles{$w}:="Plain"
		//If ($findEmployee>0)
		//$colorNum:=<>aNameColorFG{$findEmployee}
		// ### bj ### 20201213_1225  QQQ???? Convert to storage object
		$findEmployee:=Find in array:C230(<>aNameID; [WorkOrder:66]actionBy:8)
		If (($findEmployee>0) & ($findEmployee<=Size of array:C274(<>aNameColorFG)))
			If ((<>aNameColorFG{$findEmployee}<17) & (<>aNameColorFG{$findEmployee}>1))  //do not allow white
				aColors{$w}:=<>aColorNames{(<>aNameColorFG{$findEmployee})}
			Else 
				aColors{$w}:="Black"
			End if 
		Else 
			aColors{$w}:="Black"
		End if 
		NEXT RECORD:C51([WorkOrder:66])
	End for 
	UNLOAD RECORD:C212([WorkOrder:66])
	$formEvent:=Form event code:C388
	//If ($formEvent=On Load)
	//CS_SetArray(eSerCal; "aCalActDts"; "aCalActs"; "aFonts"; "aSizes"; "aStyles"; "aColors")
	//CS_SetSelect (eSerCal;$beginDate;$endDate;1;aSerDtRay)
	//End if 
	//UNLOAD RECORD([Order])
	////  CHOPPED   Area_Refresh(eSerCal)
End if 