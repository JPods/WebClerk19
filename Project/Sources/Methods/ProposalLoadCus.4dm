//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-28T06:00:00Z)
// Method: ProposalLoadCus
// Description 
// Parameters
// ----------------------------------------------------


[Proposal:42]action:96:=[Customer:2]action:60
[Proposal:42]actionBy:94:=[Customer:2]actionBy:139
[Proposal:42]actionDate:95:=[Customer:2]actionDate:61
[Proposal:42]actionTime:58:=[Customer:2]actionTime:71

[Proposal:42]bill2Company:57:=[Customer:2]company:2
[Proposal:42]customerID:1:=[Customer:2]customerID:1
[Proposal:42]typeSale:20:=[Customer:2]typeSale:18  //ititialize values  
[Proposal:42]sector:88:=[Customer:2]sector:124  //ititialize values       
[Proposal:42]repID:7:=[Customer:2]repID:58
[Proposal:42]salesNameID:9:=[Customer:2]salesNameID:59
vComRep:=CM_FindRate(->[Proposal:42]repID:7; -><>aReps; -><>aRepRate)
vComSales:=CM_FindRate(->[Proposal:42]salesNameID:9; -><>aComNameID; -><>aEmpRate)
[Proposal:42]status:2:="Open"
[Proposal:42]complete:56:=False:C215
[Proposal:42]contactBillTo:73:=[Customer:2]contactBillTo:92
[Proposal:42]contactShipTo:63:=[Customer:2]contactShipTo:93
[Proposal:42]shipPartial:82:=[Customer:2]shipPartial:109
[Proposal:42]taxExemptid:83:=[Customer:2]taxExemptid:56

C_LONGINT:C283($w)
$w:=Find in array:C230(aContactsUniqueID; [Proposal:42]contactShipTo:63)
If (($w>0) & ([Proposal:42]contactShipTo:63>0))
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactsUniqueID{$w})  //;shipToMe)  
	[Proposal:42]shipVia:18:=[Contact:13]shipVia:26
	//Proposal_FillAddress("Contact")
	[Proposal:42]attention:37:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
	[Proposal:42]zone:19:=[Contact:13]zone:27
	[Proposal:42]taxJuris:33:=[Contact:13]taxJuris:24
	[Proposal:42]contactShipTo:63:=[Contact:13]idNum:28
	If ([Contact:13]phone:30="")
		[Proposal:42]phone:24:=[Customer:2]phone:13
	Else 
		[Proposal:42]phone:24:=[Contact:13]phone:30
	End if 
	If ([Contact:13]fax:31="")
		[Proposal:42]fax:67:=[Customer:2]fax:66
	Else 
		[Proposal:42]fax:67:=[Contact:13]fax:31
	End if 
	If ([Contact:13]email:35="")
		[Proposal:42]email:68:=[Customer:2]email:81
	Else 
		[Proposal:42]email:68:=[Contact:13]email:35
	End if 
Else 
	If (<>vbEmptyShip2)
		[Proposal:42]company:11:="NoPrimeShip2"
		[Proposal:42]company:11:=""
		[Proposal:42]address1:12:=""
		[Proposal:42]address2:13:=""
		[Proposal:42]city:14:=""
		[Proposal:42]state:15:=""
		[Proposal:42]zip:16:=""
		[Proposal:42]country:17:=""
		[Proposal:42]zone:19:=-1
		[Proposal:42]attention:37:=""
	Else 
		[Proposal:42]shipVia:18:=[Customer:2]shipVia:12
		//Proposal_FillAddress("Customer")
		
		[Proposal:42]zone:19:=[Customer:2]zone:57
		[Proposal:42]attention:37:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
	End if 
	[Proposal:42]shipVia:18:=[Customer:2]shipVia:12
	[Proposal:42]taxJuris:33:=[Customer:2]taxJuris:65
	[Proposal:42]phone:24:=[Customer:2]phone:13
	[Proposal:42]fax:67:=[Customer:2]fax:66
	[Proposal:42]email:68:=[Customer:2]email:81
End if 
[Proposal:42]phone:24:=[Customer:2]phone:13
[Proposal:42]terms:21:=[Customer:2]terms:33
[Proposal:42]adSource:47:=[Customer:2]adSource:62
[Proposal:42]dateDocument:3:=Current date:C33
[Proposal:42]shipAdjustments:28:=0
[Proposal:42]fob:34:=Storage:C1525.default.fob
<>aLastRecNum{2}:=Record number:C243([Customer:2])
//TRACE
vMod:=calcProposal(True:C214)
[Proposal:42]total:32:=Round:C94([Proposal:42]amount:26+[Proposal:42]salesTax:27+[Proposal:42]shipTotal:31; <>tcDecimalTt)
//
[Proposal:42]dateNeeded:4:=Current date:C33+<>tcNeedDelay
CLEAR VARIABLE:C89(vi4)
CLEAR VARIABLE:C89(vdDateBeg)
If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
	DscntSetPrice([Proposal:42]typeSale:20; [Proposal:42]dateNeeded:4)
Else 
	DscntSpecialClr([Proposal:42]typeSale:20)
End if 
//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->srPhone; ->[Proposal]phone)