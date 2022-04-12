//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-24T00:00:00, 15:48:01
// ----------------------------------------------------
// Method: Srch_QueryByFormulaBuild
// Description
// Modified: 08/24/17
// 
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

// Modified by: Bill James (2017-09-03T00:00:00)
// changed to Table in the query listing and removal of tags

C_POINTER:C301($ptTable; $ptField; $ptTableNum; $ptFieldNum)
C_LONGINT:C283($tableNum; $fieldNum)
C_TEXT:C284($tableName; $firstTableNamePlus)

$srch:="Query By Formula"  // basic search
Case of 
	: (aTmp20Str3=2)  //override search
		$srch:="Query Selection By Formula"  // this changes the first command, wrappers are not needed
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
		$ptTable:=Table:C252($tableNum)
		$tableName:=Table name:C256($tableNum)
		$tableNamePlus:="["+$tableName+"]"
		If ($fieldNum>0)
			$ptField:=Field:C253($tableNum; $fieldNum)
		End if 
		If ($finishLoop)
			$w:=Find in array:C230(aTmp20Str2; aQueryBooleans{$i})
			If (($w>0) & ($i>1))
				$joinVar:=(" | "*Num:C11($w=1))+(" & "*Num:C11($w=2))
			Else 
				$joinVar:=""
			End if 
			If ($i=1)
				$tableNamePlus:="["+$tableName+"]"
				vText1:=$srch+"("+$tableNamePlus+" ; "  // ### jwm ### 20171108_1835 changed $tableName to $tableNamePlus
			Else 
				vText1:=vText1+$joinVar
			End if 
			If ($i=1)
				$firstTableNamePlus:="["+$tableName+"]"
			End if 
			$typeChar:=""
			
			$e:=Find in array:C230(aTmp20Str4; aQueryOperators{$i})
			//If ($e>0)
			//$myEquate:=("="*Num($e=1))+("#"*Num($e=2))+(">"*Num($e=3))+(">="*Num($e=4))+("<"*Num($e=5))+("<="*Num($e=6))+("="*Num($e=7))+("#"*Num($e=8))+("%"*Num($e=9))
			//End if 
			// ### jwm ### 20190405_1253
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
			// TagToComponents (aQueryFieldNames{$i})
			$searchThis:=aQueryValues{$i}
			
			$fieldType:=Type:C295($ptField->)
			Case of 
				: ($fieldType=Is boolean:K8:9)  // theTypes{$r}="B")
					//$doTrue:=((aQueryValues{$i}1="t")|(aQueryValues{$i}1="y")|(aQueryValues{$i}1="1"))
					$doTrue:=((aQueryValues{$i}="t@") | (aQueryValues{$i}="y@") | (aQueryValues{$i}="1@"))  //###_jwm_### 20100308 empty or ""
					aQueryValues{$i}:=("true"*Num:C11($doTrue))+("false"*Num:C11(Not:C34($doTrue)))
					$searchThis:=aQueryValues{$i}
					$doUpdate:=True:C214
					//: (aQueryValues{$i}1="=")
				: (aQueryValues{$i}="=@")  //###_jwm_### 20100308
					$searchThis:=Substring:C12(aQueryValues{$i}; 2; Length:C16(aQueryValues{$i}))
				: ((aQueryValues{$i}="") & ($fieldType=Is date:K8:7))
					$searchThis:="00/00/00"
				: ((aQueryValues{$i}="") & ($fieldType=Is time:K8:8))
					$searchThis:="00:00:00"
				: (($fieldType=Is alpha field:K8:1) | ($fieldType=Is text:K8:3))
					If (aQueryValues{$i}#"")
						If (aQueryValues{$i}[[1]]="[")
							$typeChar:=""
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
			vText1:=vText1+"("+aQueryFieldNames{$i}+$myEquate+$typeChar+$preWild+$searchThis+$endWild+$typeChar+")"
		End if 
	End if 
End for 
vText1:=vText1+")"
If (aTmp20Str3>2)
	vText1:=vText1+"\r"+"Srch_SetEnd ("+<>quoteChar+aTmp20Str3{aTmp20Str3}+<>quoteChar+")"+"\r"
End if 
C_LONGINT:C283(eSrchPat)
If (($doUpdate) & (eSrchPat>0))
	//  --  CHOPPED  AL_UpdateArrays(eSrchPat; -2)
End if 


If (False:C215)
	
	
	
	C_LONGINT:C283($i; $k; $w; $e; $r; $addQuote; $fieldNum)
	$k:=Size of array:C274(aQueryFieldNames)
	C_TEXT:C284($joinVar; $tableNamePlus; $srch)
	C_BOOLEAN:C305($doTrue; $doUpdate)
	C_TEXT:C284($myChar; $typeChar; $preWild)
	C_TEXT:C284($theField)
	KeyModifierCurrent
	vText1:=""
	<>quoteChar:=Char:C90(34)
	
	$srch:="Query By Formula"  // basic search
	Case of 
		: (aTmp20Str3=2)  //override search
			$srch:="Query Selection By Formula"  // this changes the first command, wrappers are not needed
		: (aTmp20Str3>2)
			vText1:="Srch_SetBefore ("+<>quoteChar+aTmp20Str3{aTmp20Str3}+<>quoteChar+")"+"\r"  // build wrapper for sets
	End case 
	For ($i; 1; $k)
		$w:=Find in array:C230(aTmp20Str2; aQueryBooleans{$i})
		If (($w>0) & ($i>1))
			$joinVar:=(" | "*Num:C11($w=1))+(" & "*Num:C11($w=2))
		Else 
			$joinVar:=""
		End if 
		
		// Modified by: Bill James (2016-04-22T00:00:00 keyword search
		
		$e:=Find in array:C230(aTmp20Str4; aQueryOperators{$i})
		If ($e>0)
			$myEquate:=("="*Num:C11($e=1))+("#"*Num:C11($e=2))+(">"*Num:C11($e=3))+(">="*Num:C11($e=4))+("<"*Num:C11($e=5))+("<="*Num:C11($e=6))+("="*Num:C11($e=7))+("#"*Num:C11($e=8))+("%"*Num:C11($e=9))
		End if 
		$preWild:=""
		$endWild:=""
		C_POINTER:C301($ptField)
		
		If (viWebTagFieldNum<1)
			$searchThis:="Nil pointer to field)"
		Else 
			If ($i=1)
				$tableNamePlus:="["+vWebTagTable+"]"
				vText1:=$srch+"("+$tableNamePlus+" ; "+$joinVar
			Else 
				vText1:=vText1+$joinVar
			End if 
			$fieldType:=Type:C295(ptWebTag->)
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
				: ((aQueryValues{$i}="") & ($fieldType=Is date:K8:7))
					$searchThis:="00/00/00"
				: ((aQueryValues{$i}="") & ($fieldType=Is time:K8:8))
					$searchThis:="00:00:00"
				: (($fieldType=Is alpha field:K8:1) | ($fieldType=Is text:K8:3))
					If (OptKey=0)  //  
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
			vText1:=vText1+"("+aQueryFieldNames{$i}+$myEquate+$typeChar+$preWild+$searchThis+$endWild+$typeChar+")"
		End if 
	End for 
	vText1:=vText1+")"
	If (aTmp20Str3>2)
		vText1:=vText1+"\r"+"Srch_SetEnd ("+<>quoteChar+aTmp20Str3{aTmp20Str3}+<>quoteChar+")"+"\r"
	End if 
	C_LONGINT:C283(eSrchPat)
	If (($doUpdate) & (eSrchPat>0))
		//  --  CHOPPED  AL_UpdateArrays(eSrchPat; -2)
	End if 
End if 