//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: VrsPayTypes
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

READ WRITE:C146([DefaultAccount:32])  //keep out of jSetPayTypes, used in accept record gp
GOTO RECORD:C242([DefaultAccount:32]; 0)
CREATE RECORD:C68([AccountPayType:106])

If ([DefaultAccount:32]NameCashAcct:3#"")
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]NameCashAcct:3
Else 
	[AccountPayType:106]PaymentName:1:="Cash"
End if 
[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass1:58
[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcctCash:47
[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]Cash:4
SAVE RECORD:C53([AccountPayType:106])
//
If ([DefaultAccount:32]PayName1:28#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName1:28
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct1:29
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct1:48
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass2:59
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName2:30#"")
	CREATE RECORD:C68([AccountPayType:106])
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName2:30
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct2:31
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct2:49
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass3:60
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName3:32#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName3:32
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct3:33
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct3:50
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass4:61
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName4:34#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName4:34
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct4:35
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct4:51
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass5:62
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName5:36#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName5:36
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct5:37
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct5:52
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass6:63
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName6:38#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName6:38
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct6:39
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct6:53
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass7:64
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName7:40#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName7:40
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct7:41
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct7:54
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass8:65
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
//
If ([DefaultAccount:32]PayName8:42#"")
	CREATE RECORD:C68([AccountPayType:106])
	
	[AccountPayType:106]PaymentName:1:=[DefaultAccount:32]PayName8:42
	[AccountPayType:106]PayDebitAccount:2:=[DefaultAccount:32]PayDebAcct8:43
	[AccountPayType:106]PayCardAccount:3:=[DefaultAccount:32]PayCrdAcct8:55
	[AccountPayType:106]TenderClass:4:=[DefaultAccount:32]TndClass9:66
	[AccountPayType:106]Active:5:=True:C214
	SAVE RECORD:C53([AccountPayType:106])
End if 
