//%attributes = {"publishedWeb":true}
//Method: Sync_OpenIn
//
C_TEXT:C284($1)
C_LONGINT:C283(cntRecs; dtSession)
//If (False)
OK:=0
If (Count parameters:C259=0)
	CONFIRM:C162("Receive remote records?")
	If (OK=1)
		SET CHANNEL:C77(10; "")
	End if 
Else 
	SET CHANNEL:C77(10; $1)
End if 
If (OK=1)
	//    OBJECT SET ENABLED(b41;false)
	//    OBJECT SET ENABLED(b43;false)
	RECEIVE VARIABLE:C81(vsiteID)
	SET WINDOW TITLE:C213("Receiving records from "+vsiteID)
	RECEIVE VARIABLE:C81(vCntCust)
	RECEIVE VARIABLE:C81(vCntCon)
	RECEIVE VARIABLE:C81(vCntPp)
	RECEIVE VARIABLE:C81(vCntOrd)
	RECEIVE VARIABLE:C81(vCntInv)
	RECEIVE VARIABLE:C81(vCntSer)
	RECEIVE VARIABLE:C81(vCntShow)
	
	//      RECEIVE VARIABLE(vCntPay)
	//      RECEIVE VARIABLE(vCntPO)
	//    RECEIVE VARIABLE(vCntStk)
	//     RECEIVE VARIABLE(vCntItem)
	//      RECEIVE VARIABLE(vCntBom)
	//      RECEIVE VARIABLE(vCntSD)
	//      RECEIVE VARIABLE(vCntRep)
	//      RECEIVE VARIABLE(vCntTax)
	//     RECEIVE VARIABLE(vCntRepC)
	aSyncCnt{1}:=vCntCust
	aSyncCnt{2}:=vCntCon
	aSyncCnt{3}:=vCntPp
	aSyncCnt{4}:=vCntOrd
	aSyncCnt{5}:=vCntInv
	aSyncCnt{6}:=vCntSer
	aSyncCnt{7}:=vCntShow
	//      aSyncCnt{8}:=vCntPO
	//      aSyncCnt{9}:=vCntItem
	//      aSyncCnt{10}:=vCntBom
	//      aSyncCnt{11}:=vCntSD
	//      aSyncCnt{12}:=vCntTax
	//      aSyncCnt{13}:=vCntRep
	//      aSyncCnt{14}:=vCntRepC
	aSyncCnt:=0
	vdDateBeg:=Current date:C33
	vTimeBeg:=Current time:C178
	dtSession:=DateTime_DTTo(vdDateBeg; vTimeBeg)
	doSearch:=12
End if 