var dropDocument_t; $fgColor_t; $bgColor_t; $atlBgColor_t : Text
Case of 
	: (Form event code:C388=On Load:K2:1)
		dropDocument_t:="Drop Here"
		
		OBJECT GET RGB COLORS:C1074(*; "dropDocument_t"; $fgColor_t; $bgColor_t; $atlBgColor_t)
		//: (Form event code=On Clicked)
		
	: (Form event code:C388=On Drag Over:K2:13)
		OBJECT SET RGB COLORS:C628(*; "myVar"; Green:K11:9; Blue:K11:7)
		dropDocument_t:="Drop Here"
		//EXECUTE METHOD IN SUBFORM("SF_Document"; "SFEX_DropDocument"; *; $query_o)
	: (Form event code:C388=On Drop:K2:12)
		If (aPages=7)
			SFEX_DropDocument
		End if 
		//EXECUTE METHOD IN SUBFORM("SF_Document"; "SFEX_GetDocument"; *; $query_o)
		
End case 

