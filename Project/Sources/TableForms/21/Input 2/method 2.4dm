
// ### jwm ### 20181214_1543 check this or restore old procedure
// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[BOM:21])
$doMore:=False:C215

Case of 
	: (Form event code:C388=On Close Box:K2:21)
		
		jCancelButton
		
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		[BOM:21]itemNum:1:=[Item:4]itemNum:1
		OBJECT SET ENTERABLE:C238([BOM:21]childItem:2; True:C214)
		v1:=[Item:4]description:7
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
	
	
	If ([BOM:21]itemNum:1=[Item:4]itemNum:1)
		ONE RECORD SELECT:C189([Item:4])
		v1:=[Item:4]description:7
		PUSH RECORD:C176([Item:4])
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]childItem:2)
		[BOM:21]planCost:8:=[Item:4]costAverage:13
		v2:=[Item:4]unitOfMeasure:11
		vi1:=[Item:4]location:9
		vr1:=[Item:4]leadTimeSales:12
		vr2:=[Item:4]qtySaleDefault:15
		vr3:=[Item:4]qtyOnHand:14
		vr4:=[Item:4]qtyOnSalesOrder:16
		vr5:=[Item:4]qtyOnPo:20
		vr6:=[Item:4]weightAverage:8
		vr7:=[Item:4]costAverage:13
		// ### bj ### 20190222_0729
		// correct for empty string
		$unitMeasBy:=1
		If (v2#"")
			If (v2[[1]]="*")
				//Jan 11, 1997
				C_REAL:C285($unitMeasBy)
				$unitMeasBy:=Item_PricePer(->v2)
			End if 
		End if 
		[BOM:21]planExtCost:9:=[Item:4]costAverage:13*[BOM:21]qtyInAssembly:3/$unitMeasBy
		// UNLOAD RECORD([Item])
		POP RECORD:C177([Item:4])
	Else 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]itemNum:1)
		v1:=[Item:4]description:7
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]childItem:2)
		v2:=[Item:4]unitOfMeasure:11
		vi1:=[Item:4]location:9
		vr1:=[Item:4]leadTimeSales:12
		vr2:=[Item:4]qtySaleDefault:15
		vr3:=[Item:4]qtyOnHand:14
		vr4:=[Item:4]qtyOnSalesOrder:16
		vr5:=[Item:4]qtyOnPo:20
		vr6:=[Item:4]weightAverage:8
		vr7:=[Item:4]costAverage:13
		UNLOAD RECORD:C212([Item:4])
	End if 
	
	$doChange:=UserInPassWordGroup("EditBOM")
	OBJECT SET ENTERABLE:C238([BOM:21]qtyInAssembly:3; $doChange)
	OBJECT SET ENTERABLE:C238([BOM:21]planCost:8; $doChange)
	OBJECT SET ENTERABLE:C238([BOM:21]planExtCost:9; $doChange)
	
End if 

booAccept:=(([BOM:21]itemNum:1#"") & ([BOM:21]childItem:2#""))


