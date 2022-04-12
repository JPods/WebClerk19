//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 
If ([UserReport:46]scriptExecute:4)
	If ([UserReport:46]scriptBegin:5="")
		Path_Set(Storage:C1525.folder.jitSrchsF)
		QUERY:C277(Table:C252([UserReport:46]tableNum:3)->)
	Else 
		v1:=[UserReport:46]scriptBegin:5
		v2:=HFS_ParentName(v1)
		//If (SetDefaultPath(v1)=0)
		//ALERT("Load Search Pattern: '"+v2+"'.")
		//Else 
		//BEEP
		//End if 
		//v1:=""
		//v2:=""
		QUERY:C277(Table:C252([UserReport:46]tableNum:3)->)
		CLOSE WINDOW:C154
	End if 
End if 