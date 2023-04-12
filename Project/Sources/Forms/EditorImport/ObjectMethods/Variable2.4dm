var $data_o : Object
var $path_t : Text




Cat_Testing




// $data_o:=Cat_Document_to_object($path_t; False)

var $pathToDoc : Text
If ($pathToDoc="")
	$myDoc:=Open document:C264(""; Read mode:K24:5)
	If (OK=1)
		CLOSE DOCUMENT:C267($myDoc)
		$pathToDoc:=document
	End if 
End if 
If ($pathToDoc#"")
	$myFile:=File:C1566($pathToDoc; fk platform path:K87:2)
	
	
	$path_t:="/Users/williamjames/Downloads/Copperfield/TabText.txt"
	$path_t:=Convert path POSIX to system:C1107($path_t)
	$setup_o:=New object:C1471(\
		"path"; $path_t; \
		"delimitDoc"; "\r"; \
		"delimitLine"; "\t"; \
		"vendorSuffix"; "-CCS"; \
		"line"; New object:C1471(\
		"i_item"; ""; \
		"o_item"; ""; \
		"mfrPart"; ""; \
		"o_description"; ""; \
		"i_description"; ""; \
		"c_description"; ""; \
		"o_cost"; 0; \
		"i_cost"; 0; \
		"perCent"; 0; \
		"change"; 0; \
		"page"; 0; \
		"OrderLines"; 0; \
		"POLines"; 0; \
		"ProposalLines"; 0; \
		"mfrItem"; ""; \
		"venItem"; ""; \
		"status"; ""; \
		"script"; ""))
	
	
	
	$dataRaw_c:=Catalog_Load($setup_o)
End if 