//%attributes = {}

// Modified by: Bill James (2022-08-03T05:00:00Z)
// Method: 19CVT_Loop_RenameProperties
// Description 
// Parameters
// ----------------------------------------------------



var $key_t; $path; $pathExtention : Text
var $inc_i; $cnt_i : Integer

$cnt_i:=Get last table number:C254
$key_t:=Request:C163("Enter Key to convert TF form to objects.")

// remove most actions from input layouts
If ((OK=1) & ($key_t="forkPhone"))
	var $1; $path_t; $pathFolder_t; $pathDSExtention_t : Text
	$path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/TableForms/"
	$path:=Convert path POSIX to system:C1107($path)
	var $folder_o : 4D:C1709.Folder
	$folder_o:=Folder:C1567($path)
	//$path:="Beldin:Users:williamjames:Documents:CommerceExpert:00WebClerkApp:Project:Sources:TableForms:"
	For ($inc_i; 4; $cnt_i)
		$doDS:=False:C215
		$pathExtention:=String:C10($inc_i)+":Input:"
		$pathDSExtention_t:=String:C10($inc_i)+":InputDS:"
		If (Test path name:C476($path+$pathExtention)=Is a folder:K24:2)
			$pathFolder_t:=$path+$pathExtention+"ObjectMethods"+Folder separator:K24:12
			$doDS:=True:C214
			If (Test path name:C476($pathFolder_t)=Is a folder:K24:2)
				// delete the methods
				// var $created : Boolean
				// Folder($pathFolder_t).delete(Delete with contents)
				ConsoleLog("Replacing ObjectMethods: "+Table name:C256($inc_i))
				DELETE FOLDER:C693($pathFolder_t; Delete with contents:K24:24)
				// $created:=Folder($pathFolder_t).create()
				CREATE FOLDER:C475($pathFolder_t; *)
				
				If (Test path name:C476($path+$pathDSExtention_t)=Is a folder:K24:2)
					ConsoleLog("InputDS already exists: "+Table name:C256($inc_i))
				Else 
					//COPY DOCUMENT($path+$pathExtention; $path+String($inc_i); "InputDS";*)
					//CREATE FOLDER($path+$pathDSExtention_t)
					//COPY DOCUMENT($path+$pathExtention; $path+String($inc_i)+":InputDS:"; *)
					COPY DOCUMENT:C541($path+$pathExtention; $path+String:C10($inc_i)+":"; "InputDS:"; *)
					ConsoleLog("InputDS duplicated: "+Table name:C256($inc_i))
				End if 
				19CVT_RenameProperties($path+$pathDSExtention_t+"form.4DForm"; Table name:C256($inc_i))
			End if 
		Else 
			ConsoleLog("Failed, no path: "+Table name:C256($inc_i))
		End if 
	End for 
End if 




If (False:C215)
	
	If (False:C215)
		var $key_t; $path; $pathExtention : Text
		var $inc_i; $cnt_i : Integer
		
		$cnt_i:=Get last table number:C254
		$key_t:=Request:C163("Enter Key to convert TF form to objects.")
		If ((OK=1) & ($key_t="forkPhone"))
			$path:="Beldin:Users:williamjames:Documents:CommerceExpert:00WebClerkApp:Project:Sources:TableForms:"
			For ($inc_i; 2; $cnt_i)
				$pathExtention:=String:C10($inc_i)+":InputDS:form.4DForm"
				If (Test path name:C476($path+$pathExtention)=1)
					ConsoleLog("Converting: "+Table name:C256($inc_i))
					//19CVT_ChangeTFtoObj($path+$pathExtention)
				Else 
					ConsoleLog("Failed, no path: "+Table name:C256($inc_i))
				End if 
			End for 
		End if 
		
		// remove most actions from input layouts
		If ((OK=1) & ($key_t="forkPhone"))
			var $1; $path_t; $pathFolder_t : Text
			$path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/TableForms/"
			$path:=Convert path POSIX to system:C1107($path)
			//$path:="Beldin:Users:williamjames:Documents:CommerceExpert:00WebClerkApp:Project:Sources:TableForms:"
			For ($inc_i; 2; $cnt_i)
				$pathExtention:=String:C10($inc_i)+":Input:"
				If (Test path name:C476($path+$pathExtention)=Is a folder:K24:2)
					$pathFolder_t:=$path+$pathExtention+"ObjectMethods"+Folder separator:K24:12
					If (Test path name:C476($pathFolder_t)=Is a folder:K24:2)
						// delete the methods
						// var $created : Boolean
						// Folder($pathFolder_t).delete(Delete with contents)
						DELETE FOLDER:C693($pathFolder_t; Delete with contents:K24:24)
						// $created:=Folder($pathFolder_t).create()
						CREATE FOLDER:C475($pathFolder_t; *)
					End if 
					ConsoleLog("Replacing ObjectMethods: "+Table name:C256($inc_i))
					19CVT_RenameProperties($path+$pathExtention)  //  to the input folder
				Else 
					ConsoleLog("Failed, no path: "+Table name:C256($inc_i))
				End if 
			End for 
		End if 
	End if 
End if 