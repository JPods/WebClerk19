//%attributes = {}

// Modified by: Bill James (2022-03-25T05:00:00Z)
// Method: 19CVT_LoopInputDSTFtoOBJ
// Description 
// Parameters
// ----------------------------------------------------


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
				ConsoleMessage("Converting: "+Table name:C256($inc_i))
				//19CVT_ChangeTFtoObj($path+$pathExtention)
			Else 
				ConsoleMessage("Failed, no path: "+Table name:C256($inc_i))
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
				ConsoleMessage("Replacing ObjectMethods: "+Table name:C256($inc_i))
				19CVT_InputRemoveMethods($path+$pathExtention)  //  to the input folder
			Else 
				ConsoleMessage("Failed, no path: "+Table name:C256($inc_i))
			End if 
		End for 
	End if 
End if 