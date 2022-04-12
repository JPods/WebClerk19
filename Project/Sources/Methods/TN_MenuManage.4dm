//%attributes = {"publishedWeb":true}
//TN_MenuManage
TRACE:C157
If (False:C215)
	C_LONGINT:C283($1; $2; $3)  //body, cmdNum; ModKey
	Case of 
		: ((($2=103) | ($2=104)) & (ptCurTable=(->[TechNote:58])))
			//*[TechNote]Body_:=  //**WR Area to picture (Body)
			SAVE RECORD:C53([TechNote:58])
		: (($2=111) | ($2=112))
			If (ptCurTable=(->[TechNote:58]))
				TN_PrintOne
			Else 
				TN_PrintRayList(Num:C11($3=2048))
			End if 
		: ($2=9803)
			TN_Style01Title($1)
		: ($2=9804)
			TN_Style02Key($1)
		: ($2=9805)
			TN_Style1($1)
		: ($2=9806)
			TN_Style2($1)
		: ($2=9807)
			TN_Style3($1)
		: ($2=9808)
			TN_Style4($1)
		: ($2=9809)
			TN_Style5($1)
		Else 
			////**WR ON COMMAND ($1;$2)
	End case 
End if 