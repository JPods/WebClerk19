//%attributes = {"publishedWeb":true}
//(P) prntCOD
//setPrinter (0;"";"AppleTalk ImageWriter";"Linus")
C_LONGINT:C283($i)

If (vHere=1)
	CREATE SET:C116([Invoice:26]; "selectedInv")
	CREATE EMPTY SET:C140([Invoice:26]; "otherInv")
	QUERY SELECTION BY FORMULA:C207([Invoice:26]; ([Invoice:26]shipVia:5="UPS@") & ([Invoice:26]terms:24=<>tcCODTerm))
	CREATE SET:C116([Invoice:26]; "UPS CODs")
	//
	DIFFERENCE:C122("selectedInv"; "UPS CODs"; "otherInv")
	USE SET:C118("otherInv")
	QUERY SELECTION BY FORMULA:C207([Invoice:26]; ([Invoice:26]shipVia:5="RPS@") & ([Invoice:26]terms:24=<>tcCODTerm))
	CREATE SET:C116([Invoice:26]; "RPS CODs")
	DIFFERENCE:C122("otherInv"; "RPS CODs"; "otherInv")
	//
	If (Records in set:C195("RPS CODs")>0)
		CONFIRM:C162("Print the "+String:C10(Records in set:C195("RPS CODs"))+" RPS COD labels.")
		If (Ok=1)
			PRINT SETTINGS:C106
			If (Ok=1)
				USE SET:C118("RPS CODs")
				FIRST RECORD:C50([Invoice:26])
				InfoShipper([Invoice:26]shipVia:5; ->vShipper; ->vShipperID; ->vFrghtType)
				For ($i; 1; Records in selection:C76([Invoice:26]))
					Print form:C5([Invoice:26]; "label RPS")
					NEXT RECORD:C51([Invoice:26])
				End for 
				PAGE BREAK:C6
			End if 
		End if 
	End if 
	If (Records in set:C195("UPS CODs")>0)
		CONFIRM:C162("Print the "+String:C10(Records in set:C195("UPS CODs"))+" UPS COD labels.")
		If (Ok=1)
			PRINT SETTINGS:C106
			If (Ok=1)
				USE SET:C118("UPS CODs")
				FIRST RECORD:C50([Invoice:26])
				InfoShipper([Invoice:26]shipVia:5; ->vShipper; ->vShipperID; ->vFrghtType)
				For ($i; 1; Records in selection:C76([Invoice:26]))
					Print form:C5([Invoice:26]; "label UPS")
					NEXT RECORD:C51([Invoice:26])
				End for 
				PAGE BREAK:C6
			End if 
		End if 
	End if 
	If (Records in set:C195("otherInv")>0)
		CONFIRM:C162("Show the "+String:C10(Records in set:C195("otherInv"))+" other labels.")
		If (Ok=1)
			USE SET:C118("otherInv")
		Else 
			USE SET:C118("selectedInv")
		End if 
	Else 
		USE SET:C118("selectedInv")
	End if 
	CLEAR SET:C117("selectedInv")
	CLEAR SET:C117("otherInv")
	CLEAR SET:C117("RPS CODs")
	CLEAR SET:C117("UPS CODs")
Else 
	InfoShipper([Invoice:26]shipVia:5; ->vShipper; ->vShipperID; ->vFrghtType)
	Case of 
		: (([Invoice:26]shipVia:5="UPS@") & ([Invoice:26]terms:24=<>tcCODTerm))
			Print form:C5([Invoice:26]; "label UPS")
			PAGE BREAK:C6
		: (([Invoice:26]shipVia:5="RPS@") & ([Invoice:26]terms:24=<>tcCODTerm))
			Print form:C5([Invoice:26]; "label RPS")
			PAGE BREAK:C6
		Else 
			ALERT:C41("This is not a COD Invoice.")
	End case 
End if 
FORM SET OUTPUT:C54([Invoice:26]; "oInvoices_9")