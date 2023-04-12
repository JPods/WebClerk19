Case of 
	: (Form event code:C388=On Data Change:K2:15)
		Form:C1466.demo_lb.setEntry(lbEntity)
		
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.demo_lb.setEntry(lbEntity)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		Form:C1466.demo_lb.setEntry(lbEntity)
		
		If (Form:C1466.demo_lb.cur#Null:C1517)
			$obPassable:=New object:C1471("dataClassName"; Form:C1466.demo_lb.dataClassName; \
				"form"; ""; "tableForm"; \
				Form:C1466.demo_lb.dataClassName+"_InputDS"; \
				"id"; Form:C1466.demo_lb.cur.id; \
				"page"; aPages; \
				"parentProcess"; Current process:C322)
			$viProcess:=New process:C317("Process_ByID"; 0; Form:C1466.demo_lb.dataClassName+" - "+String:C10(Count tasks:C335); $obPassable)
			
		End if 
		
End case 