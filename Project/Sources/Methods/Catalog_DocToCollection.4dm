//%attributes = {}

// Modified by: Bill James (2023-01-22T06:00:00Z)
// Method: Catalog_DocToCollection
// Description 
// Parameters
// ----------------------------------------------------


// Catalog_Load
#DECLARE($setup_o : Object)->$result : Collection

var $setup_o : Object
var $out_t : Text
var $itemNum_t : Text
var $path_t : Text




var $line_c; $head_c : Collection
var $line_t : Text
var $cnt_i; $cntCell_i : Integer
var line_o : Object
var $cell_v : Variant
$cnt_i:=0



$data_c:=New collection:C1472()
$doc_t:=Document to text:C1236($setup_o.path)
$raw_c:=Split string:C1554($doc_t; $setup_o.delimitDoc)
For each ($line_t; $raw_c)
	line_o:=New object:C1471()
	//line_o:=$setup_o.line_o
	$lineSplit_c:=New collection:C1472
	$line_c:=New collection:C1472
	$lineSplit_c:=Split string:C1554($line_t; $setup_o.delimitLine)
	$cnt_i:=$cnt_i+1
	If ($cnt_i=1)
		$head_c:=$lineSplit_c
	Else 
		$cntCell_i:=0
		
		// clean up comma and quotes
		For each ($cell_v; $lineSplit_c)
			If ($cell_v[[1]]="\"")
				$cell_v:=Substring:C12($cell_v; 2; Length:C16($cell_v)-2)
				$cell_v:=Replace string:C233($cell_v; "\"\""; "\"")
			End if 
			$line_c.push($cell_v)
			$cntCell_i:=$cntCell_i+1
		End for each 
		
		// build json object of a row
		$cntCell_i:=0
		For each ($head_t; $head_c)
			line_o[$head_t]:=$line_c[$cntCell_i]
			$cntCell_i:=$cntCell_i+1
		End for each 
		
		
		If (Macintosh option down:C545)
			
		End if 
		// build a collection of lines
		$data_c.push(line_o)
	End if 
End for each 
$result:=$data_c


var $setOut : Boolean
$setOut:=False:C215

If ($setOut)
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($data_c))
End if 