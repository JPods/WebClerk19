C_LONGINT:C283($formEvent)

C_TEXT:C284(vDomain; vUsername; vPassword; vDataToSend; vRecsUnique)
C_LONGINT:C283(vUniqueID; vPort)
ARRAY TEXT:C222(aIncomingFields; 0)
ARRAY TEXT:C222(aExistingFields; 0)  //vConnectionStatus
ARRAY TEXT:C222(aTableFields; 0)

ARRAY LONGINT:C221(aTableFieldsColors; 0)

$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		C_TEXT:C284(HTTP_URL; HTTP_Protocol; HTTP_Host; HTTP_Path)
		C_LONGINT:C283(HTTP_Port; HTTP_TimeOut)
		vDataToSend:=""  //Prepare "+Table name(Table(ptCurTable))+": "+String(Records in selection(ptCurTable->))
		vWCPayload:=""
		vDataReceived:=""
		C_LONGINT:C283(bShowData)
		bShowData:=0
		WC_InitRequest
		WC_ServerInit
		viSelectedRecNum:=-1
		OBJECT SET ENABLED:C1123(B31; (viSelectedRecNum>-1))
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]active:17=True:C214)
		FIRST RECORD:C50([SyncRelation:103])
		//  CHOPPED  AL_UpdateFields(eSyncSelection; 2)
		
		REDUCE SELECTION:C351([SyncRecord:109]; 0)
		
		
		//: ($formEvent=On Mouse Enter)
		
End case 

