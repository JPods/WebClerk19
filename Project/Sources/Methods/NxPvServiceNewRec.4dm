//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/27/09, 03:25:23
// ----------------------------------------------------
// Method: NxPvServiceNewRec
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $tableNum)
$tableNum:=$1
If ([Service:6]idNum:26=0)
	
End if 
[Service:6]dtComplete:18:=0
If ([Service:6]actionBy:12="")
	[Service:6]actionBy:12:=Current user:C182
End if 
If ([Service:6]actionCreatedBy:40="")
	[Service:6]actionCreatedBy:40:=Current user:C182
End if 
ARRAY TEXT:C222(aContact; 0)
ARRAY TEXT:C222(aElectroZip; 0)
aContact{0}:=""
srVarLoad(0)
// DISABLE ITEM(2;1)//no cloning new records 
[Service:6]dtDocument:16:=DateTime_DTTo
[Service:6]dtBegin:15:=[Service:6]dtDocument:16  //ignor if not important
vt06Enter:=Current time:C178
vt06Begin:=vt06Enter
d06Enter:=Current date:C33
//[Service]DTEnd:=0
If (clickDate=!00-00-00!)
	//[Service]ActionDate:=Current date
	[Service:6]dtAction:35:=[Service:6]dtDocument:16
Else 
	d06Action:=clickDate
	vt06Action:=?12:00:00?
	[Service:6]dtAction:35:=DateTime_DTTo(clickDate; vt06Action)
	clickDate:=!00-00-00!
End if 
If (myCycle=4)
	If ([Item:4]dtItemDate:33=0)
		[Item:4]dtItemDate:33:=DateTime_DTTo(Date:C102([Item:4]profile2:36); ?00:00:00?)
		SAVE RECORD:C53([Item:4])
	End if 
	[Service:6]dtBegin:15:=[Item:4]dtItemDate:33  //ignor if not important  
	[Service:6]reference:37:=[Item:4]itemNum:1
	[Service:6]process:4:=[Item:4]profile1:35
	[Service:6]attribute:5:=[Item:4]profile2:36
	[Service:6]expenseDescription:43:=[Item:4]profile1:35
	[Service:6]docType:31:="pdf"
	Case of 
		: ([Item:4]type:26#"")
			[Service:6]docReference:32:="pdf"+Folder separator:K24:12+[Item:4]type:26+Folder separator:K24:12+[Item:4]itemNum:1+".pdf"
		: ([Item:4]profile1:35#"")
			[Service:6]docReference:32:="pdf"+Folder separator:K24:12+[Item:4]profile1:35+Folder separator:K24:12+[Item:4]itemNum:1+".pdf"
		Else 
			[Service:6]docReference:32:="pdf"+Folder separator:K24:12+"General"+Folder separator:K24:12+[Item:4]itemNum:1+".pdf"
	End case 
	[Service:6]description:50:=[Item:4]description:7
	[Service:6]noteType:21:=[Item:4]description:7
	[Service:6]activeSaleTrack:53:=True:C214
	[Service:6]customerID:1:=[Customer:2]customerID:1
	[Service:6]contactID:52:=[Contact:13]idNum:28
	[Service:6]company:48:=[Customer:2]company:2
	[Service:6]division:49:=[Customer:2]division:70
	If (Records in selection:C76([Contact:13])=1)
		[Service:6]attention:30:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
	Else 
		[Service:6]attention:30:=Substring:C12([Customer:2]company:2; 1; 25)
	End if 
End if 

Case of 
	: (myOK=10)  //###wdj###070628  Not completed  for adding service records
		If (Record number:C243([Customer:2])>-1)
			[Service:6]customerID:1:=[Customer:2]customerID:1
			[Service:6]repID:2:=[Customer:2]repID:58
		End if 
		If (Record number:C243([Customer:2])>-1)
			[Service:6]idNumOrder:22:=[Order:3]idNum:2
			[Service:6]customerID:1:=[Order:3]customerID:1
			[Service:6]repID:2:=[Order:3]repID:8
			[Service:6]idNumProject:28:=[Order:3]projectNum:50
		End if 
		If (Record number:C243([Customer:2])>-1)
			
		End if 
	: (vHere>2)
		Case of 
			: (myCycle=4)
			: ($tableNum<2)
				UNLOAD RECORD:C212([Customer:2])
			: ($1=Table:C252(->[Contact:13]))
				[Service:6]contactID:52:=[Contact:13]idNum:28
				[Service:6]address1:56:=[Contact:13]address1:6
				[Service:6]address2:57:=[Contact:13]address2:7
				[Service:6]attentionContact:55:=[Contact:13]nameLast:4+", "+[Contact:13]nameFirst:2
				[Service:6]city:58:=[Contact:13]city:8
				[Service:6]state:59:=[Contact:13]state:9
				[Service:6]zip:60:=[Contact:13]zip:11
				[Service:6]phoneCell:63:=[Contact:13]phoneCell:52
				[Service:6]phone:62:=[Contact:13]phone:30
				[Service:6]email:64:=[Contact:13]email:35
				[Service:6]country:61:=[Contact:13]country:12
			: ($1=Table:C252(->[Customer:2]))
				srVarLoad(2)
				[Service:6]customerID:1:=[Customer:2]customerID:1
				[Service:6]repID:2:=[Customer:2]repID:58
			: ($1=Table:C252(->[Order:3]))
				srVarLoad(2)
				[Service:6]idNumOrder:22:=[Order:3]idNum:2
				[Service:6]customerID:1:=[Order:3]customerID:1
				[Service:6]repID:2:=[Order:3]repID:8
				[Service:6]idNumProject:28:=[Order:3]projectNum:50
			: ($1=Table:C252(->[Rep:8]))
				[Service:6]repID:2:=[Rep:8]repID:1
			: ($1=Table:C252(->[Invoice:26]))
				srVarLoad(2)
				[Service:6]idNumInvoice:23:=[Invoice:26]idNum:2
				[Service:6]idNumOrder:22:=[Invoice:26]idNumOrder:1
				[Service:6]customerID:1:=[Invoice:26]customerID:3
				[Service:6]repID:2:=[Invoice:26]repID:22
				[Service:6]idNumProject:28:=[Invoice:26]idNumProject:50
			: (($1=Table:C252(->[Proposal:42])) | ($1=Table:C252(->[ProposalLine:43])))
				srVarLoad(2)
				[Service:6]idNumProposal:27:=[Proposal:42]idNum:5
				[Service:6]customerID:1:=[Proposal:42]customerID:1
				[Service:6]repID:2:=[Proposal:42]repID:7
				[Service:6]idNumProject:28:=[Proposal:42]idNumProject:22
			: (($1=Table:C252(->[PO:39])) | ($1=Table:C252(->[PO:39])))
				[Service:6]idNumProject:28:=[PO:39]idNumProject:6
			: ($1=Table:C252(->[Project:24]))
				srVarLoad(2)
				[Service:6]idNumProject:28:=[Project:24]idNum:1
				[Service:6]customerID:1:=[Project:24]customerID:4
				[Service:6]repID:2:=[Project:24]company:14
			Else 
				UNLOAD RECORD:C212([Customer:2])
				ARRAY TEXT:C222(aContact; 0)
				ARRAY TEXT:C222(aElectroZip; 0)
				aContact{0}:=""
				srVarLoad(0)
		End case 
		FontSrchLabels(1)
	Else 
		FontSrchLabels(1)
		jrelateClrFiles
		srVarLoad(0)
		ARRAY TEXT:C222(aContact; 0)
		ARRAY TEXT:C222(aElectroZip; 0)
		aContact{0}:=""
End case 