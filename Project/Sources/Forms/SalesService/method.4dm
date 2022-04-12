Case of 
	: (Form event code:C388=On Load:K2:1)  //((Before)||(booPreNext)
		SET MENU BAR:C67(1)
		process_o.cur:=New object:C1471
		process_o.old:=Null:C1517
		If (process_o.date.begin=Null:C1517)
			process_o.date:=New object:C1471("begin"; Current date:C33-3; "end"; Current date:C33+1)
		End if 
		vdDateBeg:=process_o.date.begin
		vdDateEnd:=process_o.date.end
		process_o.title:="Sales and Service"
		
		
		//New object("frm"; New object("sfSales"; 
		//New object(
		//QQQ why is this different
		
		
		process_o.sf:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"entsOther"; New object:C1471("tableName"; New object:C1471))
		Form:C1466.detail:=New object:C1471("up"; Form:C1466)
		
		
		SET WINDOW TITLE:C213(process_o.title)
		
		C_LONGINT:C283($w)
		$w:=Find in array:C230(<>aNameID; Current user:C182)
		If ($w>0)
			<>aNameID:=$w
			$vtUserName:=<>aNameID{$w}
		Else 
			<>aNameID:=1
		End if 
		Cal_SearchMySales($vtUserName)
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		
		
		
End case 