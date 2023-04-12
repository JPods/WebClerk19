//%attributes = {}

// Modified by: Bill James (2022-05-30T05:00:00Z)
// Method: action_setImage
// Description 

// replace these
// ID_GetPict
// imageGetPict

// Parameters
// ----------------------------------------------------

#DECLARE($path : Text)->$result : Picture
var $pathSystem : Text
var $viResult : Integer
var $file_o : Object
var $stillWorking : Boolean
$stillWorking:=True:C214
If ($path="")
	READ PICTURE FILE:C678(Storage:C1525.images.pathEmpty; $result)
Else 
	If ($path="http@")
		$pathSystem:=Txt_ClipFrom($path; "/catalog/")
		$pathSystem:=Storage:C1525.folder.catalog+Replace string:C233($pathSystem; "/"; Folder separator:K24:12)
		$file_o:=File:C1566($pathSystem; fk platform path:K87:2)
		If ($file_o.exists)
			$path:=""
			READ PICTURE FILE:C678($file_o.platformPath; $result)
			$stillWorking:=False:C215
		Else 
			var $answer : Object
			$status:=HTTP Get:C1157($path; $answer)
			If ($status=200)
				BLOB TO PICTURE:C682($answer; $result)
				$stillWorking:=False:C215
			End if 
		End if 
	End if 
	If ($stillWorking)
		$file_o:=File:C1566($path)
		If ($file_o.exists)
			READ PICTURE FILE:C678($file_o.platformPath; $result)
		Else 
			READ PICTURE FILE:C678(Storage:C1525.images.noImage; $result)
		End if 
	End if 
End if 
