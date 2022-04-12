//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w; $file)
C_TEXT:C284($acct)
ORDER BY:C49([QA:70]; [QA:70]tableNum:11; [QA:70]customerid:1)
$k:=Records in selection:C76([QA:70])
If ($k>0)
	FIRST RECORD:C50([QA:70])
	$i:=1
	If ([QA:70]tableNum:11=2)
		CREATE EMPTY SET:C140([Customer:2]; "Current")
	Else 
		CREATE EMPTY SET:C140([Lead:48]; "Current")
	End if 
	Repeat 
		$acct:=[QA:70]customerid:1
		$file:=[QA:70]tableNum:11
		If ($file=2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[QA:70]customerid:1)
		Else 
			QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([QA:70]customerid:1))
		End if 
		ADD TO SET:C119("Current")
		NEXT RECORD:C51([QA:70])
		$i:=$i+1
		While (($file=[QA:70]tableNum:11) & ([QA:70]customerid:1=$acct) & ($i<$k))
			NEXT RECORD:C51([QA:70])
			$i:=$i+1
		End while 
		$acct:=[QA:70]customerid:1
		If (($file#[QA:70]tableNum:11) | ($i=$k))
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			$file:=[QA:70]tableNum:11
		End if 
	Until ($i>=$k)
End if 