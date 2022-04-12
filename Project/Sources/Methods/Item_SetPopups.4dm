//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/10/12, 20:20:04
// ----------------------------------------------------
// Method: Item_SetPopups
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($p; $doAlt)
C_TEXT:C284($myText; $testValue)
C_TEXT:C284($1)
$doAlt:=-1
If (Count parameters:C259=1)
	$myText:=$1
	If ($myText#"")
		$doAlt:=1
	End if 
Else 
	//TRACE
	$p:=Find in array:C230(<>aItemsType; [Item:4]type:26)
	// ### bj ### 20210428_0819
	// find a better way to manage alternate values
	// when populating <>aItemsType it is necessary to also populate <>aItemsTypeAlt
	// jsetChPopups has been replaced but not this special aspect of select lists
	//
	If (Size of array:C274(<>aItemsTypeAlt)=Size of array:C274(<>aItemsType))
		If ($p>0)
			If (<>aItemsTypeAlt{$p}#"")
				$doAlt:=1
				$myText:=<>aItemsTypeAlt{$p}
			End if 
		End if 
	End if 
	//If ($doAlt=-1)
	//$p:=Find in array(<>aItemsProfile1;[Item]Profile1)
	//If ($p>0)
	//If (<>aItemsProfile1Alt{$p}#"")
	//$doAlt:=2
	//$myText:=<>aItemsProfile1Alt{$p}
	//End if 
	//End if 
	//End if 
End if 
If ($doAlt<1)
	COPY ARRAY:C226(<>aItemsProfile1; aItemsProfile1)
	vItemsProfile1:=<>vItemsProfile1
	COPY ARRAY:C226(<>aItemsProfile2; aItemsProfile2)
	vItemsProfile2:=<>vItemsProfile2
	COPY ARRAY:C226(<>aItemsProfile3; aItemsProfile3)
	vItemsProfile3:=<>vItemsProfile3
	COPY ARRAY:C226(<>aItemsProfile4; aItemsProfile4)
	vItemsProfile4:=<>vItemsProfile4
	COPY ARRAY:C226(<>aItemsProfile5; aItemsProfile5)
	vItemsProfile5:=<>vItemsProfile5
	COPY ARRAY:C226(<>aItemsProfile6; aItemsProfile6)
	vItemsProfile6:=<>vItemsProfile6
Else 
	If ($doAlt=1)
		$p:=Position:C15(";"; $myText)
		If ($p>0)
			$testValue1:=Substring:C12($myText; 1; $p-1)
			$myText:=Substring:C12($myText; $p+1)
		Else 
			$testValue1:=$myText
			$myText:=""
		End if 
		Item_PopupValues($testValue1; ->vItemsProfile1; ->aItemsProfile1; -><>aItemsProfile1; -><>vItemsProfile1)
	End if 
	$testValue2:=""
	$testValue3:=""
	$testValue4:=""
	$p:=Position:C15(";"; $myText)
	If ($p>0)
		$testValue2:=Substring:C12($myText; 1; $p-1)
		$myText:=Substring:C12($myText; $p+1)
	Else 
		$testValue2:=$myText
		$myText:=""
	End if 
	Item_PopupValues($testValue2; ->vItemsProfile2; ->aItemsProfile2; -><>aItemsProfile2; -><>vItemsProfile2)
	$p:=Position:C15(";"; $myText)
	If ($p>0)
		$testValue3:=Substring:C12($myText; 1; $p-1)
		$myText:=Substring:C12($myText; $p+1)
	Else 
		$testValue3:=$myText
		$myText:=""
	End if 
	Item_PopupValues($testValue3; ->vItemsProfile3; ->aItemsProfile3; -><>aItemsProfile3; -><>vItemsProfile3)
	$p:=Position:C15(";"; $myText)
	If ($p>0)
		$testValue4:=Substring:C12($myText; $p+1)
	Else 
		$testValue4:=$myText
	End if 
	Item_PopupValues($testValue4; ->vItemsProfile4; ->aItemsProfile4; -><>aItemsProfile4; -><>vItemsProfile4)
	$p:=Position:C15(";"; $myText)
	If ($p>0)
		$testValue5:=Substring:C12($myText; 1; $p-1)
		$myText:=Substring:C12($myText; $p+1)
	Else 
		$testValue5:=$myText
		$myText:=""
	End if 
	Item_PopupValues($testValue5; ->vItemsProfile5; ->aItemsProfile5; -><>aItemsProfile5; -><>vItemsProfile5)
	$p:=Position:C15(";"; $myText)
	If ($p>0)
		$testValue6:=Substring:C12($myText; 1; $p-1)
		$myText:=Substring:C12($myText; $p+1)
	Else 
		$testValue6:=$myText
		$myText:=""
	End if 
	Item_PopupValues($testValue6; ->vItemsProfile6; ->aItemsProfile6; -><>aItemsProfile6; -><>vItemsProfile6)
End if 

LabelsFill(Table:C252(->[Item:4]); [Item:4]templateName:120)



