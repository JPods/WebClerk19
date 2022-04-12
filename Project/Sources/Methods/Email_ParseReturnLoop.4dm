//%attributes = {}
If (False:C215)
	//Method: Email_ParseReturnLoop
	Version_0508
	//Date: 02/05/06
	//Who: Bill
	//Description: 
End if 
//
TRACE:C157
C_LONGINT:C283($1; $badEmailMethod)
$badEmailMethod:=0
If (Count parameters:C259=1)
	$badEmailMethod:=$1
Else 
	$badEmailMethod:=Num:C11(Request:C163("Enter 1 to do a sheet."; "0"))
End if 
Case of 
	: ($badEmailMethod=0)
		$fileFold:=Get_FolderName("Select folder to List Files.")
		If ($fileFold#"")
			$error:=HFS_CatToArray($fileFold; "aText1")
			$listBadEmails:=""
			$k:=Size of array:C274(aText1)
			TRACE:C157
			For ($i; 1; $k)
				myDoc:=Open document:C264($fileFold+aText1{$i})
				C_LONGINT:C283(vi1; vi2)
				If (OK=1)
					RECEIVE PACKET:C104(myDoc; vText1; 32000)
					CLOSE DOCUMENT:C267(myDoc)
					vi5:=Position:C15("Reply-To:"; vText1)+9
					vText3:=""
					If (vi5>9)
						vText1:=Substring:C12(vText1; vi5+9)
						vi5:=Position:C15("To:"; vText1)
						If (vi5>0)
							vText1:=Substring:C12(vText1; vi5; 120)
							vText4:=Tx_ClipBetween(vText1; "<"; ">")
							vText5:=vText4
							$listBadEmails:=$listBadEmails+"\r"+vText4
							
							QUERY:C277([Customer:2]; [Customer:2]email:81=vText5)
							vi4:=Records in selection:C76([Customer:2])
							If (vi4>0)
								FIRST RECORD:C50([Customer:2])
								For (vi3; 1; vi4)
									[Customer:2]profile5:30:="bad email"
									SAVE RECORD:C53([Customer:2])
									NEXT RECORD:C51([Customer:2])
								End for 
							End if 
							
						End if 
					End if 
				End if 
			End for 
			SET TEXT TO PASTEBOARD:C523($listBadEmails)
			myDoc:=Create document:C266($fileFold+"badEmails.txt")
			If (OK=1)
				SEND PACKET:C103(myDoc; $listBadEmails)
				CLOSE DOCUMENT:C267(myDoc)
			End if 
			
			
		End if 
	: ($badEmailMethod=1)  //read through a series of emails 
		$listBadEmails:=""
		OptKey:=1  //force to avoid searching when not using the same database.
		myDoc:=Open document:C264("")
		If (OK=1)
			$fileFold:=HFS_ParentName(document)
			vText8:=String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))
			Repeat 
				RECEIVE PACKET:C104(myDoc; vText1; "\n")
				If (OK=1)
					vi5:=Position:C15(" To:"; vText1)
					If (vi5>0)
						vText4:=Tx_ClipBetween(vText1; "<"; ">")
						vText5:=vText4
						$listBadEmails:=$listBadEmails+"\r"+vText4+"\t"+vText5+"\t"+"bad email "+vText8+"Out"
						
						If (OptKey=0)
							QUERY:C277([Customer:2]; [Customer:2]email:81=vText5)
							vi4:=Records in selection:C76([Customer:2])
							If (vi4>0)
								FIRST RECORD:C50([Customer:2])
								For (vi3; 1; vi4)
									[Customer:2]profile5:30:="bad email "+vText8
									SAVE RECORD:C53([Customer:2])
									NEXT RECORD:C51([Customer:2])
								End for 
							End if 
						End if 
					End if 
				End if 
			Until (OK=0)
			CLOSE DOCUMENT:C267(myDoc)
			SET TEXT TO PASTEBOARD:C523($listBadEmails)
			myDoc:=Create document:C266($fileFold+"badEmails.txt")
			If (OK=1)
				SEND PACKET:C103(myDoc; $listBadEmails)
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
		
		
	: ($badEmailMethod=2)
		
		
End case 


