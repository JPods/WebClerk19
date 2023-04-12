//%attributes = {"publishedWeb":true}
//*** Hard coded values section.  These variables are ment to
//*** be changed by the user to effect the way this script works.
//*** This is the number of days old to limit located invoices to.
vi9:=90
//*** This is the Type Sale of the invoices to Query on
vText9:="Wholesale"
//*** These are the [Contact]KeyText filter strings
vText7:="sel"
vText8:="shp"
//
C_LONGINT:C283($1; $2)

If (Count parameters:C259=2)
	OptKey:=$1
	CmdKey:=$2
	OK:=1
Else 
	vdDateEnd:=Date_ThisMon(Current date:C33-15; 1)
	vdDateBeg:=Date_ThisMon(Current date:C33-15; 0)
	jBetweenDates("Tally DealerLocator."; vdDateBeg; vdDateEnd)
	If (OK=1)
		QUERY:C277([Invoice:26]; [Invoice:26]dateShipped:4>=vdDateBeg; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4<=vdDateEnd)
		CmdKey:=1
	End if 
End if 
TRACE:C157
vdDateEnd:=Date_ThisMon(vdDateEnd; 1)
$k:=Records in selection:C76([Invoice:26])

If ((OK=1) & ($k>0))
	
	READ WRITE:C146([TallyResult:73])
	If (CmdKey=1)
		QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="DealerLocator")
		DELETE SELECTION:C66([TallyResult:73])
	End if 
	C_LONGINT:C283($dtRpt)
	$dtRpt:=DateTime_DTTo(vdDateEnd; ?23:59:59?)
	ORDER BY:C49([Invoice:26]; [Invoice:26]customerID:3)
	C_LONGINT:C283($i; $k; $w; $incLine; $cntLine; $p)
	FIRST RECORD:C50([Invoice:26])
	For ($i; 1; $k)
		If ([Invoice:26]typeSale:49#"Retail@")
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="DealerLocator"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=[Invoice:26]customerID:3; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=[Invoice:26]typeSale:49; *)
			If ([Invoice:26]contactShipTo:72#0)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1="ShipTo "+String:C10([Invoice:26]contactShipTo:72); *)
			End if 
			QUERY:C277([TallyResult:73])
			If (Records in selection:C76([TallyResult:73])=0)
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]nameProfile1:26:="Zip"
				[TallyResult:73]nameProfile2:27:="Company"
				[TallyResult:73]nameProfile3:28:="Phone"
				//
				[TallyResult:73]purpose:2:="DealerLocator"
				[TallyResult:73]customerID:30:=[Invoice:26]customerID:3
				[TallyResult:73]salesNameID:31:=[Invoice:26]typeSale:49
				If ([Invoice:26]contactShipTo:72#0)
					[TallyResult:73]name:1:="ShipTo "+String:C10([Invoice:26]contactShipTo:72)
				Else 
					[TallyResult:73]name:1:="Dealer"
				End if 
			End if 
			[TallyResult:73]dtReport:12:=$dtRpt
			[TallyResult:73]profile1:17:=Substring:C12([Invoice:26]zip:12; 1; 5)
			[TallyResult:73]profile2:18:=Substring:C12([Invoice:26]company:7; 1; 20)
			If ([Invoice:26]phone:54="")
				If ([Customer:2]customerID:1#[Invoice:26]customerID:3)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
				End if 
				[TallyResult:73]profile3:19:=Format_Phone([Customer:2]phone:13)
			Else 
				[TallyResult:73]profile3:19:=Format_Phone([Invoice:26]phone:54)
			End if 
			[TallyResult:73]textBlk1:5:=[Invoice:26]company:7+"\r"+[Invoice:26]address1:8+("\r"*Num:C11([Invoice:26]address2:9#""))+[Invoice:26]address2:9+"\r"+[Invoice:26]city:10+", "+[Invoice:26]state:11+"  "+[Invoice:26]zip:12  //+"\r"+[Invoice]Country
			[TallyResult:73]textBlk1:5:=[TallyResult:73]textBlk1:5+"\r"+"mailto:"+[Customer:2]email:81+"\r"+"http://"+[Customer:2]domain:90
			[TallyResult:73]publish:36:=1
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
			$cntLine:=Records in selection:C76([InvoiceLine:54])
			FIRST RECORD:C50([InvoiceLine:54])
			For ($incLine; 1; $cntLine)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
				If (Records in selection:C76([Item:4])=1)
					$p:=Position:C15([Item:4]profile2:36; [TallyResult:73]textBlk2:6)
					If ($p=0)
						[TallyResult:73]textBlk2:6:=[TallyResult:73]textBlk2:6+("; "*Num:C11([TallyResult:73]textBlk2:6#""))+[Item:4]profile2:36
					End if 
				End if 
			End for 
			SAVE RECORD:C53([TallyResult:73])
		End if 
		NEXT RECORD:C51([Invoice:26])
	End for 
End if 