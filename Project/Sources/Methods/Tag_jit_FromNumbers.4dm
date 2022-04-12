//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-08-18T00:00:00, 10:01:02
// ----------------------------------------------------
// Method: Tag_jit_FromNumbers
// Description
// Modified: 08/18/15
// Structure: CEv13_131005
// 
//  Also look at HTML_jitTagMake
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160509_1655 added End tag and $3 for format

C_TEXT:C284($0)
C_LONGINT:C283($1; $tableNum; $2; $fieldNum; $myOK)
C_TEXT:C284($3; $tagPurpose)
C_TEXT:C284($4; $format)
If (Count parameters:C259<2)
	$0:="noValues"
Else 
	$myOK:=0
	$tableNum:=$1
	$fieldNum:=$2
	$tagPurpose:="_jit_"
	$format:=""
	If (Count parameters:C259>2)
		$tagPurpose:=$3  //  "rjit_"
		If (Count parameters:C259>3)
			$format:=$4
		End if 
	End if 
	
	If (($tableNum>0) & ($tableNum<=Get last table number:C254))
		If (($fieldNum>0) & ($fieldNum<=Get last field number:C255($tableNum)))
			$myOK:=1
		End if 
	End if 
	If ($myOK=0)
		// bad numbers
	Else 
		C_LONGINT:C283($typeFld; $lenField; $numFld; $k; $w; $tableNum)
		C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
		GET FIELD PROPERTIES:C258($1; $2; $typeFld; $lenField; $indexed)  // file #, field #, type, length, index    
		Case of 
			: ($typeFld=Is picture:K8:10)
				$0:="Picture-nojitTag"
			: ($typeFld=Is BLOB:K8:12)  // no blobs or pictures
				$0:="Blob-nojitTag"
			Else 
				$0:=$tagPurpose+Table name:C256($1)+"_"+Field name:C257(Field:C253($1; $2))
				If (Length:C16($format)>0)
					// add formating tag
					$0:=$0+$format
				End if 
				$0:=$0+"jj"
		End case 
	End if 
End if 

