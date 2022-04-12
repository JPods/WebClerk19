//%attributes = {}
//Project Method: LBX_Rows_to_Collection
//Descripton: Converts data in a listbox to a collection of values per row. (Listbox-CurrentData to Collection of Collections)
//Listbox based on entity selection.
//$1: Object name of a listbox in current form
//$2: Entity selection shown in listbox

//4D-version: v17 R6
//In this method, this is the key-commands in 4D:
//LISTBOX GET ARRAYS(;
//OBJECT Get title(;
//LISTBOX Get column formula(*;
//Formula from string

//In a listbox based on entity selection all formulas contains “This.” to get the current value.
//If the formula works in the listbox then it should work here as well. (This.myRelationNameToOne.fieldName)

//Example:
//Could be used in a button next to a listbox.
//$Result_o:=LSTBX_Rows_to_Collection(“Object_Name_My_Listbox”;Form.My_Listbox_es)
//$Result_o.dataCollection=[“HeaderTitle1”,“HeaderTitle2”,“HeaderTitle3”,“HeaderTitle4”],[“ValueR1C1”,“ValueR1C2”,ValueR1C3,“ValueR1C4”],[“ValueR2C1”,“ValueR2C2”,ValueR2C3,“ValueR2C4”],[“ValueR3C1”,“ValueR3C2”,ValueR3C3,“ValueR3C4”]
//This collection could be used directly with:
//VP SET VALUES (VP Cell (“MyViewProArea”;0;0);$Result_o.dataCollection)
//or convert it to any format you like. (See demo-example in code)

C_TEXT:C284($1; $ListboxName)
C_OBJECT:C1216($2; $Listbox_es)
C_OBJECT:C1216($0; $Result_o)

$ListboxName:=$1
$Listbox_es:=$2

$Result_o:=New object:C1471
$Result_o.dataCollection:=New collection:C1472  //Only to remember to always return a collection

If (OBJECT Get type:C1300(*; $ListboxName)=Object type listbox:K79:8)
	ARRAY TEXT:C222($colNames_at; 0)
	ARRAY TEXT:C222($headerNames_at; 0)
	ARRAY POINTER:C280($colVars_ap; 0)
	ARRAY POINTER:C280($headerVars_ap; 0)
	ARRAY BOOLEAN:C223($colsVisible_ab; 0)
	ARRAY POINTER:C280($styles_ap; 0)
	ARRAY TEXT:C222($colHeaderTitle_at; 0)
	ARRAY TEXT:C222($colFormula_at; 0)
	C_LONGINT:C283($i)
	
	LISTBOX GET ARRAYS:C832(*; $ListboxName; $colNames_at; $headerNames_at; $colVars_ap; $headerVars_ap; $colsVisible_ab; $styles_ap)
	ARRAY TEXT:C222($colHeaderTitle_at; Size of array:C274($colNames_at))
	ARRAY TEXT:C222($colFormula_at; Size of array:C274($colNames_at))
	For ($i; 1; Size of array:C274($colNames_at))
		$colHeaderTitle_at{$i}:=OBJECT Get title:C1068(*; $headerNames_at{$i})
		$colFormula_at{$i}:=LISTBOX Get column formula:C1202(*; $colNames_at{$i})
	End for 
	
	C_TEXT:C284($Column_Value_t)
	C_COLLECTION:C1488($Column_Values_c)
	C_OBJECT:C1216($Column_Formula_o)
	C_COLLECTION:C1488($Column_Formula_c)
	C_COLLECTION:C1488($ListBox_Values_c)
	
	$Column_Value_t:=""
	$Column_Values_c:=New collection:C1472
	$Column_Formula_o:=New object:C1471
	$Column_Formula_c:=New collection:C1472
	$ListBox_Values_c:=New collection:C1472
	
	//Select columns and add column titles
	For ($i; 1; Size of array:C274($colFormula_at))
		If ($colsVisible_ab{$i})
			$Column_Formula_o:=Formula from string:C1601($colFormula_at{$i})
			$Column_Formula_c.push($Column_Formula_o)
			$Column_Values_c.push($colHeaderTitle_at{$i})
		End if 
	End for 
	$ListBox_Values_c.push($Column_Values_c)  //First collection is column title
	
	
	//Main loop to get values into a collection of collections
	C_OBJECT:C1216($Listbox_o)
	For each ($Listbox_o; $Listbox_es)
		$Column_Values_c:=New collection:C1472
		For each ($Column_Formula_o; $Column_Formula_c)
			$Column_Values_c.push($Column_Formula_o.call($Listbox_o))
		End for each 
		$ListBox_Values_c.push($Column_Values_c)
	End for each 
	
	$Result_o.dataCollection:=$ListBox_Values_c
	
	//Demo-example:
	If (True:C214)  //Only for demo. Change to False after you have tested the code.
		If (Shift down:C543)
			C_TEXT:C284($JSON_t)
			$JSON_t:=JSON Stringify:C1217($ListBox_Values_c)
			SET TEXT TO PASTEBOARD:C523($JSON_t)
			INVOKE ACTION:C1439(ak show clipboard:K76:58)
		Else   //Convert to tab-separated text
			C_COLLECTION:C1488($ListBoxRow_c)
			C_TEXT:C284($Row_t)
			C_TEXT:C284($ListBox_Export_t)
			$ListBox_Export_t:=""
			
			$ListBox_Export_c:=New collection:C1472
			For each ($ListBoxRow_c; $ListBox_Values_c)
				For ($i; 0; ($ListBoxRow_c.length-1))
					$ListBox_Export_c.push($ListBoxRow_c[$i])
					If ($i<($ListBoxRow_c.length-1))
						$ListBox_Export_c.push("\t")
					End if 
				End for 
			End for each 
			var $data_t : Text
			$data_t:=$ListBox_Export_c.join("\r")
			$data_t:=Replace string:C233($data_t; "\r\t\r"; "\t")
			SET TEXT TO PASTEBOARD:C523($data_t)
			INVOKE ACTION:C1439(ak show clipboard:K76:58)
		End if 
	End if 
	
	If (False:C215)  // The above is very clean and manages types automatically
		For each ($ListBoxRow_c; $ListBox_Values_c)
			$Row_t:=""
			For ($i; 0; ($ListBoxRow_c.length-1))
				If (Value type:C1509($ListBoxRow_c[$i])=Is text:K8:3)
					$Row_t:=$Row_t+$ListBoxRow_c[$i]
				Else 
					$Row_t:=$Row_t+String:C10($ListBoxRow_c[$i])
				End if 
				If ($i<($ListBoxRow_c.length-1))
					$Row_t:=$Row_t+"\t"
				End if 
			End for 
			$ListBox_Export_t:=$ListBox_Export_t+$Row_t+"\r"
		End for each 
		SET TEXT TO PASTEBOARD:C523($ListBox_Export_t)
		INVOKE ACTION:C1439(ak show clipboard:K76:58)
	End if 
	
	
	
End if 

$0:=$Result_o





// <code 4D>

// </code 4D>