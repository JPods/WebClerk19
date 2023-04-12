//%attributes = {}


// Modified by: Bill James (2022-07-01T05:00:00Z)
// Method: Learning_Workers
// Description 
// Parameters
// ----------------------------------------------------

//https://developer.4D.com/docs/en/API/SystemWorkerClass.html
//https://www.youtube.com/watch?v=RZvj8RfosMw&t=310s

// HOWTO:Worker  SystemWorker
If (False:C215)
	If (Is macOS:C1572)
		$sw:=4D:C1709.SystemWorker.new("open /Applications/BBEdit.app")
	Else 
		$sw:=4D:C1709.SystemWorker.new("C:\\WINDOWS\\notepad.exe"; \
			New object:C1471("hideWindow"; False:C215))
	End if 
	
	
	If (Is macOS:C1572)
		$sw:=4D:C1709.SystemWorker.new("ping -c 1 www.google.com"; \
			New object:C1471("onData"; Formula:C1597(MESSAGE:C88($2.data))))
	Else 
		$sw:=4D:C1709.SystemWorker.new("ping -n 1 www.google.com"; \
			New object:C1471("encoding"; "IBM437"; \
			"onData"; Formula:C1597(MESSAGE:C88($2.data))))
	End if 
	$sw.wait()
End if 

$para:=cs:C1710.cSystemWorker_CallBack_Progress.new(Formula:C1597(UI_ProgressCallback); "www.google.com"; True:C214)
If (Is macOS:C1572)
	$sw:=4D:C1709.SystemWorker.new("ping -c 1 www.google.com"; $para)
Else 
	$sw:=4D:C1709.SystemWorker.new("ping -n 1 www.google.com"; $para)
End if 
$sw.wait()
//ConsoleLog($sw.wait())

