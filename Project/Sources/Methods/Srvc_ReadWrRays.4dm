//%attributes = {"publishedWeb":true}
//Procedure: Srvc_ReadWrRays
//Noah Dykoski  June 25, 1998 / 8:19 PM

C_LONGINT:C283(bRetrvList)  //Procedure: FC_RetrvLocal
C_LONGINT:C283($1; $rslt; $doc)
C_TEXT:C284($locItems)
If ($1=1)
	C_LONGINT:C283($rslt; $doc)
	C_TEXT:C284($locItems)
	$locItems:=Storage:C1525.folder.jitPrefPath+"Serv1"
	
	If (False:C215)  //rewrite into web service
		TCStrong_prf_v142_RWVar
		WebService_Version0001
		
		If (HFS_Exists($locItems)#0)  //Both files exist
			$rslt:=HFS_Delete($locItems)
		End if 
		//CreateVarFile($locItems;"JITA";"Text")
		//$doc:=OpenVarFile ($locItems)
		//WriteVarArray($doc;aServiceTableName)
		//WriteVarArray ($doc;aServiceTime)
		//WriteVarArray ($doc;aServiceDate)
		//WriteVarArray ($doc;aServiceAction)
		//WriteVarArray ($doc;aServiceVariable)
		//WriteVarArray ($doc;aServiceAttention)
		//WriteVarArray ($doc;aServiceCompany)
		//WriteVarArray ($doc;aServiceRecs)
		//CloseVarFile($doc)
		
	End if 
	
Else 
	$locItems:=Storage:C1525.folder.jitPrefPath+"Serv1"
	If (False:C215)  //rewrite into web service
		TCStrong_prf_v142_RWVar
		WebService_Version0001
		If (HFS_Exists($locItems)#0)  //Both files exist
			//
			//AL_RemoveArrays (eService;1;9)
			//    
			//$doc:=OpenVarFile ($locItems)
			//If (ReadWriteVarErr =0)
			////$num:=ReadVarLong ($doc)
			////If ($num=myVersNum)
			//ReadVarArray ($doc;aServiceTableName)
			//ReadVarArray ($doc;aServiceTime)
			//ReadVarArray ($doc;aServiceDate)
			//ReadVarArray ($doc;aServiceAction)
			//ReadVarArray ($doc;aServiceVariable)
			//ReadVarArray ($doc;aServiceAttention)
			//ReadVarArray ($doc;aServiceCompany)
			//ReadVarArray ($doc;aServiceRecs)
			//CloseVarFile ($doc)
			TRACE:C157
		End if 
		Serv_ALDefine
	End if 
End if 