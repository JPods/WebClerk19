//%attributes = {"publishedWeb":true}
//Method: Srv_CommentAvailable
//Object Method: aSrvComments
C_LONGINT:C283($doRed)
TRACE:C157
$doRed:=0
vbLocked_02:=0
vbLocked_06:=0
vbLocked_13:=0
Case of 
	: (aSrvComments=1)  //customer
		If (Record number:C243([Customer:2])<0)
			vSrvComment:="No Customer Selected"
			$doRed:=1
			vbLocked_02:=1
		Else 
			vSrvComment:=[Customer:2]comment:15
			If (Locked:C147([Customer:2]))
				vSrvComment:="Customer Record LOCKED"+"\r"+vSrvComment
				$doRed:=2
				vbLocked_02:=1
			End if 
		End if 
	: (aSrvComments=2)  //contact
		If (Record number:C243([Contact:13])<0)
			vSrvComment:="No Contact Selected"
			$doRed:=1
			vbLocked_13:=1
		Else 
			vSrvComment:=[Contact:13]comment:29
			If (Locked:C147([Contact:13]))
				vSrvComment:="Contact Record LOCKED"+"\r"+vSrvComment
				$doRed:=2
				vbLocked_13:=1
			End if 
		End if 
	: (aSrvComments=3)  //service
		If (Record number:C243([Service:6])<0)
			vSrvComment:="No Service Record"
			$doRed:=1
			vbLocked_06:=1
		Else 
			vSrvComment:=[Service:6]comment:11
			If (Locked:C147([Service:6]))
				vSrvComment:="Service Record LOCKED"+"\r"+vSrvComment
				$doRed:=2
				vbLocked_06:=1
			End if 
		End if 
	: (aSrvComments=4)
		If (Record number:C243([ItemSpec:31])<0)
			vSrvComment:="No Item Spec"
			$doRed:=1
		Else 
			vSrvComment:=[ItemSpec:31]specification:2
			If (Locked:C147([ItemSpec:31]))
				$doRed:=2
			End if 
		End if 
End case 
//TRACE
Case of 
	: ($doRed=2)
		OBJECT SET RGB COLORS:C628(vSrvComment; 0x0000; 0x00CCCCCC)
		//SET COLOR(vSrvComment;-(15+(256*7)))
	: ($doRed=1)
		//SET COLOR(vSrvComment;-(15+(256*1)))
		OBJECT SET RGB COLORS:C628(vSrvComment; 0x0000; 0x00CCCCCC)
	Else 
		//SET COLOR(vSrvComment;-(15+(256*0)))
		OBJECT SET RGB COLORS:C628(vSrvComment; 0x0000; 0x00FFFFFF)
End case 
Locked_CheckBoxes(->[Customer:2])
Locked_CheckBoxes(->[Service:6])
Locked_CheckBoxes(->[Contact:13])