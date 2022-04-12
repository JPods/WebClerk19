//%attributes = {"publishedWeb":true}
ALL RECORDS:C47([Contact:13])
ORDER BY:C49([Contact:13]; [Contact:13]customerID:1)
FIRST RECORD:C50([Contact:13])
vi2:=Records in selection:C76([Contact:13])
For (vi1; 1; vi2)
	If ([Contact:13]customerID:1#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
	End if 
	If (Record number:C243([Customer:2])=-1)
		[Contact:13]profile1:18:="No Cust"
	Else 
		[Contact:13]profile1:18:=[Customer:2]profile1:26
	End if 
	SAVE RECORD:C53([Contact:13])
	NEXT RECORD:C51([Contact:13])
End for 