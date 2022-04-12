//%attributes = {"publishedWeb":true}




C_OBJECT:C1216($1; $obSetup)
C_TEXT:C284($0; $lbName)
C_TEXT:C284($vtFieldList; vtTableName)
//$lbName:="lbEmpty"
If (Count parameters:C259=1)
	$obSetup:=$1
Else 
	$obSetup:=New object:C1471
End if 
If ($obSetup#Null:C1517)
	Case of 
		: (($obSetup.priority="textBlock") | ($obSetup.priority="FieldCharacteristics"))
			vtTableName:=$obSetup.tableName
			$vtFieldList:=$obSetup.fieldList
			$lbName:=$obSetup.listboxName
		: ($obSetup.priority="Selection")
			If ($obSetup#Null:C1517)
				vtTableName:=$obSetup.tableName
				$vtFieldList:=$obSetup.fieldList
				$lbName:=$obSetup.listboxName
			End if 
			C_COLLECTION:C1488($cBuild; $cFilter)
			C_OBJECT:C1216($obField)
			$cBuild:=New collection:C1472
			For each ($obField; LB_Fields.sel)
				$cBuild.push($obField.fieldName)
			End for each 
			$vtFieldList:=$cBuild.join(",")
	End case 
Else 
	vtTableName:="Customer"
	$vtFieldList:="action,actionBy,actionDate,company,nameLast,nameFirst,id"
	$lbName:="lbEmpty"
End if 
$tableName:=vtTableName

//$vtFieldList:=LB_TextStringAddID($vtFieldList)

C_LONGINT:C283($viCnt; $viInc)
$viCnt:=LISTBOX Get number of columns:C831(*; $lbName)
If ($viCnt>0)
	LISTBOX DELETE COLUMN:C830(*; $lbName; 1; $viCnt)
End if 

C_COLLECTION:C1488($cFilter)
$cFilter:=New collection:C1472
$cFilter:=Split string:C1554($vtFieldList; ",")
// $cFilter:=$cFilter.distinct()   // this sorts to change order
ARRAY TEXT:C222($atFields; 0)
COLLECTION TO ARRAY:C1562($cFilter; $atFields)
C_TEXT:C284($vtFieldName)
C_LONGINT:C283($viCount)

C_POINTER:C301($ptHeaderVar)
C_POINTER:C301($NilPtr)
C_OBJECT:C1216($obDateStore)

$obDateStore:=ds:C1482[vtTableName]
ARRAY TEXT:C222($atFieldNames; 0)
ARRAY TEXT:C222($atUsedNames; 0)
STR_GetFieldNameList(vtTableName; ->$atFieldNames)
$vtFieldList:=""
For each ($vtFieldName; $cFilter)
	$w:=Find in array:C230($atFieldNames; $vtFieldName)
	If ($w>0)
		$vtFieldName:=$atFieldNames{$w}
		$w:=Find in array:C230($atUsedNames; $vtFieldName)
		If ($w<1)
			APPEND TO ARRAY:C911($atUsedNames; $vtFieldName)
			$vtFieldList:=$vtFieldList+$vtFieldName+","
			If (False:C215)
				$cFilter[$viCounter].push($vtFieldName)
				$cFilter[$viCounter]:=$vtFieldName
			End if 
			If ($vtFieldName#"id")
				$viCount:=$viCount+1
				$vtHeader:="Header_"+vtTableName+"_"+$vtFieldName
				$ptHeaderVar:=$NilPtr  // Get pointer($vtHeader)
				$vtColumnFormula:="This."+$vtFieldName
				$vtColumnName:="Column_"+$tableName+"_"+$vtFieldName
				LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName; $viCount; $vtColumnName; $vtColumnFormula; $obDateStore[$vtFieldName].fieldType; $vtHeader; $NilPtr)
				C_TEXT:C284($vtTitle)
				$vtTitle:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
				OBJECT SET TITLE:C194(*; $vtHeader; $vtTitle)
				
				// OBJECT SET FORMAT(*;“Spalte”+String(al_SpNr{$i});Char(Num(at_SpFormat{$i})))
				Case of 
					: ($obDateStore[$vtFieldName].type="date")
						LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 70)
						OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align center:K42:3)
						OBJECT SET FORMAT:C236(*; $vtColumnName; Char:C90(System date short:K1:1))  // 1
						
					: ($obDateStore[$vtFieldName].type="bool")
						LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 40)
						OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align center:K42:3)
					: ($obDateStore[$vtFieldName].type="number")
						
						Case of 
							: ($vtColumnName="@time@")
								LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 70)
								OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align center:K42:3)
								//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
							Else 
								LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 80)
								LISTBOX SET PROPERTY:C1440(*; $vtColumnName; lk display type:K53:46; lk numeric format:K53:55)
								OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align right:K42:4)
								OBJECT SET FORMAT:C236(*; $vtColumnName; "###,###,###,##0.00")
						End case 
						
						
						
					: ($obDateStore[$vtFieldName].type="string")
						Case of 
							: ($vtFieldName="@phone@")
								OBJECT SET FORMAT:C236(*; $vtColumnName; "### ### (###) ###-####")
								
								
							Else 
								
								
						End case 
						
				End case 
			End if 
		End if 
	End if 
End for each 
If (Length:C16($vtFieldList)>1)
	$vtFieldList:=Substring:C12($vtFieldList; 1; Length:C16($vtFieldList)-1)
End if 
$0:=$vtFieldList
$cFilter:=Split string:C1554($vtFieldList; ",")
Form:C1466.cSel:=ds:C1482[vtTableName].all().toCollection($cFilter)



