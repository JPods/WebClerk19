C_TEXT:C284($pathCerts; $pathacme; $zerossl)

Case of 
	: (Form event code:C388=On Load:K2:1)
		READ ONLY:C145([SyncRelation:103])
		ARRAY TEXT:C222(ailoText18; 0)
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]active:17=True:C214)
		C_LONGINT:C283($incRec; $cntRec)
		$cntRec:=Records in selection:C76([SyncRelation:103])
		FIRST RECORD:C50([SyncRelation:103])
		For ($incRec; 1; $cntRec)
			APPEND TO ARRAY:C911(ailoText18; [SyncRelation:103]name:8+": id,"+String:C10([SyncRelation:103]idNum:1))
			NEXT RECORD:C51([SyncRelation:103])
		End for 
		
		INSERT IN ARRAY:C227(ailoText18; 1; 1)
		ailoText18{1}:="SyncRelations"
		READ WRITE:C146([SyncRelation:103])
		REDUCE SELECTION:C351([SyncRelation:103]; 0)
		
		If ([WorkOrder:66]siteIDTo:61="")
			ailoText18:=1
		Else 
			C_LONGINT:C283($findRay)
			$findRay:=Find in array:C230(ailoText18; [WorkOrder:66]siteIDTo:61)
			If ($findRay>0)
				ailoText18:=$findRay
			Else 
				ailoText18:=1
			End if 
		End if 
		
	: (ailoText18>1)  //Field List    
		READ ONLY:C145([SyncRelation:103])
		C_LONGINT:C283($p)
		C_TEXT:C284($strUniqueID)
		$p:=Position:C15(": id,"; ailoText18{ailoText18})
		$strUniqueID:=Substring:C12(ailoText18{ailoText18}; $p+5)
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]idNum:1=Num:C11($strUniqueID))
		[WorkOrder:66]siteIDTo:61:=[SyncRelation:103]name:8
		SAVE RECORD:C53([WorkOrder:66])
End case 