//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $days)  //0 situation, 1 - Time In, 2 - Time out,  3 - Lapse Time
C_POINTER:C301($2; $3; $4; $5; $6)  //Time IN, time out, lapse, date in, date out
If (($1=0) | ($1=1))  //calc lapse time; 0 In changed; 1 Out Changed
	If (($1=1) & ($6->=!00-00-00!))
		$6->:=Current date:C33
	End if 
	If ((($3->>$2->) & ($6->=$5->)) | ($6->>$5->))
		$4->:=Time:C179(Time string:C180(($3->-$2->)+(86400*($6->-$5->))))
	Else 
		If ($1=0)
			$1:=2  //calc Out Time
		Else 
			$1:=3  //calc In Time
		End if 
	End if 
End if 
TRACE:C157
If ($1=2)  //calc Out time    
	$days:=($2->+$4->)\86400
	$3->:=Time:C179(Time string:C180(($2->+$4->)-($days*86400)))
	$6->:=$days+$5->
End if 
If ($1=3)  //calc In time
	$days:=($4->-$3->+86400)\86400
	$2->:=Time:C179(Time string:C180($4->-$3->-($days*86400)))
	$5->:=$6->-$days
End if 