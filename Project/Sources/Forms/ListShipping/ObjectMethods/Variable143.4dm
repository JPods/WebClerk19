CREATE RECORD:C68([Contact:13])


[Contact:13]nameLast:4:=[Order:3]attention:44
process_o.entry_o.nameLast:=Parse_UnWanted(process_o.entry_o.nameLast)
Contact_FillRec(->[Order:3]shipVia:13; ->[Order:3]company:15; ->[Order:3]address1:16; ->[Order:3]address2:17; ->[Order:3]city:18; ->[Order:3]state:19; ->[Order:3]zip:20; ->[Order:3]country:21; ->[Order:3]taxJuris:43; ->[Order:3]zone:14; ->[Customer:2]customerID:1; ->[Contact:13]nameFirst:2; ->[Contact:13]nameLast:4; ->iLoText1)
SAVE RECORD:C53([Contact:13])
[Order:3]contactShipTo:78:=[Contact:13]idNum:28

UNLOAD RECORD:C212([Contact:13])
QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)