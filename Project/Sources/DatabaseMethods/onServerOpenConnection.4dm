

If (False:C215)
	
	
	
	// On Server Open Connection Database Method
	C_LONGINT:C283($0; $1; $2; $3)
	// Create a [ServerLog] record
	CREATE RECORD:C68([ServerLog:128])
	//  [ServerLog]UniqueID  set to Auto Increment
	// Save the Log Date and Time
	[ServerLog:128]dateSignOn:3:=Current date:C33
	[ServerLog:128]timeSignOn:8:=Current time:C178
	[ServerLog:128]dtSignOn:10:=DateTime_Enter
	// Save the connection information
	[ServerLog:128]userid:4:=$1
	[ServerLog:128]connectionid:2:=$2
	
	ARRAY TEXT:C222($atUserNames; 0)
	ARRAY LONGINT:C221($aiUserNumbers; 0)
	
	GET USER LIST:C609($atUserNames; $aiUserNumbers)
	
	$vi1:=Find in array:C230($aiUserNumbers; [ServerLog:128]userid:4)
	If ($vi1>0)
		[ServerLog:128]userName:18:=$atUserNames{$vi1}
	Else 
		[ServerLog:128]userName:18:="UNKNOWN"
	End if 
	
	SAVE RECORD:C53([ServerLog:128])
	// Returns no error so that the connection can continue
	$0:=0
	
End if 
