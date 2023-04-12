//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 01:19:58
// ----------------------------------------------------
// Method: jParsePhones
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)

C_LONGINT:C283($i; $k)
C_POINTER:C301($ptFile; ptDestin; ptFaxSrc; ptFax)
Repeat 
	File_Select("Choose File for Phone Clean-up.  Click OK to proceed.")
	Case of 
		: (Records in selection:C76(Table:C252(curTableNum)->)=0)
			jAlertMessage(10003)
		: (OK=1)
			myOK:=1
			$ptFile:=Table:C252(curTableNum)
			Case of 
				: (Table:C252(->[Customer:2])=curTableNum)
					ptDestin:=->[Customer:2]phone:13
					ptFax:=->[Customer:2]fax:66
				: (Table:C252(->[Rep:8])=curTableNum)
					ptDestin:=->[Rep:8]phone:10
					ptFax:=->[Rep:8]fax:20
				: (Table:C252(->[Vendor:38])=curTableNum)
					ptDestin:=->[Vendor:38]phone:10
					ptFax:=->[Vendor:38]fax:13
				: (Table:C252(->[Reference:7])=curTableNum)
					ptDestin:=->[Reference:7]switchboard:9
					ptFax:=->[Reference:7]switchboard:9
				: (Table:C252(->[RepContact:10])=curTableNum)
					
				: (Table:C252(->[Contact:13])=curTableNum)
					
				Else 
					ALERT:C41("The "+Table name:C256(curTableNum)+" does not contain Phone records.")
					myOK:=0
			End case 
			If (myOK=1)
				CONFIRM:C162("Parse "+Table name:C256(curTableNum)+" Phone and FAX.")
				If (OK=1)
					$k:=Records in selection:C76($ptFile->)
					If ($k>0)
						FIRST RECORD:C50($ptFile->)
						For ($i; 1; $k)
							If (ptDestin->#"")
								ParsePhone(ptDestin->; ptDestin; <>tcLocalArea)
							End if 
							If (ptFax->#"")
								ParsePhone(ptFax->; ptFax; <>tcLocalArea)
							End if 
							SAVE RECORD:C53($ptFile->)
							UNLOAD RECORD:C212($ptFile->)
							NEXT RECORD:C51($ptFile->)
						End for 
					End if 
				End if 
			End if 
	End case 
Until (OK=0)