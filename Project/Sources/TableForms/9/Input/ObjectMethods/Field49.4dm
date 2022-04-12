C_LONGINT:C283($error)
$error:=0
$Rep:=[QQQQuota:9]SalesRepID:1
$Date:=[QQQQuota:9]Period:3
PUSH RECORD:C176([QQQQuota:9])
QUERY:C277([QQQQuota:9]; [QQQQuota:9]SalesRepID:1=$Rep; *)
QUERY:C277([QQQQuota:9];  & [QQQQuota:9]Period:3=$Date)
If (Records in selection:C76([QQQQuota:9])>0)
	ALERT:C41("A record already exists for this period.")
	$error:=-1
End if 
POP RECORD:C177([QQQQuota:9])
If ($error=-1)
	[QQQQuota:9]Period:3:=Old:C35([QQQQuota:9]Period:3)
End if 