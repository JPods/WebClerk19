//%attributes = {}

// Modified by: Bill James (2022-05-26T05:00:00Z)
// Method: Cat_Testing
// Description 
// Parameters
// ----------------------------------------------------
var $file_o; $setup_o : Object
var $data_c : Collection
var $path_t : Text

$path_t:="/Users/williamjames/Downloads/CopperfieldUpdate2_2023-01-17.txt"

$file_o:=IE_GetFileObj($path_t)
If ($file_o#Null:C1517)
	$setup_o:=New object:C1471("file"; $file_o; \
		"delimitLines"; "\r"; \
		"delimitCells"; "\t"; \
		"data"; New collection:C1472; \
		"header"; Null:C1517)
	$data_c:=IE_SpreadSheetToCollection($setup_o)
	
End if 
//$data_o:=Cat_Document_to_object($path_t; False)
