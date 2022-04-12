//%attributes = {"publishedWeb":true}

// MustFixQQQZZZ: Bill James (8/28/21)
// Use collections to dedup
If (False:C215)
	//Procedure: Dup_CombineCust
	C_TEXT:C284($thePhone; $theEmail; $firstName; $lastName; $comments)
	If (cmdkey=1)
		CONFIRM:C162("Combine "+("previous"*Num:C11(optKey=1))+("next"*Num:C11(optKey=0))+" into current.")
		If (OK=1)
			Dup_CustDetail(OptKey; 0; 0)
		End if 
	Else 
		BEEP:C151
	End if 
End if 