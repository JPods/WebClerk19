//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: _InputFormDeleteReplace
// Description 
// Parameters
// ----------------------------------------------------

//If (False)

Case of 
	: (Count parameters:C259=0)
		TRACE:C157
		var $pathSource; $pathDestination; $suffix : Text
		
		$pathDestination:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/TableForms/"
		$pathDestination:=Convert path POSIX to system:C1107($pathDestination)
		$pathSource:="/Users/williamjames/Documents/CommerceExpert/_testing/TableForms/"
		$pathSource:=Convert path POSIX to system:C1107($pathSource)
		var $key_t; $path; $pathExtention : Text
		var $inc_i; $cnt_i : Integer
		
		$cnt_i:=Get last table number:C254
		
		For ($inc_i; 4; $cnt_i)
			$suffix:=String:C10($inc_i)+Folder separator:K24:12
			_InputFormDeleteReplace($pathSource; $pathDestination; $suffix)
		End for 
		
	: (Count parameters:C259=3)
		var $1; $2; $3; $pathSource; $pathDestination; $suffix; $pathFolder_t : Text
		$suffix:=$3
		$pathSource:=$1+$suffix+"Input"+Folder separator:K24:12
		$pathDestination:=$2+$suffix  // has the folderDelim 
		$pathFolder_t:=$pathDestination+"InputDS"
		If (Test path name:C476($pathFolder_t)=Is a folder:K24:2)
			DELETE FOLDER:C693($pathFolder_t; Delete with contents:K24:24)  // remove
		End if 
		$pathFolder_t:=$pathDestination+"Input"+Folder separator:K24:12
		DELETE FOLDER:C693($pathFolder_t; Delete with contents:K24:24)  // remove
		//CREATE FOLDER($pathFolder_t)
		COPY DOCUMENT:C541($pathSource; $pathDestination; *)
End case 
