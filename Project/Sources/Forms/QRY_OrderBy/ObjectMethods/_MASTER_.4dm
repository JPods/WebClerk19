$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		APPEND TO ARRAY:C911(Self:C308->;"Master Table")
		APPEND TO ARRAY:C911(Self:C308->;"Object Properties")
		APPEND TO ARRAY:C911(Self:C308->;"Related Tables")
		Self:C308->:=1
		
	Else 
		Form:C1466.plistChoice:=Self:C308->
		Form:C1466.propertyList:=QRY_RedrawList (Form:C1466.propertyListOriginal;Form:C1466.plistChoice)
End case 