//%attributes = {"publishedWeb":true}
//TRACE
//jSetPayTypes
If (False:C215)
	C_LONGINT:C283($index)
	ARRAY LONGINT:C221(<>aTndClass; 9)
	ARRAY TEXT:C222(<>aPayTypes; 9)  //Check before phase of layout
	ARRAY TEXT:C222(<>aPayDebitAccount; 9)  //Check before phase of layout
	//aPayTypes{1}:=Substring([DefaultAcct]NameCashAcct;1;20)
	//For ($index;28;42;2)
	//  $ptField:=Field(File([DefaultAcct]);$index)
	//  If ($ptField#"")
	//    $fia:=Find in array(aPayTypes;$ptField)
	//    If ($fia=-1)
	//      INSERT ELEMENT(aPayTypes;1)
	//      INSERT ELEMENT(aTndClass;1)
	//      aPayTypes{1}:=$ptField
	//      aTndClass{1}:=
	//    End if 
	//  End if 
	//End for 
	//SORT ARRAY(aPayTypes;>)
	<>aPayTypes{1}:=[DefaultAccount:32]NameCashAcct:3
	<>aTndClass{1}:=[DefaultAccount:32]TndClass1:58
	<>aPayTypes{2}:=[DefaultAccount:32]PayName1:28
	<>aTndClass{2}:=[DefaultAccount:32]TndClass2:59
	<>aPayTypes{3}:=[DefaultAccount:32]PayName2:30
	<>aTndClass{3}:=[DefaultAccount:32]TndClass3:60
	<>aPayTypes{4}:=[DefaultAccount:32]PayName3:32
	<>aTndClass{4}:=[DefaultAccount:32]TndClass4:61
	<>aPayTypes{5}:=[DefaultAccount:32]PayName4:34
	<>aTndClass{5}:=[DefaultAccount:32]TndClass5:62
	<>aPayTypes{6}:=[DefaultAccount:32]PayName5:36
	<>aTndClass{6}:=[DefaultAccount:32]TndClass6:63
	<>aPayTypes{7}:=[DefaultAccount:32]PayName6:38
	<>aTndClass{7}:=[DefaultAccount:32]TndClass7:64
	<>aPayTypes{8}:=[DefaultAccount:32]PayName7:40
	<>aTndClass{8}:=[DefaultAccount:32]TndClass8:65
	<>aPayTypes{9}:=[DefaultAccount:32]PayName8:42
	<>aTndClass{9}:=[DefaultAccount:32]TndClass9:66
	//aPayTypes{10}:=[DefaultAcct]PayName9
	//aTndClass{10}:=[DefaultAcct]TndClass10
	For ($index; 9; 1; -1)
		If (<>aPayTypes{$index}="")
			DELETE FROM ARRAY:C228(<>aPayTypes; $index)
			DELETE FROM ARRAY:C228(<>aTndClass; $index)
		End if 
	End for 
Else 
	ARRAY LONGINT:C221(<>aTndClass; 0)
	ARRAY TEXT:C222(<>aPayTypes; 0)  //Check before phase of layout
	ARRAY TEXT:C222(<>aPayDebitAccount; 0)  //Check before phase of layout  
	ARRAY TEXT:C222(<>aPayCreditAccount; 0)
	QUERY:C277([AccountPayType:106]; [AccountPayType:106]Active:5=True:C214)
	SELECTION TO ARRAY:C260([AccountPayType:106]PaymentName:1; <>aPayTypes; [AccountPayType:106]TenderClass:4; <>aTndClass; [AccountPayType:106]PayDebitAccount:2; <>aPayDebitAccount; [AccountPayType:106]PayCardAccount:3; <>aPayCreditAccount)
	REDUCE SELECTION:C351([AccountPayType:106]; 0)
End if 