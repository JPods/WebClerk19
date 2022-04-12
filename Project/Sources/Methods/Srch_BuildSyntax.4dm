//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/24/10, 21:53:34
// ----------------------------------------------------
// Method: Srch_BuildSyntax
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20190405_1315 adjustment to operator =,#,<,>...

C_LONGINT:C283($i; $k; $w; $e; $r; $addQuote; $fieldNum)
$k:=Size of array:C274(aQueryFieldNames)
C_TEXT:C284($joinVar; $tableNamePlus; $srch)
C_BOOLEAN:C305($doTrue; $doUpdate)
C_TEXT:C284($myChar; $typeChar; $preWild)
C_TEXT:C284($theField)
KeyModifierCurrent
vText1:=""
<>quoteChar:=Char:C90(34)

C_TEXT:C284($vtdsQuery)
C_TEXT:C284($vtdsValues; $vtdsOperator)

// Modified by: Bill James (2017-09-03T00:00:00)
// changed to Table in the query listing and removal of tags

C_POINTER:C301($ptTable; $ptField; $ptTableNum; $ptFieldNum)
C_LONGINT:C283($tableNum; $fieldNum)
C_TEXT:C284($tableName; $firstTableNamePlus)

$srch:="Query"  // basic search
Case of 
	: (aTmp20Str3=2)  //override search
		$srch:="Query Selection"  // this changes the first command, wrappers are not needed
	: (aTmp20Str3>2)
		vText1:="Srch_SetBefore ("+<>quoteChar+aTmp20Str3{aTmp20Str3}+<>quoteChar+")"+"\r"  // build wrapper for sets
End case 
$finishLoop:=True:C214
For ($i; 1; $k)
	WccTableFieldStringtoPointers(aQueryFieldNames{$i}; ->$tableNum; ->$fieldNum)
	If ($tableNum=0)  // & ($fieldNum>0)))
		ALERT:C41("Error in assigning value "+aQueryFieldNames{1})
		$i:=$k
		$finishLoop:=False:C215
	Else 
		$myEquate:=""
		$endWild:=""
		$preWild:=""
		$ptTable:=Table:C252($tableNum)
		$tableName:=Table name:C256($tableNum)
		$tableNamePlus:="["+$tableName+"]"
		If ($fieldNum>0)
			$ptField:=Field:C253($tableNum; $fieldNum)
		End if 
		If ($finishLoop)
			If ($i=1)
				$firstTableNamePlus:="["+$tableName+"]"
			End if 
			$typeChar:=""
			$w:=Find in array:C230(aTmp20Str2; aQueryBooleans{$i})
			If (($w>0) & ($i>1))
				$joinVar:=("| ; "*Num:C11($w=1))+("& ; "*Num:C11($w=2))
			Else 
				$joinVar:=""
			End if 
			// $e:=Find in array(aTmp20Str4;aQueryOperators{$i})
			// If ($e>0)
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
			
			// $myEquate:=("="*Num($e=1))+("#"*Num($e=2))+(">"*Num($e=3))+(">="*Num($e=4))+("<"*Num($e=5))+("<="*Num($e=6))+("="*Num($e=7))+("#"*Num($e=8))+("%"*Num($e=9))
			
			// End if 
			If (False:C215)
				Case of 
					: (($e=7) | ($e=8))
						$preWild:="@"
						$endWild:="@"
					Else 
						$preWild:=""
						$endWild:=""
				End case 
			End if 
			C_POINTER:C301($ptField)
			// TagToComponents (aQueryFieldNames{$i})
			$searchThis:=aQueryValues{$i}
			
			$fieldType:=Type:C295($ptField->)
			Case of 
				: ($fieldType=Is boolean:K8:9)  // theTypes{$r}="B")
					//$doTrue:=((aQueryValues{$i}1="t")|(aQueryValues{$i}1="y")|(aQueryValues{$i}1="1"))
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
					// Modified by: Bill James (2017-09-28T00:00:00)
					// ### bj ### 20181219_1556
					// changed from
					// If ((OptKey=0) & ($myEquate#"#"))  //  
					//  $endWild:="@"
					// End if 
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
			vText1:=vText1+$srch+"("+$tableNamePlus+"; "+$joinVar+aQueryFieldNames{$i}+$myEquate+$typeChar+$preWild+$searchThis+$endWild+$typeChar+";*)"+"\r"
		End if 
	End if 
End for 
vText1:=vText1+$srch+"("+$firstTableNamePlus+")"
If (aTmp20Str3>2)
	vText1:=vText1+"\r"+"Srch_SetEnd ("+<>quoteChar+aTmp20Str3{aTmp20Str3}+<>quoteChar+")"+"\r"
End if 
voQuery:=QueryEd_ObjectBuild
vText2:=QueryEd_ObQuery
C_LONGINT:C283(eSrchPat)
If (($doUpdate) & (eSrchPat>0))
	//  --  CHOPPED  AL_UpdateArrays(eSrchPat; -2)
End if 