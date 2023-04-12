//%attributes = {}

// Modified by: Bill James (2023-01-22T06:00:00Z)
// Method: IE_SpreadSheetToCollection
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($setup_o : Object)->$out_c : Collection
var $rowOne_b : Boolean
var $line_o : Object
var $line_c; $head_c : Collection
var $line_t : Text
var $cnt_i; $cntCell_i : Integer

var $cell_v : Variant
$cnt_i:=0

$setup_o.data:=New collection:C1472()
$doc_t:=Document to text:C1236(Convert path POSIX to system:C1107($setup_o.file.path))
If ($doc_t#"")
	$raw_c:=Split string:C1554($doc_t; $setup_o.delimitLines)
	If ($setup_o.header=Null:C1517)
		$setup_o.header:=Split string:C1554($raw_c[0]; $setup_o.delimitCells)
		$raw_c:=$raw_c.remove(0)
	End if 
	For each ($line_t; $raw_c)
		$line_o:=New object:C1471
		$lineSplit_c:=New collection:C1472
		$line_c:=New collection:C1472
		$lineSplit_c:=Split string:C1554($line_t; $setup_o.delimitCells)
		
		$cntCell_i:=0
		
		
		// clean up comma and quotes
		For each ($cell_v; $lineSplit_c)
			If (Length:C16($cell_v)<1)
				ConsoleLog("error: "+$line_t)
			Else 
				If ($cell_v[[1]]="\"")
					$cell_v:=Substring:C12($cell_v; 2; Length:C16($cell_v)-2)
					$cell_v:=Replace string:C233($cell_v; "\"\""; "\"")
				End if 
				$line_c.push($cell_v)
				$cntCell_i:=$cntCell_i+1
			End if 
		End for each 
		
		
		// build json object of a row
		$cntCell_i:=0
		For each ($head_t; $setup_o.header)
			If ($cntCell_i<$line_c.length)
				$line_o[$head_t]:=$line_c[$cntCell_i]
			Else 
				$line_o[$head_t]:="no_value"
			End if 
			$cntCell_i:=$cntCell_i+1
		End for each 
		
		
		If (Macintosh option down:C545)
			
		End if 
		// build a collection of lines
		$setup_o.data.push($line_o)
		
	End for each 
	$out_c:=$setup_o.data
	
	
	var $setOut : Boolean
	$setOut:=False:C215
	
	If ($setOut)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($setup_o.data))
	End if 
End if 