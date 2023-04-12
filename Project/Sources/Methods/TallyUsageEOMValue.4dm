//%attributes = {}
If (Day of:C23(Current date:C33)=1)
	$PeriodDate:=Date_ThisMon(Current date:C33-10; 0)
	$PeriodStart:=DateTime_DTTo(Date_ThisMon($PeriodDate; 0); ?00:00:00?)
	$PeriodEnd:=DateTime_DTTo(Date_ThisMon($PeriodDate; 1)+1; ?23:59:50?)
	QUERY:C277([Item:4]; [Item:4]tallyByType:19=True:C214)
	$incItem:=0
	$cntItem:=Records in selection:C76([Item:4])
	If ($cntItem>0)
		//ORDER BY([Item];[Item]typeID)
		//FIRST RECORD([Item])
		DISTINCT VALUES:C339([Item:4]type:26; aText1)
		$cntRay:=Size of array:C274(aText1)
		For ($incRay; 1; $cntRay)
			QUERY:C277([Usage:5]; [Usage:5]itemNum:1=aText1{$incRay})
			If (Records in selection:C76([Usage:5])=0)
				CREATE RECORD:C68([Usage:5])
				[Usage:5]itemNum:1:=aText1{$incRay}
				[Usage:5]periodDate:2:=$PeriodDate
				
				[Usage:5]description:11:=aText1{$incRay}+" typeID"
				[Usage:5]typeID:33:=aText1{$incRay}
				[Usage:5]purpose:34:="Monthly"
				[Usage:5]dateEnd:35:=Date_ThisMon([Usage:5]periodDate:2; 1)
			End if 
		End for 
	End if 
End if 