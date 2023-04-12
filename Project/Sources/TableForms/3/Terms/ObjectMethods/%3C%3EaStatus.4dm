TRACE:C157
process_o.entry_o.status:=DE_PopUpArray(Self:C308)

// ### jwm ### 20180504_1426 link status to iloScript
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=[Order:3]status:59; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]purpose:3="iLoScripts"; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]tableNum:1=3; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
QUERY:C277([TallyMaster:60])

If (Records in selection:C76([TallyMaster:60])=1)
	ExecuteText(0; [TallyMaster:60]script:9)
End if 

UNLOAD RECORD:C212([TallyMaster:60])

If (([Order:3]idNum:2#0) & ([Order:3]status:59#Old:C35([Order:3]status:59)))
	
	If (([Order:3]status:59="Completed") | ([Order:3]status:59="Canceled"))
		[Order:3]dtProdCompl:57:=DateTime_DTTo
		complTime:=Current time:C178
		complDate:=Current date:C33
	Else 
		[Order:3]dtProdCompl:57:=0
		complTime:=?00:00:00?
		complDate:=!00-00-00!
	End if 
End if 

// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]status:59)


