//%attributes = {"publishedWeb":true}
//(GP)GetTimeWandData
C_TEXT:C284($WandID)
C_TEXT:C284($StrIn; $ScanStr)
C_LONGINT:C283($index; $myOK)
C_BOOLEAN:C305($ItemFlag; $doEnd)
KeyModifierCurrent
Case of 
	: (OptKey=1)
		// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
		
		//Case of 
		//: (ptCurTable=(->[Order]))
		//myDocName:=Http_POConfirm(1)
		//: (ptCurTable=(->[PO]))
		//Http_PORecvd
		//End case 
	Else 
		ARRAY TEXT:C222(aTWItemNum; 0)
		ARRAY REAL:C219(aTWQty; 0)
		ARRAY REAL:C219($aQty; 0)
		ARRAY REAL:C219($aPrice; 0)
		Path_Set(Storage:C1525.folder.jitExportsF)
		myDocName:=""
		
		ImportLineItems
		
		
		
		If (False:C215)
			$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; vDocType; Storage:C1525.folder.jitExportsF)  //;jitQRsF
			If ($myOK=1)  //did the file open or was it canceled
				RECEIVE PACKET:C104(myDoc; $StrIn; "\r")
				TRACE:C157
				Case of 
					: (Substring:C12($StrIn; 1; 10)="PrintPoint")
						TR_PrintPoint
					: (Substring:C12($StrIn; 1; 10)="Load Order")  //Order Item Quantity List File
						TR_TimeWands
					: (Substring:C12($StrIn; 1; 8)="Detailed")  //Order Item Quantity List File
						TR_Detailed
				End case 
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
End case 

