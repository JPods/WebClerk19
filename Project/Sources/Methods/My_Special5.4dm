//%attributes = {}
TRACE:C157
QUERY:C277([Item:4]; [Item:4]imagePath:104="@catalog@")
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
vText1:="https://www.webclerk.net/hearth/"
For (vi1; 1; vi2)
	vi7:=0
	[Item:4]imagePath:104:=Replace string:C233([Item:4]imagePath:104; "\\"; "/")
	vi6:=Position:C15("catalog"; [Item:4]imagePath:104)
	If (vi6>0)
		vText2:=Substring:C12([Item:4]imagePath:104; vi6)
		[Item:4]imagePath:104:=vText1+vText2
		SAVE RECORD:C53([Item:4])
	End if 
	NEXT RECORD:C51([Item:4])
End for 
ALERT:C41("Complete")

// "C:\Users\use\OneDrive\Documents\CommerceExpert\catalog\hearthston\Wood Inserts\8470.jpg"
//vText11:="C:\Users\use\OneDrive\Documents\CommerceExpert\catalog\hearthston\Wood Inserts\8470.jpg"


TRACE:C157





// DataMemory
ALL RECORDS:C47([CarrierWeight:144])
ORDER BY:C49([CarrierWeight:144]; [CarrierWeight:144]carrierid:14)
vi2:=Records in selection:C76([CarrierWeight:144])
FIRST RECORD:C50([CarrierWeight:144])
For (vi1; 1; vi2)
	If ([Carrier:11]carrierid:10#[CarrierWeight:144]carrierid:14)
		QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[CarrierWeight:144]carrierid:14)
	End if 
	[CarrierWeight:144]idNumCarrier:13:=[Carrier:11]idNum:44
	SAVE RECORD:C53([CarrierWeight:144])
	NEXT RECORD:C51([CarrierWeight:144])
End for 
UNLOAD RECORD:C212([CarrierWeight:144])

ALL RECORDS:C47([CarrierZone:143])
ORDER BY:C49([CarrierZone:143]; [CarrierZone:143]carrierid:7)
vi2:=Records in selection:C76([CarrierZone:143])
FIRST RECORD:C50([CarrierZone:143])
For (vi1; 1; vi2)
	If ([Carrier:11]carrierid:10#[CarrierZone:143]carrierid:7)
		QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[CarrierZone:143]carrierid:7)
	End if 
	[CarrierZone:143]idNumCarrier:6:=[Carrier:11]idNum:44
	SAVE RECORD:C53([CarrierZone:143])
	NEXT RECORD:C51([CarrierZone:143])
End for 
UNLOAD RECORD:C212([CarrierZone:143])

If (False:C215)
	
	For (vi1; 1; Get last table number:C254)
		// ThermoInitExit ("Loading records";20000;True)
		vi9:=0
		OK:=1
		
		If (OK=1)
			vText9:=Storage:C1525.folder.jitF+"zzzME_"+String:C10(vi1; "000")+Table name:C256(vi1)+".mdd"
			If (HFS_Exists(vText9)=1)
				READ WRITE:C146(Table:C252(vi1)->)
				ALL RECORDS:C47(Table:C252(vi1)->)
				DELETE SELECTION:C66(Table:C252(vi1)->)
				SET CHANNEL:C77(10; vText9)
				MESSAGE:C88("Importing Table: "+vText9)
				If (OK=1)
					Repeat 
						vi9:=vi9+1
						//  CREATE RECORD(Table(vi1)->) // no longer needed
						RECEIVE RECORD:C79(Table:C252(vi1)->)
						If (OK=1)
							iLoBoolean1:=IEA_UniqueByTables(Table:C252(vi1))
							If (iLoBoolean1)
								SAVE RECORD:C53(Table:C252(vi1)->)
							End if 
						End if 
					Until (OK=0)
					SET CHANNEL:C77(11)
				End if 
			End if 
		End if 
	End for 
	
End if 



