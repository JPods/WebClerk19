KeyModifierCurrent
process_o.entry_o.actionBy:=DE_PopUpArray(Self:C308)
If (optKey=0)
	//If ([Order]ProducedBy#Old([Order]ProducedBy))
	//$tempStr:="Order Assigned to "+[Order]ProducedBy+"."
	//// zzzqqq jDateTimeStamp (->[Order]CommentProcess;$tempStr)
	//releaseTime:=Current time
	//releaseDate:=Current date
	//[Order]DTProdRelease:=DateTime_DTTo 
	//d03Release:=Date_strYrMmDd (releaseDate;0)
	//End if 
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]actionBy:55)
Else 
	C_LONGINT:C283($i; $k)
	CONFIRM:C162("Set Produced By in selected lines?")
	If (OK=1)
		$k:=Size of array:C274(aRayLines)
		For ($i; 1; $k)
			aoProdBy{aRayLines{$i}}:=[Order:3]actionBy:55
			If (aoLineAction{aRayLines{$i}}>-1)  // don't make this negative
				aoLineAction{$1}:=-3000
			End if 
		End for 
	End if 
End if 