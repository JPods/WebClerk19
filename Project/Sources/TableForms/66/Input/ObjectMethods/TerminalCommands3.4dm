C_TEXT:C284($pathCerts; $pathacme; $zerossl)

Case of 
	: (Form event code:C388=On Load:K2:1)
		READ ONLY:C145([Contact:13])
		ARRAY TEXT:C222(ailoText17; 0)
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[WorkOrder:66]customerid:28)
		C_LONGINT:C283($incRec; $cntRec)
		$cntRec:=Records in selection:C76([Contact:13])
		FIRST RECORD:C50([Contact:13])
		For ($incRec; 1; $cntRec)
			APPEND TO ARRAY:C911(ailoText17; [Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4+": id,"+String:C10([Contact:13]idNum:28))
			NEXT RECORD:C51([Contact:13])
		End for 
		
		INSERT IN ARRAY:C227(ailoText17; 1; 1)
		ailoText17{1}:="Contacts List"
		READ WRITE:C146([Contact:13])
		REDUCE SELECTION:C351([Contact:13]; 0)
		ailoText17:=1
		
	: (ailoText17>1)  //Field List    
		READ ONLY:C145([Contact:13])
		C_LONGINT:C283($p)
		C_TEXT:C284($strUniqueID)
		$p:=Position:C15(": id,"; ailoText17{ailoText17})
		$strUniqueID:=Substring:C12(ailoText17{ailoText17}; $p+5)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11($strUniqueID))
End case 