If (Size of array:C274(aPopSelect)>0)
	If (aText2{aPopSelect{1}}#"")
		$myText:=aText2{aPopSelect{1}}
		ONE RECORD SELECT:C189([PopUp:23])
		OBJECT SET ENABLED:C1123(bPrevious; False:C215)
		OBJECT SET ENABLED:C1123(bNext; False:C215)
		PUSH RECORD:C176([PopUp:23])
		Repeat 
			$p:=Position:C15(";"; $myText)
			If ($p>0)
				$testValue2:=Substring:C12($myText; 1; $p-1)
				$myText:=Substring:C12($myText; $p+1)
			Else 
				$testValue2:=$myText
				$myText:=""
			End if 
			QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3=$testValue2)
			DB_ShowCurrentSelection(->[PopUp:23]; ""; 1; "")
		Until ($myText="")
		POP RECORD:C177([PopUp:23])
	End if 
End if 