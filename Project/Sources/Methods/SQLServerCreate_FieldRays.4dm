//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 04/25/02
	//Who: Dan Bentson, Arkware
	//Description: Writes field list for SQLServer create scrips
	// ### bj ### 20200321_1405
	// SQLServerCreate_FieldRays
End if 

C_LONGINT:C283($1; $2; $tableNum; $fieldNum)
$tableNum:=$1
$fieldNum:=$2
C_LONGINT:C283($x; $len)
C_TEXT:C284($curFieldName)
C_BOOLEAN:C305($indexed; $unique; $addField)
$addField:=True:C214

$curFieldName:=Field name:C257($tableNum; $fieldNum)

$curFieldName:=Replace string:C233(Field name:C257($tableNum; $fieldNum); " "; "")

//GET FIELD PROPERTIES(Field($tableNum;$fieldNum);$x;$len;$indexed;$unique)
//// get the field attributes    
GET FIELD PROPERTIES:C258(Field:C253($tableNum; $fieldNum); $x; $len; $indexed)  // get the field attributes      

C_LONGINT:C283($fia; $fiaTbl)
$fia:=Find in array:C230(oaKeysName; $curFieldName)
If ($fia>-1)
	// found this field in key listing...  
	
	// check if field is primary (or foreign)
	If (oaKeysPrimaryTable{$fia}=Table name:C256($tableNum))
		//is primary
		
		//if type is varchar  
		If ($x=Is alpha field:K8:1)  // CHANGE TO CODE AND MAKE NEW KEY
			// rename key from ID to Code
			C_LONGINT:C283($pos)
			$pos:=Position:C15("ID"; $curFieldName)
			If ($pos>0)
				oPriKey:=$curFieldName
				$curFieldName:=Substring:C12($curFieldName; 1; $pos-1)+"Code"
				$unique:=False:C215  // no longer should be unique
				// Else 
				//$curFieldName:=$curFieldName+"ID"
			Else 
				oPriKey:=$curFieldName+"ID"
			End if 
			
		Else   // REPLACE INTEGER PRI KEY WITH BIGINT
			If (($x=Is integer:K8:5) | ($x=Is longint:K8:6))
				$x:=-99
				oPriKey:=oaKeysName{$fia}
				$addField:=False:C215
			End if 
		End if 
	Else 
		If ($x#Is alpha field:K8:1)
			// is foreign
			$x:=-99
			//need to add to foreign key listing
			INSERT IN ARRAY:C227(oaForeignTable; 1)
			oaForeignTable{1}:=Table name:C256($tableNum)
			INSERT IN ARRAY:C227(oaForeignField; 1)
			oaForeignField{1}:=Replace string:C233($curFieldName; " "; "")
			INSERT IN ARRAY:C227(oaForeignRef; 1)
			oaForeignRef{1}:=oaKeysPrimaryTable{$fia}
		Else 
			// is varchar & foreign - should use new ID field??      
		End if 
	End if 
Else   // REPLACE IF NAMED UNIQUEID          
	If ($curFieldName="idNum")
		$curFieldName:=Table name:C256($tableNum)+"ID"
		$x:=-99
		oPriKey:=$curFieldName
		$addField:=False:C215
	End if 
End if 

If ($addField)
	C_LONGINT:C283($endElem)
	$endElem:=Size of array:C274(oaFieldList)+1
	INSERT IN ARRAY:C227(oaFieldTypes; $endElem)
	oaFieldTypes{$endElem}:=$x
	INSERT IN ARRAY:C227(oaFieldList; $endElem)
	oaFieldList{$endElem}:=$curFieldName
	INSERT IN ARRAY:C227(oaFieldLen; $endElem)
	oaFieldLen{$endElem}:=$len
	
	If (Not:C34(($x=Is subtable:K8:11) | ($x=Is time:K8:8)))
		// set as index  
		If ($indexed)
			INSERT IN ARRAY:C227(oaIndexFields; 1)
			oaIndexFields{1}:=$curFieldName
		End if 
		If ($unique)
			INSERT IN ARRAY:C227(oaUniqueFields; 1)
			oaUniqueFields{1}:=$curFieldName
		End if 
	End if 
	
	
End if 

If ($x=Is subtable:K8:11)
	INSERT IN ARRAY:C227(oaSubtables; 1)
	oaSubtables{1}:=$curFieldName
End if 



