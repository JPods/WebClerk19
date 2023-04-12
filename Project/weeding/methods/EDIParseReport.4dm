//%attributes = {}
//script Update OrderLine DateOrdered 201910129.4d
//Shift & Caps Lock Key to Exit
TRACE:C157

$viProgressID:=Progress New

$vtPath:=Select folder:C670("")

ARRAY TEXT:C222($atPaths; 0)

DOCUMENT LIST:C474($vtPath; $atPaths; Absolute path:K24:14)

$vi2:=Size of array:C274($atPaths)

$vtReport:=""
$vtMessage:="\"SenderID\",\"ReceiverID\",\"Date\",\"Time\",\"ISA\",\"GS\",\"ST\",\"Type\",\"PONum\""
ConsoleLog($vtMessage)
$vtReport:=$vtReport+$vtMessage+"\r"

For ($vi1; 1; $vi2)
	
	ProgressUpdate($viProgressID; $vi1; $vi2; "Reading Files...")
	
	If (($atPaths{$vi1}="@850@") & ($atPaths{$vi1}="@.edi"))
		$vtDocument:=Document to text:C1236($atPaths{$vi1}; "UTF-8"; Document with CR:K24:21)
		ARRAY TEXT:C222($atLine; 0)
		TextToArray($vtDocument; ->$atLine; "\r"; True:C214)
		$vi4:=Size of array:C274($atLine)
		For ($vi3; 1; $vi4)
			
			$vtLine:=$atLine{$vi3}
			Case of 
				: ($vtLine="ISA@")
					$vtDelimiter:=Substring:C12($vtLine; 4; 1)
					ARRAY TEXT:C222($atSegment; 0)
					TextToArray($vtLine; ->$atSegment; $vtDelimiter; True:C214)
					$vtSenderID:=$atSegment{6}+$atSegment{7}
					$vtReceiverID:=$atSegment{8}+$atSegment{9}
					$vtISA:=$atSegment{13}
					
				: ($vtLine="GS@")
					ARRAY TEXT:C222($atSegment; 0)
					TextToArray($vtLine; ->$atSegment; $vtDelimiter; True:C214)
					$vtDate:=$atSegment{5}
					$vtTime:=$atSegment{6}
					$vtGS:=$atSegment{7}
					
				: ($vtLine="ST@")
					ARRAY TEXT:C222($atSegment; 0)
					TextToArray($vtLine; ->$atSegment; $vtDelimiter; True:C214)
					$vtST01:=$atSegment{2}
					$vtST02:=$atSegment{3}
					
				: ($vtLine="BEG@")
					ARRAY TEXT:C222($atSegment; 0)
					TextToArray($vtLine; ->$atSegment; $vtDelimiter; True:C214)
					$vtPONum:=$atSegment{4}
					
					$vtMessage:="=\""+$vtSenderID+"\",=\""+$vtReceiverID+"\",\""+$vtDate+"\",\""+$vtTime+"\",\""+$vtISA+"\",\""+$vtGS+"\",\""+$vtST02+"\",\""+$vtST01+"\",\""+$vtPONum+"\""
					ConsoleLog($vtMessage)
					
					$vtReport:=$vtReport+$vtMessage+"\r"
					
			End case 
			
		End for 
		
		
	End if 
	
	
End for 

vhDocRef:=Create document:C266(""; ".csv")
CLOSE DOCUMENT:C267(vhDocRef)

TEXT TO DOCUMENT:C1237(document; $vtReport; "US-ASCII"; Document with CR:K24:21)

//Text to Document($vtPath+"EDI 850 Report.csv";$vtReport;"US-ASCII";Document with CR)

Progress QUIT($viProgressID)



