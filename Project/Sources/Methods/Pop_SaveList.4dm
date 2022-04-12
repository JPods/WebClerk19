//%attributes = {"publishedWeb":true}
//Procedure: Pop_SaveList
QUERY:C277([PopUp:23]; [PopUp:23]listName:4=vDiaCom)
LOAD RECORD:C52([PopUp:23])
Case of 
	: (Locked:C147([PopUp:23]))
		jAlertMessage(10011)
	: (Records in selection:C76([PopUp:23])=1)
		QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=[PopUp:23]arrayName:3)
		DELETE SELECTION:C66([PopupChoice:134])
		For ($i; 1; Size of array:C274(a1Text))
			CREATE RECORD:C68([PopupChoice:134])
			//notation for a passed parameter, refered by number
			[PopupChoice:134]arrayName:1:=[PopUp:23]arrayName:3
			[PopupChoice:134]choice:3:=a1Text{$i}  //notation for a passed parameter, refered by number
			SAVE RECORD:C53([PopupChoice:134])
		End for 
		SAVE RECORD:C53([PopUp:23])
		vModPop:=True:C214
	: (Records in selection:C76([PopUp:23])>1)
		UNLOAD RECORD:C212([PopUp:23])
		ALERT:C41("There is more than one Popup record with this name.")
	Else 
		ALERT:C41("There is no Popup record with this name.")
End case 
UNLOAD RECORD:C212([PopUp:23])
UNLOAD RECORD:C212([PopupChoice:134])
OBJECT SET ENABLED:C1123(b21; False:C215)
changePop:=1