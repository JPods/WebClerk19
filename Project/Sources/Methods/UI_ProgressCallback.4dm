//%attributes = {}

// Modified by: Bill James (2022-07-01T05:00:00Z)
// Method: UI_ProgressCallback
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($ID : Text; $message : Text; $value : Integer; $sharedForProgressBar : Object)

var ProgressBarCol : Collection  // using global variable so still set when worker is called again
If (ProgressBarCol=Null:C1517)
	ProgressBarCol:=New collection:C1472
End if 

$currentProgress:=ProgressBarCol.query("ID = :1"; $ID)
If ($currentProgress.length#0)
	$ProgressBarID:=$currentProgress[0].progressID
Else 
	$ProgressBarID:=0
End if 

If (($ProgressBarID=0) && ($value#100))
	Progress SET TITLE($ProgressBarID; $ID)
	ProgressBarCol.push(New object:C1471("ID"; $ID; "progressID"; $ProgressBarID))
	
	// check to see if we need to stop, if yes, add it to storage
	
	If (Bool:C1537($sharedForProgressBar.EnableButton))
		Progress SET BUTTON ENABLED($ProgressBarID; True:C214)
	End if 
End if 

If ($ProgressBarID#0)
	If (Progress Stopped($ProgressBarID))
		Use ($sharedForProgressBar)
			$sharedForProgressBar.Stop:=True:C214
		End use 
	End if 
	
	Case of 
		: ($value=100)
			Progress QUIT($ProgressBarID)
			// finished, remove from collection
			$index:=ProgressBarCol.indexOf($currentProgress[0])
			ProgressBarCol.remove($index)
			$ProgressBarID:=0
		: ($value<0)
			Progress SET MESSAGE($ProgressBarID; $message)
		Else 
			//Progress SET MESSAGE($ProgressBarID; "processing"; $value/100)
	End case 
End if 


