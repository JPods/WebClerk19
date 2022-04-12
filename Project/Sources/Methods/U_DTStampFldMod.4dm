//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen

// Modified by: Bill James (2022-01-14T06:00:00Z)
// Method: // zzzqqq U_DTStampFldMod
// Description
// Parameters
// ----------------------------------------------------
var $1; $CommentPtr : Pointer
$CommentPtr:=$1
var $2; $FieldPtr : Pointer
$FieldPtr:=$2
var $oldDate : Date

If (Storage:C1525.default.dtStampFldMods)  //
	var $commentName; $fieldName : Text
	$commentName:=Field name:C257($1)
	$fieldName:=Field name:C257($2)
	var $ModMessage : Text
	var $Type : Integer
	$Type:=Type:C295($FieldPtr->)
	Case of 
		: (($Type=0) | ($Type=2) | ($Type=24))  //string
			If (processs_o.currentRecord[$fieldName]="")
				$ModMessage:=$fieldName+" changed to "+entryEntity[$fieldName]
			Else 
				$ModMessage:=$fieldName+" changed to "+entryEntity[$fieldName]+" from "+processs_o.currentRecord[$fieldName]
			End if 
		: (($Type=1) | ($Type=8) | ($Type=9))  //number
			$ModMessage:=$fieldName+" changed to "+String:C10(entryEntity[$fieldName])+" from "+String:C10(processs_o.currentRecord[$fieldName])
		: ($Type=11)  //time
			$ModMessage:=$fieldName+" changed to "+String:C10(entryEntity[$fieldName]; 5)+" from "+String:C10(processs_o.currentRecord[$fieldName]; 5)
		: ($Type=4)  //date
			var $oldDate : Date
			$oldDate:=processs_o.currentRecord[$fieldName]
			If (($oldDate<(Current date:C33-370)) | ($oldDate>(Current date:C33+420)))  //###_jwm_### 20101111
				$oldDate:=!00-00-00!
			End if 
			$ModMessage:=$fieldName+" changed to "+String:C10(entryEntity[$fieldName]; 1)+" from "+String:C10($oldDate; 1)
		: ($Type=6)  //boolean
			var $old : Text
			If (processs_o.currentRecord[$fieldName])
				$old:="True"
			Else 
				$old:="False"
			End if 
			var $new : Text
			If (entryEntity[$fieldName])
				$new:="True"
			Else 
				$new:="False"
			End if 
			$ModMessage:=$fieldName+" changed to "+$new+" from "+$old
	End case 
	If (entryEntity#Null:C1517)
		$tempTxt:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "
		entryEntity[$commentName]:=$tempTxt+$ModMessage+"\r"+entryEntity[$commentName]
	Else 
		Case of 
			: (($Type=0) | ($Type=2) | ($Type=24))  //string
				Case of 
					: (Old:C35($FieldPtr->)="")
						$ModMessage:=$fieldName+" changed to "+$FieldPtr->
					: ($FieldPtr->="")
						$ModMessage:=$fieldName+" changed to "+Char:C90(34)+Char:C90(34)+" from "+Old:C35($FieldPtr->)
					Else 
						$ModMessage:=$fieldName+" changed to "+$FieldPtr->+" from "+Old:C35($FieldPtr->)
				End case 
			: (($Type=1) | ($Type=8) | ($Type=9))  //number
				$ModMessage:=$fieldName+" changed to "+String:C10($FieldPtr->)+" from "+String:C10(Old:C35($FieldPtr->))
			: ($Type=11)  //time
				$ModMessage:=$fieldName+" changed to "+String:C10($FieldPtr->; 5)+" from "+String:C10(Old:C35($FieldPtr->); 5)
			: ($Type=4)  //date
				var $oldDate : Date
				$oldDate:=Old:C35($FieldPtr->)
				If (($oldDate<(Current date:C33-370)) | ($oldDate>(Current date:C33+420)))  //###_jwm_### 20101111
					$oldDate:=!00-00-00!
				End if 
				$ModMessage:=$fieldName+" changed to "+String:C10($FieldPtr->; 1)+" from "+String:C10($oldDate; 1)
			: ($Type=6)  //boolean
				var $old : Text
				If (Old:C35($FieldPtr->))
					$old:="True"
				Else 
					$old:="False"
				End if 
				var $new : Text
				If ($FieldPtr->)
					$new:="True"
				Else 
					$new:="False"
				End if 
				$ModMessage:=$fieldName+" changed to "+$new+" from "+$old
		End case 
		If (Old:C35($FieldPtr->)#$FieldPtr->)
			// zzzqqq jDateTimeStamp($CommentPtr; $ModMessage)
			//If ((aLoOrdComme=1) & (($2=(->[Order]Status)) | ($2=(->[Order]ProducedBy))))
			// zzzqqq jDateTimeStamp(->vOrdComment; $ModMessage)
			//End if
		Else 
			If ((aLoOrdComme=1) & (($2=(->[Order:3]status:59)) | ($2=(->[Order:3]actionBy:55))))
				// zzzqqq jDateTimeStamp(->vOrdComment; $ModMessage)
				// zzzqqq jDateTimeStamp($CommentPtr; $ModMessage)
			End if 
		End if 
	End if 
End if 