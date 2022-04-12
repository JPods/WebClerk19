//%attributes = {"publishedWeb":true}
//Procedure: EDI_OrdLnAdd
//assumes a current record in [Item]

allowAlerts_boo:=False:C215
listItemsFill(->[Order:3]; False:C215)
allowAlerts_boo:=True:C214
UNLOAD RECORD:C212([Item:4])