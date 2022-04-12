//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/18, 00:36:48
// ----------------------------------------------------
// Method: Ltr_MakeServRec (ptPrintTable)
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptPrintTable)
$ptPrintTable:=$1
If ((ltrSave+bServRec)>0)
	C_BOOLEAN:C305($doPop)
	Case of 
		: (($ptPrintTable=(->[Service:6])) | ($ptPrintTable=(->[Order:3])) | ($ptPrintTable=(->[Invoice:26])) | ($ptPrintTable=(->[Proposal:42])))
			If ($ptPrintTable=(->[Service:6]))
				PUSH RECORD:C176([Service:6])
				$doPop:=True:C214
			End if 
			CREATE RECORD:C68([Service:6])
			
			[Service:6]dtDocument:16:=DateTime_Enter
			[Service:6]dtBegin:15:=DateTime_Enter
			[Service:6]dtEnd:38:=DateTime_Enter
			[Service:6]dtAction:35:=DateTime_Enter
			//[Service]DTCompleted:=0
			// [Service]DateCompleted:=Current date
			// [Service]ActionDate:=Current date
			[Service:6]noteType:21:="Letter"
			[Service:6]complete:17:=True:C214
			[Service:6]actionBy:12:=Current user:C182
			[Service:6]action:20:=[Letter:20]name:1
			[Service:6]customerID:1:=[Customer:2]customerID:1
			[Service:6]actionBy:12:=Current user:C182
			Case of 
				: ($ptPrintTable=(->[RepContact:10]))
					[Service:6]attention:30:=[RepContact:10]nameFirst:3+" "+[RepContact:10]nameLast:5
					[Service:6]repID:2:=[Rep:8]RepID:1
				: ($ptPrintTable=(->[Rep:8]))
					[Service:6]attention:30:=[Rep:8]division:3
					[Service:6]repID:2:=[Rep:8]RepID:1
				: ($ptPrintTable=(->[Order:3]))
					[Service:6]attention:30:=[Order:3]attention:44
					[Service:6]idNumOrder:22:=[Order:3]idNum:2
				: ($ptPrintTable=(->[Invoice:26]))
					[Service:6]attention:30:=[Invoice:26]attention:38
					[Service:6]idNumOrder:22:=[Invoice:26]idNumOrder:1
					[Service:6]idNumInvoice:23:=[Invoice:26]idNum:2
				: ($ptPrintTable=(->[Proposal:42]))
					[Service:6]attention:30:=[Proposal:42]attention:37
					[Service:6]idNumProposal:27:=[Proposal:42]idNum:5
			End case 
			If (ltrSave=1)
				TRACE:C157
				[Service:6]docType:31:="***"
				[Service:6]docReference:32:="Store internally as 4DWrite Doc"
				// zzzqqq jDateTimeStamp(->[Service:6]comment:11)
				[Service:6]comment:11:=[Service:6]comment:11+[Letter:20]name:1+" Letter printed"
				C_PICTURE:C286($tempPict)
				C_LONGINT:C283($tempArea)
				//$tempPict:=  //**WR Area to picture (eLetterArea)
				// $tempArea:=//**WR O Picture to offscreen are ($tempPict)
				//**WR PICTURE TO AREA ($tempArea;$tempPict)
				//**WR EXECUTE COMMAND ($tempArea;208)  //Select all
				//**WR EXECUTE COMMAND ($tempArea;713)  //Freeze values
				//[Service]LetterPict:=  //**WR O Save to picture ($tempArea)
				//**WR DELETE OFFSCREEN AREA ($tempArea)
			End if 
			SAVE RECORD:C53([Service:6])
			If ($doPop)
				POP RECORD:C177([Service:6])
			End if 
		: (($ptPrintTable=(->[Contact:13])) | ($ptPrintTable=(->[zzzLead:48])) | ($ptPrintTable=(->[Customer:2])) | ($ptPrintTable=(->[CallReport:34])))
			If ($ptPrintTable=(->[CallReport:34]))
				C_LONGINT:C283($vTableNum)
				C_TEXT:C284($theAcct)
				C_TEXT:C284($theWho)
				$vTableNum:=[CallReport:34]tableNum:2
				$theAcct:=[CallReport:34]customerID:1
				$theWho:=[CallReport:34]attention:18
				PUSH RECORD:C176([CallReport:34])
				$doPop:=True:C214
			End if 
			CREATE RECORD:C68([CallReport:34])
			
			[CallReport:34]dtAction:4:=DateTime_Enter
			[CallReport:34]dateDocument:17:=Current date:C33
			[CallReport:34]emailMessage:10:=True:C214
			[CallReport:34]letter:9:=True:C214
			If ([Letter:20]printApplication:4="FAX")
				[CallReport:34]action:15:="FAX Letter Out"
			Else 
				[CallReport:34]action:15:="Letter Out"
			End if 
			[CallReport:34]durationPlanned:5:=2
			[CallReport:34]subject:14:=[Letter:20]name:1
			[CallReport:34]customerID:1:=[Customer:2]customerID:1
			[CallReport:34]actionBy:3:=Current user:C182
			Case of 
				: ($ptPrintTable=(->[Contact:13]))
					[CallReport:34]customerID:1:=String:C10([Contact:13]idNum:28)
					[CallReport:34]tableNum:2:=13
					[CallReport:34]attention:18:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
				: ($ptPrintTable=(->[zzzLead:48]))
					[CallReport:34]customerID:1:=String:C10([zzzLead:48]idNum:32)
					[CallReport:34]tableNum:2:=48
					[CallReport:34]attention:18:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
				: ($ptPrintTable=(->[Customer:2]))
					[CallReport:34]tableNum:2:=2
					[CallReport:34]customerID:1:=[Customer:2]customerID:1
					[CallReport:34]attention:18:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
				: ($ptPrintTable=(->[CallReport:34]))
					[CallReport:34]tableNum:2:=$vTableNum
					[CallReport:34]customerID:1:=$theAcct
					[CallReport:34]attention:18:=$theWho
			End case 
			If (ltrSave=1)
				TRACE:C157
				[CallReport:34]feedbackTags:19:="***"
				[CallReport:34]keyTags:20:="Store internally as 4DWrite Doc"
				C_PICTURE:C286($tempPict)
				C_LONGINT:C283($tempArea)
				//$tempPict:=  //**WR Area to picture (eLetterArea)
				// $tempArea:=//**WR O Picture to offscreen are ($tempPict)
				//**WR PICTURE TO AREA ($tempArea;$tempPict)
				//**WR EXECUTE COMMAND ($tempArea;208)  //Select all
				//**WR EXECUTE COMMAND ($tempArea;713)  //Freeze values
				//[CallReport]LetterPict:=  //**WR O Save to picture ($tempArea)
				//**WR DELETE OFFSCREEN AREA ($tempArea)
			End if 
			SAVE RECORD:C53([CallReport:34])
			If ($doPop)
				POP RECORD:C177([CallReport:34])
			End if 
	End case 
End if 