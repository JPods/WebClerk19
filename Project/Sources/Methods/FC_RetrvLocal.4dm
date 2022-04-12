//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_prf_v142_RWVar
	TCStrong_prf_v142_FilePack
	//02/03/03.prf
	//code changes to replace RWVar plugin
	//code changes to replace FilePack plugin
End if 

ALERT:C41("This feature is disabled - method FC_RetrvLocal")



//If (False)
////Date: 03/18/02
////Who: Dan Bentson, Arkware
////Description: Added base quantity, tally
//VERSION_960 
//End if 
//
//C_Longint(bRetrvList)//Procedure: FC_RetrvLocal
//C_LONGINT($rslt;$doc)
//C_TEXT($locItems)
//$locItems:=Storage.folder.jitPrefPath+"Fore"
//If (HFSExists ($locItems)#0)//Both files exist
//$doc:=OpenVarFile($locItems)
//If (ReadWriteVarErr =0)
////$num:=ReadVarLong ($doc)
////If ($num=myVersNum)
//ReadVarArray ($doc;aFCItem)
//ReadVarArray ($doc;aFCBomCnt)
//ReadVarArray ($doc;aFCActionDt)
//ReadVarArray ($doc;aFCBomLevel)
//ReadVarArray ($doc;aFCParent)
//ReadVarArray ($doc;aFCTypeTran)
//ReadVarArray ($doc;aFCDocID)
//ReadVarArray ($doc;aFCDesc)
//ReadVarArray ($doc;aFCRunQty)
//ReadVarArray ($doc;aFCWho)
//ReadVarArray ($doc;aFCRecNum)
//ReadVarArray ($doc;aFCTallyYTD)
//ReadVarArray ($doc;aFCTallyLess1Year)
//ReadVarArray ($doc;aFCTallyLess2Year)
//ReadVarArray ($doc;aFCBaseQty)
//CloseVarFile ($doc)
//End if 
//End if 