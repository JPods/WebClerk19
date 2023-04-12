//%attributes = {}

// Modified by: Bill James (2022-05-26T05:00:00Z)
// Method: Cat_Document_to_object
// Description 
// Parameters
// ----------------------------------------------------


#DECLARE($pathToDoc : Text; $json2Clip : Boolean)->$return : Object
var $cLines; $cHeader; $cFields : Collection
var $myFile; $jsonFile; $reportFile : Object
var $workingText; $line_t; $header_t : Text
var $myDoc : Time
var $created : Boolean
If ($pathToDoc="")
	$myDoc:=Open document:C264(""; Read mode:K24:5)
	If (OK=1)
		CLOSE DOCUMENT:C267($myDoc)
		$pathToDoc:=document
	End if 
End if 
If ($pathToDoc#"")
	$myFile:=File:C1566($pathToDoc; fk platform path:K87:2)
	$jsonFile:=$myFile.parent.file("jsonRework-"+String:C10(Tickcount:C458)+".txt")
	$created:=$jsonFile.create()
	
	//$reportFile:=$myFile.parent.file("reportRework-"+String(Tickcount)+".txt").create()
	// HOWTO:FileFolder
	//$new:=Folder(Storage.folder.jitF).file("act/ItemReworked-"+String(Tickcount)+".txt").create()
	//$workingText:=$myFile.getText(Document with CR)
	$workingText:=$myFile.getText()
	
	//"outPut";$reportFile.name; 
	$json_o:=New object:C1471("date"; Current date:C33; "file"; $myFile.name; "json"; $jsonFile.name; "lines"; New collection:C1472)
	
	$cLines:=Split string:C1554($workingText; Char:C90(13))
	$countLines:=0
	For each ($line_t; $cLines)
		$countLines:=$countLines+1
		If ($countLines=1)
			$cHeader:=Split string:C1554($line_t; Storage:C1525.char.tab)
		Else 
			upDated_t:=""
			$cFields:=Split string:C1554($line_t; Storage:C1525.char.tab)
			$line_o:=New object:C1471
			$countHead:=0
			For each (vText7; $cHeader)
				$line_o[vText7]:=$cFields[$countHead]
				$countHead:=$countHead+1
			End for each 
			$json_o.lines.push($line_o)
			
		End if 
	End for each 
	
	$return:=New object:C1471("file"; $myFile; "data"; $json_o)
	
	If ($json2Clip)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($return.data))
	End if 
	
End if 
