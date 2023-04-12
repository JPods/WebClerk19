C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)

If ($formEvent=On Close Box:K2:21)  // ### jwm ### 20181211_1052
	jCancelButton
End if 

$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([RemoteUser:57]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[RemoteUser:57])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		jDateTimeRecov([RemoteUser:57]dtLastVisit:5; ->vDate1; ->vTime1)
		jDateTimeRecov([RemoteUser:57]dtCreated:8; ->vDate2; ->vTime2)
		srDisplayEmail:=[RemoteUser:57]email:14
		vMod:=False:C215
		vdDateBeg:=Current date:C33-30
		vdDateEnd:=Current date:C33
		C_LONGINT:C283(viPasswordView)
		$doChange:=UserInPassWordGroup("RemoteUserPassword")
		If ($doChange)
			viPasswordView:=1
			iLoText1:=[RemoteUser:57]userPassword:3
		Else 
			iLoText1:="*"*Length:C16([RemoteUser:57]userPassword:3)
			viPasswordView:=-1
		End if 
		vi1:=0
		Case of 
			: (([RemoteUser:57]tableNum:9=2) | ([RemoteUser:57]tableNum:9=(Table:C252(->[ManufacturerTerm:111]))))
				If ([RemoteUser:57]tableNum:9=2)
					vText4:="Customer"
				Else 
					vText4:="Manufacturer"
				End if 
				READ ONLY:C145([Customer:2])
				//QUERY([Customer];[Customer]customerID=[RemoteUser]customerID)
				//SerFillCustDtl
				vText5:=[Customer:2]adSource:62
				vText6:=[Customer:2]salesNameID:59
				vText3:=[Customer:2]webPage:94
				vTextServ:=[Customer:2]comment:15
				READ WRITE:C146([Customer:2])
				If ([RemoteUser:57]company:16#[Customer:2]company:2)
					[RemoteUser:57]company:16:=[Customer:2]company:2
					SAVE RECORD:C53([RemoteUser:57])
				End if 
			: ([RemoteUser:57]tableNum:9=48)
				vText4:="Lead"
				READ ONLY:C145([Lead:48])
				//QUERY([Lead];[Lead]UniqueID=Num([RemoteUser]customerID))
				//SerFillLeadDtl
				vText5:=[Lead:48]adSource:27
				vText6:=[Lead:48]salesNameID:13
				vTextServ:=[Lead:48]comment:24
				vText3:=[Lead:48]webPage:47
				READ WRITE:C146([Lead:48])
				If ([RemoteUser:57]company:16#[Lead:48]company:5)
					[RemoteUser:57]company:16:=[Lead:48]company:5
					SAVE RECORD:C53([RemoteUser:57])
				End if 
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))
				vText4:="Rep"
				READ ONLY:C145([Rep:8])
				//QUERY([Rep];[Rep]RepID=[RemoteUser]customerID)
				//SerFillRepDtl
				vTextServ:=[Rep:8]comment:19
				READ WRITE:C146([Rep:8])
				If ([RemoteUser:57]company:16#[Rep:8]company:2)
					[RemoteUser:57]company:16:=[Rep:8]company:2
					SAVE RECORD:C53([RemoteUser:57])
				End if 
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
				vText4:="Contact"
				READ ONLY:C145([Contact:13])
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([RemoteUser:57]customerID:10))
				//SerFillContDtl
				vText5:=[Contact:13]adSource:44
				vText6:=[Contact:13]salesNameID:39
				vText3:=[Contact:13]webPage:47
				vTextServ:=[Contact:13]comment:29
				READ WRITE:C146([Contact:13])
				If ([RemoteUser:57]company:16#[Contact:13]company:23)
					[RemoteUser:57]company:16:=[Contact:13]company:23
					SAVE RECORD:C53([RemoteUser:57])
				End if 
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Employee:19]))
				vText4:="Employee"
				READ ONLY:C145([Employee:19])
				QUERY:C277([Employee:19]; [Employee:19]nameID:1=[RemoteUser:57]customerID:10)
				//SerFillEmplDtl
				vText5:=""
				vText6:=""
				vText3:=[Employee:19]webPage:43
				vTextServ:=""
				READ WRITE:C146([Employee:19])
			Else 
				v1:=""
				v2:=""
				v3:=""
				v4:=""
				v5:=""
				v6:=""
				v7:=""
				v8:=""
				v9:=""
				v10:=""
				v11:=""
				v12:=""
				v13:=""
				vAction:=""
				v1Date:=!00-00-00!
				v1Time:=?00:00:00?
				vTextServ:=""
				vText1:=""
				vText3:=""
				vText5:=""
				vText6:=""
		End case 
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=([RemoteUser:57]userName:2#"")
End if 

