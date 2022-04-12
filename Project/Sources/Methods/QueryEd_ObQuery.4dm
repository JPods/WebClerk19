//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/03/21, 00:42:42
// ----------------------------------------------------
// Method: QueryEd_ObQuery
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($vtWorking)
C_TEXT:C284($vtValues; $vtOperator)

C_LONGINT:C283($incRay; $cntRay)
$k:=Size of array:C274(aQueryBooleans)
$vtWorking:="ds."+Table name:C256(curTableNum)+".query(\""
$ptTable:=Table:C252(curTableNum)
$tableNum:=curTableNum
For ($i; 1; $k)
	WccTableFieldStringtoPointers(aQueryFieldNames{$i}; ->$tableNum; ->$fieldNum)
	
	$myEquate:=""
	$endWild:=""
	$preWild:=""
	
	If ($fieldNum>0)
		$ptField:=Field:C253($tableNum; $fieldNum)
		$vtFieldName:=Field name:C257($ptField)
	Else 
		$vtFieldName:="NoFieldName"
	End if 
	
	$typeChar:=""
	$w:=Find in array:C230(aTmp20Str2; aQueryBooleans{$i})
	If (($w>0) & ($i>1))
		$joinVar:=(" OR  "*Num:C11($w=1))+(" AND "*Num:C11($w=2))
	Else 
		$joinVar:=""
	End if 
	$preWild:=""
	$endWild:=""
	Case of 
		: ((aQueryOperators{$i}="begins with") | (aQueryOperators{$i}="beginswith"))  // spaces removed to support web parameters
			$myEquate:="="
			$endWild:="@"
		: ((aQueryOperators{$i}="ends with") | (aQueryOperators{$i}="endswith"))
			$myEquate:="="
			$preWild:="@"
		: (aQueryOperators{$i}="equals")
			$myEquate:="="
		: ((aQueryOperators{$i}="not equals") | (aQueryOperators{$i}="notequals"))
			$myEquate:="#"
		: ((aQueryOperators{$i}="greater than") | (aQueryOperators{$i}="greaterthan"))
			$myEquate:=">"
		: ((aQueryOperators{$i}="greater or equal") | (aQueryOperators{$i}="greaterorequal"))
			$myEquate:=">="
		: ((aQueryOperators{$i}="less than") | (aQueryOperators{$i}="lessthan"))
			$myEquate:="<"
		: ((aQueryOperators{$i}="less than or equal") | (aQueryOperators{$i}="lessthanorequal"))
			$myEquate:="<="
		: (aQueryOperators{$i}="contains")
			$myEquate:="="
			$preWild:="@"
			$endWild:="@"
		: ((aQueryOperators{$i}="not contains") | (aQueryOperators{$i}="notcontains"))
			$myEquate:="#"
			$preWild:="@"
			$endWild:="@"
		: (aQueryOperators{$i}="keyword")
			$myEquate:="%"
	End case 
	
	
	C_POINTER:C301($ptField)
	
	$searchThis:=aQueryValues{$i}
	
	$fieldType:=Type:C295($ptField->)
	Case of 
		: ($fieldType=Is boolean:K8:9)  // theTypes{$r}="B")
			$doTrue:=((aQueryValues{$i}="t@") | (aQueryValues{$i}="y@") | (aQueryValues{$i}="1@"))  //###_jwm_### 20100308
			aQueryValues{$i}:=("true"*Num:C11($doTrue))+("false"*Num:C11(Not:C34($doTrue)))
			$searchThis:=aQueryValues{$i}
			$doUpdate:=True:C214
			//: (aQueryValues{$i}1="=")
		: (aQueryValues{$i}="=@")  //###_jwm_### 20100308
			$searchThis:=Substring:C12(aQueryValues{$i}; 2; Length:C16(aQueryValues{$i}))
		: ($fieldType=Is date:K8:7)  // Modified by: Bill James (2017-09-28T00:00:00)
			If (aQueryValues{$i}="")
				$searchThis:="!00/00/00!"
			Else 
				If ((aQueryValues{$i}#"@date@") & (aQueryValues{$i}#"v@") & (aQueryValues{$i}#"@[@"))  // ### jwm ### 20171219_1151
					$searchThis:="!"+aQueryValues{$i}+"!"
				End if 
			End if 
		: ($fieldType=Is time:K8:8)  // Modified by: Bill James (2017-09-28T00:00:00)
			If (aQueryValues{$i}="")
				$searchThis:="?00:00:00?"
			Else 
				If ((aQueryValues{$i}#"@time@") & (aQueryValues{$i}#"v@") & (aQueryValues{$i}#"@[@"))  // ### jwm ### 20171219_1152
					$searchThis:="?"+aQueryValues{$i}+"?"
				End if 
			End if 
		: (($fieldType=Is alpha field:K8:1) | ($fieldType=Is text:K8:3))
			If (OptKey=1)  // added
				$endWild:="@"
			End if 
			If (aQueryValues{$i}#"")
				If (aQueryValues{$i}[[1]]="[")
					$typeChar:=""
					$endWild:="@"
				Else 
					$typeChar:=<>quoteChar
				End if 
			Else 
				$typeChar:=<>quoteChar
			End if 
		: ((aQueryValues{$i}="") & (($fieldType=Is longint:K8:6) | ($fieldType=Is real:K8:4)))
			$searchThis:="0"
		Else 
			//If (aQueryValues{$i}="")
			//aQueryValues{$i}:=Char(34)+Char(34)
			//End if 
			$searchThis:=aQueryValues{$i}
	End case 
	//vText1:=vText1+$srch+"("+$tableNamePlus+"; "+$joinVar+aQueryFieldNames{$i}+$myEquate+$typeChar+$preWild+$searchThis+$endWild+$typeChar+";*)"+"\r"
	$vtValues:=$vtValues+"; \""+$preWild+$searchThis+$endWild+"\""
	
	$vtWorking:=$vtWorking+$joinVar+" "+$vtFieldName+" "+$myEquate+" :"+String:C10($i)+" "
	
End for 
$vtWorking:=$vtWorking+" \""+$vtValues+")"

$0:=$vtWorking
