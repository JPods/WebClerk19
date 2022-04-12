//%attributes = {}



// 4D_25Invoice - 2022-01-15
USE ENTITY SELECTION:C1513(Form:C1466.displayedSelection)

$message:=Util25_Get_LocalizedMessage("Print_M1"; String:C10(Form:C1466.displayedSelection.length); Form:C1466.dataClassName)  //You are going to print [1] [2].
CONFIRM:C162($message; Get localized string:C991("OK"); Get localized string:C991("Cancel"))
If (OK=1)
	$message:=Util25_Get_LocalizedMessage("Print_M2")  //How do you want to Print it?
	CONFIRM:C162($message; Get localized string:C991("asList"); Get localized string:C991("asInvoice"))
	
	If (OK=1)  //Print a list of Invoices
		$dataClassPtr:=Table:C252(Form:C1466.dataClass.getInfo().tableNumber)
		FORM SET OUTPUT:C54($dataClassPtr->; "List")
		PRINT SELECTION:C60($dataClassPtr->)
		
	Else 
		$message:=Get localized string:C991("Print_M3")  //What do you want to do with the Resulting Invoices?
		CONFIRM:C162($message; Get localized string:C991("asPrint"); Get localized string:C991("asMail"))  //"Print it";"Mail it to Clients")
		If (OK=1)
			$flMail:=False:C215
		Else 
			$flMail:=True:C214
		End if 
		OK:=1
		If ($flMail)
			$folderPath:=Temporary folder:C486
			$invoiceName:="TempInvoice_"
			$listCollection:=New collection:C1472
		Else 
			$folderPath:=Select folder:C670(Get localized string:C991("Print_M4"))  //"Select a Folder to receive the PDFs:")
			$invoiceName:="Invoice_"
		End if 
		If (OK=1)
			CONFIRM:C162(Get localized string:C991("Print_M5"); Get localized string:C991("Yes"); Get localized string:C991("No"))  //Do you want to preview each Invoice?
			SET PRINT PREVIEW:C364(OK=1)
			FORM SET OUTPUT:C54([Invoices:2]; "Invoice")
			FIRST RECORD:C50([Invoices:2])
			$nbInvoices:=Records in selection:C76([Invoices:2])
			For ($i; 1; $nbInvoices)
				$pdfPath:=$folderPath+$invoiceName+String:C10($i)+".pdf"
				If (Is macOS:C1572)
					SET PRINT OPTION:C733(Destination option:K47:7; 3; $pdfPath)
				Else 
					SET CURRENT PRINTER:C787("Microsoft Print to PDF")
					SET PRINT OPTION:C733(Destination option:K47:7; 2; $pdfPath)
				End if 
				gError:=0
				ON ERR CALL:C155("Hndl_Error")
				PRINT RECORD:C71([Invoices:2]; >)
				If (gError#0)
					//Alert is displayed by Hndl_Error
					$flMail:=False:C215
					$i:=$nbInvoices
				End if 
				ON ERR CALL:C155("")
				If ($flMail)
					$listCollection.push(New object:C1471("invoicePath"; $pdfPath; \
						"invoiceID"; [Invoices:2]ID:1))
				End if 
				NEXT RECORD:C51([Invoices:2])
			End for 
			SET PRINT PREVIEW:C364(False:C215)
			If ($flMail)
				$message:=action_CheckSMTP
				If ($message="OK")
					If ($listCollection.length>0)
						For each ($invoiceInfo; $listCollection)
							Util25_SendByMail($invoiceInfo; Form:C1466.settings)
						End for each 
					End if 
				Else 
					ALERT:C41(Util25_Get_LocalizedMessage("CheckNo"; $message))  //"An error occurred: "+$status.message)
				End if 
			Else 
				If (gError=0)
					ALERT:C41(Util25_Get_LocalizedMessage("Print_M6"; String:C10($nbInvoices)))  //"You have just printed "+String($nbInvoices)+" Invoices!")
				End if 
			End if 
		End if 
	End if 
End if 
