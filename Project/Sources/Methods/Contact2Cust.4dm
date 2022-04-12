//%attributes = {"publishedWeb":true}
C_LONGINT:C283($incRecs; $kntRecs)
C_TEXT:C284($theAcct; $theTest)
$theAcct:=Substring:C12([Customer:2]customerID:1; 1; 6)
QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
$kntRecs:=Records in selection:C76([Contact:13])
If ($kntRecs>1)
	PUSH RECORD:C176([Customer:2])
	FIRST RECORD:C50([Contact:13])
	For ($incRecs; 1; $kntRecs)
		$theTest:=$theAcct+String:C10($incRecs)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=$theTest)
		If (Records in selection:C76([Customer:2])=0)
			CREATE RECORD:C68([Customer:2])
		End if 
		[Customer:2]customerID:1:=$theTest
		[Customer:2]company:2:=[Contact:13]company:23
		[Customer:2]address1:4:=[Contact:13]address1:6
		[Customer:2]address2:5:=[Contact:13]address2:7
		[Customer:2]city:6:=[Contact:13]city:8
		[Customer:2]state:7:=[Contact:13]state:9
		[Customer:2]zip:8:=[Contact:13]zip:11
		[Customer:2]country:9:=[Contact:13]country:12
		[Customer:2]nameLast:23:=[Contact:13]nameLast:4
		[Customer:2]phone:13:=[Contact:13]profile1:18
		[Customer:2]zone:57:=[Contact:13]zone:27
		[Customer:2]shipVia:12:=[Contact:13]shipVia:26
		[Customer:2]taxJuris:65:=[Contact:13]taxJuris:24
		SAVE RECORD:C53([Customer:2])
		NEXT RECORD:C51([Contact:13])
	End for 
	POP RECORD:C177([Customer:2])
	CONFIRM:C162("Recommended delete Contacts?")
	If (OK=1)
		DELETE SELECTION:C66([Contact:13])
	End if 
Else 
	ALERT:C41("There are few contacts, No change.")
End if 