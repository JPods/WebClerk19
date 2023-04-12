//%attributes = {}

// Modified by: Bill James (2023-01-01T06:00:00Z)
// Method: XYPath
// Description 
// Parameters
// ----------------------------------------------------

var $myDocName; $working_t : Text
var $file_o : Object
$myDocName:="/Users/williamjames/Model_mapdata/Path_2023-01-02.txt"
$file_o:=File:C1566($myDocName; fk posix path:K87:1)


// $working_t:=Document to text($file_o)

$working_t:=$file_o.getText()
If ($working_t#"")
	var $working_o; $line_o; $seg_o : Object
	var $curve_c : Collection
	var $lineName_t : Text
	$working_o:=JSON Parse:C1218($working_t)
	If ($working_o.curveIncrement=Null:C1517)
		$working_o.curveIncrement:=10
	End if 
	For each ($line_o; $working_o.lines)
		For each ($lineName_t; $line_o)
			For each ($seg_c; $line_o[$lineName_t].segments)
				$curve_c:=New collection:C1472()
				If (Abs:C99($seg_c.dx)=0.707)
					var $inc; $cnt : Integer
					$cnt:=$seg_c.len/$working_o.curveIncrement-2  //start point and end points are known
					$curve_c.push($seg_c.endPoints[0])
					For ($inc; 1; $cnt)
						$xChange:=Round:C94($inc*$seg_c.dx*$working_o.curveIncrement+$seg_c.endPoints[0].x; 0)
						$yChange:=Round:C94($inc*$seg_c.dy*$working_o.curveIncrement+$seg_c.endPoints[0].y; 0)
						$curve_c.push(New object:C1471("x"; $xChange; "y"; $yChange))
					End for 
					$curve_c.push($seg_c.endPoints[1])
					$seg_c.curve:=$curve_c
				Else 
					$seg_c.curve:=$seg_c.endPoints
				End if 
			End for each 
		End for each 
	End for each 
	
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($working_o))
	
End if 