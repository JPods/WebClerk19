//%attributes = {"publishedWeb":true}
//Procedure: FC_SaveLocal
If (False:C215)
	TCStrong_prf_v142_RWVar
	TCStrong_prf_v142_FilePack
	//02/03/03.prf
	//code changes to replace RWVar plugin
	//code changes to replace FilePack plugin
End if 

ALERT:C41("This feature is disabled - method FC_SaveLocal")

//C_LONGINT($rslt;$doc)
//C_TEXT($locItems)
//TRACE
//$locItems:=Storage.folder.jitPrefPath+"Fore"
//If (HFSExists ($locItems)#0)//Both files exist
//$rslt:=HFSDelete ($locItems)
//End if 
//CreateVarFile ($locItems;"JITA";"Text")
//$doc:=OpenVarFile ($locItems)
//WriteVarArray ($doc;aFCItem)
//WriteVarArray ($doc;aFCBomCnt)
//WriteVarArray ($doc;aFCActionDt)
//WriteVarArray ($doc;aFCBomLevel)
//WriteVarArray ($doc;aFCParent)
//WriteVarArray ($doc;aFCTypeTran)
//WriteVarArray ($doc;aFCDocID)
//WriteVarArray ($doc;aFCDesc)
//WriteVarArray ($doc;aFCRunQty)
//WriteVarArray ($doc;aFCWho)
//WriteVarArray ($doc;aFCRecNum)
//CloseVarFile ($doc)



//If (False)
////Date: 03/18/02
////Who: Dan Bentson, Arkware
////Description: Added base quantity, tally
//VERSION_960 
//End if 
//
////Procedure: FC_SaveLocal
//C_LONGINT($rslt;$doc)
//C_TEXT($locItems)
//TRACE
//$locItems:=Storage.folder.jitPrefPath+"Fore"
//If (HFSExists ($locItems)#0)//Both files exist
//$rslt:=HFSDelete ($locItems)
//End if 
//CreateVarFile ($locItems;"JITA";"Text")
//$doc:=OpenVarFile ($locItems)
//WriteVarArray ($doc;aFCItem)
//WriteVarArray ($doc;aFCBomCnt)
//WriteVarArray ($doc;aFCActionDt)
//WriteVarArray ($doc;aFCBomLevel)
//WriteVarArray ($doc;aFCParent)
//WriteVarArray ($doc;aFCTypeTran)
//WriteVarArray ($doc;aFCDocID)
//WriteVarArray ($doc;aFCDesc)
//WriteVarArray ($doc;aFCRunQty)
//WriteVarArray ($doc;aFCWho)
//WriteVarArray ($doc;aFCRecNum)
//WriteVarArray ($doc;aFCTallyYTD)
//WriteVarArray ($doc;aFCTallyLess1Year)
//WriteVarArray ($doc;aFCTallyLess2Year)
//WriteVarArray ($doc;aFCBaseQty)
//CloseVarFile ($doc)