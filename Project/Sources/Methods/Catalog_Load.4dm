//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2023-01-22T06:00:00Z)
// Method: Catalog_Load
// Description 
// Parameters
// ----------------------------------------------------


#DECLARE($setup_o : Object)->$data_c : Collection

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
Case of 
	: ($setup_o.delimitLines=Null:C1517)
		$setup_o.delimitLines:="\t"
		$setup_o.delimitLines:="\r"
	: ($setup_o.delimitLines=Null:C1517)
End case 

//https://blog.4d.com/files-folders-and-now-file-handles/
var $file : 4D:C1709.File

$file:=File:C1566($setup_o.path)
$doc_t:=Document to text:C1236($file.platformPath)
If (Position:C15("zqz"; $doc_t)>0)
	$doc_t:=Replace string:C233($doc_t; "\r"; "")
	$doc_t:=Replace string:C233($doc_t; "zqz"; "zqz\r")
End if 

$data_c:=New collection:C1472()  // outbound data
$raw_c:=Split string:C1554($doc_t; $setup_o.delimitLines)
For each ($line_t; $raw_c)
	line_o:=New object:C1471()
	//line_o:=$setup_o.line_o
	$lineSplit_c:=New collection:C1472
	$line_c:=New collection:C1472
	$lineSplit_c:=Split string:C1554($line_t; $setup_o.delimitFields)
	$cnt_i:=$cnt_i+1
	If ($cnt_i=1)
		$head_c:=$lineSplit_c
	Else 
		$cntCell_i:=0
		If ($lineSplit_c.length>0)
			// clean up comma and quotes
			For each ($cell_v; $lineSplit_c)
				If ($cell_v="")
					// do nothing
				Else 
					If ($cell_v[[1]]="\"")
						$cell_v:=Substring:C12($cell_v; 2; Length:C16($cell_v)-2)
						$cell_v:=Replace string:C233($cell_v; "\"\""; "\"")
					End if 
				End if 
				$line_c.push($cell_v)
				$cntCell_i:=$cntCell_i+1
			End for each 
			
			// build json object of a row
			$cntCell_i:=0
			For each ($head_t; $head_c)
				If ($cntCell_i<$line_c.length)
					line_o[$head_t]:=$line_c[$cntCell_i]
				Else 
					
				End if 
				$cntCell_i:=$cntCell_i+1
			End for each 
			
			If (Macintosh option down:C545)
				
			End if 
			// build a collection of lines
			$data_c.push(line_o)
		End if 
	End if 
End for each 



var $setOut : Boolean
$setOut:=False:C215

If ($setOut)
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($data_c))
End if 