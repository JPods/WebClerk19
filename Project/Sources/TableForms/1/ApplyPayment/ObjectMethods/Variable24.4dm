If (Size of array:C274(aInvSelRec)>1)
	myCycle:=22  // coming from applypay window so use the total selected
	UNLOAD RECORD:C212([Invoice:26])
Else 
	If (Record number:C243([Invoice:26])<0)
		If (Size of array:C274(aInvSelRec)>1)
			If (Size of array:C274(aInvRecs)>=aInvSelRec{1})
				GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvSelRec{1}})
			End if 
		End if 
	End if 
End if 
PaymentCreate(->[Payment:28])
//SEARCH([Payment];[Payment]CustomerKey=[Customer]AccountCode;*)
//SEARCH([Payment];&[Payment]AmountAvailable#0)
////  //  CHOPPED FillPayArrays //
doSearch:=22
myCycle:=0  // 
vi:=""
v2:=""
v3:=""
v4:=""

