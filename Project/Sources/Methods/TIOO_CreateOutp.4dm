//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_prf_v144_FilePack
	TCStrong_prf_v144_FilePackReTok
	//02/10/03.prf
	//removed plugin FilePack  
	//TCStrong_prf_v144
	TCStrong_prf_v144_FileIOPack
	//02/10/03.prf
	//removed plugin FileIOPack
End if 

TIO_InitRunData
C_LONGINT:C283($PCLast)
If ((iTIONameBgn>0) & (iTIONameEnd>iTIONameBgn))
	tTIOTxtData:=""
	iTIOProgCtr:=iTIONameBgn+1
	iTIOPCLast:=iTIONameBgn
	While (iTIOProgCtr<iTIONameEnd)
		$PCLast:=iTIOProgCtr
		TIOO_RunCase(->tTIOTxtData; ->iTIOProgCtr)
		iTIOPCLast:=$PCLast
		iTIOProgCtr:=iTIOProgCtr+1
	End while 
	C_LONGINT:C283($pos)
	If (Is macOS:C1572)
		$pos:=Position:C15(":"; tTIOTxtData)  //look for folder name dividers ":"
	Else 
		$pos:=Position:C15("\\\\"; tTIOTxtData)  //look for folder name dividers "\"
	End if 
	C_TEXT:C284($Path)
	If ($pos=0)
		$Path:=tTIODstPath
	Else 
		$Path:=HFS_ParentName(tTIOTxtData)
	End if 
	tTIOTxtData:=$Path+Substring:C12(HFS_ShortName(tTIOTxtData); 1; 31)
	
	//02/10/03.prf 
	
	//If (Is macOS)
	//$FileID:=create document(tTIOTxtData)
	//Else    
	//C_LONGINT($FileRef)
	//$FileRef:=CreateFile (tTIOTxtData;"";"";"")
	//CloseFile ($FileRef)
	//$FileID:=Open document(tTIOTxtData)
	//End if 
	
	$FileID:=Create document:C266(tTIOTxtData)
	
	//If (Is macOS)
	//$FileID:=create document(tTIOTxtData)
	//Else 
	//C_TEXT($Type)
	//$Type:=Substring(tTIOTxtData;Length(tTIOTxtData)-3)
	//C_Longint($pos)
	//$pos:=Position(".";$Type)
	//If ($pos>0)
	//C_TEXT($Path)
	//$Path:=tTIOTxtData
	//$Type:=Substring($Type;$pos+1)
	//$Path:=Substring($Path;1;Length($Path)-(5-$pos))
	//vText1:=$Path
	//vText2:=$Type
	//$FileID:=create document(vText1;vText2)
	//C_Longint($Tries)
	//$Tries:=0
	//While ((HFS_Exists (vText1+"."+vText2)=0)&($Tries<5))
	//CLOSE DOCUMENT($FileID)
	//$FileID:=create document(vText1;vText2)
	//$Tries:=$Tries+1
	//End while 
	//Else 
	//$FileID:=create document(tTIOTxtData)
	//End if 
	//End if 
Else 
	$FileID:=Create document:C266("")
End if 
If (OK=1)  //file opened ok
	tTIOTxtData:=""
	iTIOProgCtr:=1
	iTIOPCLast:=0
	While (iTIOProgCtr<=Size of array:C274(aTIOTypeCd))
		$PCLast:=iTIOProgCtr
		TIOO_RunCase(->tTIOTxtData; ->iTIOProgCtr)
		iTIOPCLast:=$PCLast
		iTIOProgCtr:=iTIOProgCtr+1
		If (Length:C16(tTIOTxtData)>200)  //200 is just a good sized #
			SEND PACKET:C103($FileID; tTIOTxtData)
			tTIOTxtData:=""
		End if 
	End while 
	If (Length:C16(tTIOTxtData)>0)
		SEND PACKET:C103($FileID; tTIOTxtData)
		tTIOTxtData:=""
	End if 
	CLOSE DOCUMENT:C267($FileID)
Else 
	ELog_NewRecMsg(-1; "TIOO Error"; "The file could not be created.")
End if 