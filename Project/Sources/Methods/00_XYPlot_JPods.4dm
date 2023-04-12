//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2023-01-01T06:00:00Z)
// Method: XYPath
// Description
// Parameters
// ----------------------------------------------------


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


var $tele_o; $map_o; $line_o; $seg_o : Object
var $tele_t; $map_t : Text
var $dmm; $x; $y : Integer

$map_t:=File:C1566("/Users/williamjames/Model_mapdata/mapV2.json"; fk posix path:K87:1).getText()

If ($map_t#"")
	$map_o:=JSON Parse:C1218($map_t)
	$tele_t:="{\"name\":\"pod_A\",\"msg\":\"TELEMETRY\",\"lineNo\":1,\"dist\":500,\"speed\":55,\"switch\":1}"
	$tele_o:=JSON Parse:C1218($tele_t)
	$line_o:=$map_o[$tele_o.lineNo]
	
	For each ($seg_o; $line_o)
		If ($tele_o.dist>=$seg_o.lenCum)  // we are in this segment, so plot it
			$dmm:=$tele_o.dist-$seg_o.lenCum
			
			$x:=$seg_o.xs+Round:C94($seg_o.dx*$dmm; 0)
			$y:=$seg_o.ys+Round:C94($seg_o.dy*$dmm; 0)
			
			//  or if it is var $tele_o; $map_o; $line_o; $seg_o : Object
			var $tele_t; $map_t : Text
			var $dmm; $x; $y : Integer
			
			$map_t:=File:C1566("/Users/williamjames/Model_mapdata/mapV2.json"; fk posix path:K87:1).getText()
			
			If ($map_t#"")
				$map_o:=JSON Parse:C1218($map_t)
				$tele_t:="{\"name\":\"pod_A\",\"msg\":\"TELEMETRY\",\"lineNo\":1,\"dist\":500,\"speed\":55,\"switch\":1}"
				$tele_o:=JSON Parse:C1218($tele_t)
				$line_o:=$map_o[$tele_o.lineNo]
				
				For each ($seg_o; $line_o)
					If ($tele_o.dist>=$seg_o.lenCum)  // we are in this segment, so plot it
						$dmm:=$tele_o.dist-$seg_o.lenCum
						
						$x:=$seg_o.xs+(Round:C94($seg_o.dx*$dmm; 0))
						$y:=$seg_o.ys+(Round:C94($seg_o.dy*$dmm; 0))
						
						//  or if it is faster
						//Case of // plot the vehicle at these points
						//:(Abs($seg_o.dx)=0.707)  // we are on a curve
						//$x:=$seg_o.xs+(round($seg_o.dx * $dmm,0))
						//$y:=$seg_o.ys+(round($seg_o.dy * $dmm,0))
						//:(Abs($seg_o.dx)=1)  // we are an x only change
						//$x:=$seg_o.xs+(round($seg_o.dx * $dmm,0))
						//$y:=$seg_o.ys
						//Else   // we are an y only change
						//$x:=$seg_o.xs
						//$y:=$seg_o.ys+(round($seg_o.dy * $dmm,0))
						//End case
					End if 
				End for each 
			End if 
			//Case of // plot the vehicle at these points
			//:(Abs($seg_o.dx)=0.707)  // we are on a curve
			//$x:=$seg_o.xs+(round($seg_o.dx * $dmm,0))
			//$y:=$seg_o.ys+(round($seg_o.dy * $dmm,0))
			//:(Abs($seg_o.dx)=1)  // we are an x only change
			//$x:=$seg_o.xs+(round($seg_o.dx * $dmm,0))
			//$y:=$seg_o.ys
			//Else   // we are an y only change
			//$x:=$seg_o.xs
			//$y:=$seg_o.ys+(round($seg_o.dy * $dmm,0))
			//End case
		End if 
	End for each 
End if 