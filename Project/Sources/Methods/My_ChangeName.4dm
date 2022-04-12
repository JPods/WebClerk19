//%attributes = {"publishedWeb":true}
//Method: My_ChangeName
$theFolder:=Select folder:C670("Save TechNotes to HTML")
If (OK=1)
	ALL RECORDS:C47([TechNote:58])
	C_LONGINT:C283($i; $k; $subk; $subi; $changeCnt)
	C_LONGINT:C283(offArea)
	$k:=Records in selection:C76([TechNote:58])
	FIRST RECORD:C50([TechNote:58])
	For ($i; 1; $k)
		//offArea:=  //**WR New offscreen area 
		//**WR PICTURE TO AREA (offArea;[TechNote]Body_)
		//**WR EXECUTE COMMAND (Area;104)
		//**WR DELETE OFFSCREEN AREA (offArea)
		//SAVE RECORD([TechNote])
		NEXT RECORD:C51([TechNote:58])
	End for 
End if 

//script
CONFIRM:C162("Clone current orders")
If (OK=1)
	C_LONGINT:C283(vi2; vi1)
	vi2:=Num:C11(Request:C163("Enter number to clone."; "100"))
	For (vi1; 1; vi2)
		Clone_Order
		vMod:=True:C214
		acceptOrders
	End for 
End if 