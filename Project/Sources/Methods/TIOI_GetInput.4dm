//%attributes = {"publishedWeb":true}


// SET DATABASE PARAMETER(34;2)  // ### jwm ### 20170313_1534 debug crashing
// creates a 4d log file

C_LONGINT:C283($0)  //result code for reading the Input File
C_POINTER:C301($1)  //Ptr to Text: Path of File to Read
C_TIME:C306(tmFileID)
If (Test path name:C476($1->)>=0)
	TIO_InitRunData
	C_LONGINT:C283($PCLast)
	If ((iTIONameBgn>0) & (iTIONameEnd>iTIONameBgn))
		tTIOIBuffer:=""
		tTIOIUnRead:=Util_GetShortName($1->)
		bTIOIError:=False:C215
		lTIOIErrNum:=0
		bTIOIAtEOF:=False:C215
		iTIOProgCtr:=iTIONameBgn+1
		iTIOPCLast:=iTIONameBgn
		While ((iTIOProgCtr<iTIONameEnd) & (iTIOProgCtr>0))
			$PCLast:=iTIOProgCtr
			//ConsoleMessage ("Program Counter\t"+String(iTIOProgCtr))
			TIOI_RunCase(->iTIOProgCtr; <>cptNilPoint; $1)
			iTIOPCLast:=$PCLast
			iTIOProgCtr:=iTIOProgCtr+1
		End while 
		If (iTIOProgCtr>=-1)  //-2+1 is -1; -2 is normal terminate, -3 is error terminate
			$0:=<>ciTIOINoErr
		Else 
			$0:=<>ciTIOIName
		End if 
	Else 
		iTIOProgCtr:=1  //to avoid being <=0 for main loop test
	End if 
	If (iTIOProgCtr>0)  //<=0 indicates a failure in the name check
		If (Is macOS:C1572)
			tmFileID:=Open document:C264($1->)
		Else 
			C_TEXT:C284($Type)
			$Type:=Substring:C12($1->; Length:C16($1->)-3)
			C_LONGINT:C283($pos)
			$pos:=Position:C15("."; $Type)
			If ($pos>0)
				C_TEXT:C284($Path)
				$Path:=$1->
				$Type:=Substring:C12($Type; $pos+1)
				$Path:=Substring:C12($Path; 1; Length:C16($Path)-(5-$pos))
				tmFileID:=Open document:C264($Path; $Type)
			Else 
				tmFileID:=Open document:C264($1->)
			End if 
		End if 
		If (OK=1)  //file opened ok
			tTIOIBuffer:=""
			tTIOIUnRead:=""
			bTIOIError:=False:C215
			lTIOIErrNum:=0
			bTIOIAtEOF:=False:C215
			iTIOProgCtr:=1
			iTIOPCLast:=0
			While ((iTIOProgCtr<=Size of array:C274(aTIOTypeCd)) & (iTIOProgCtr>0))
				$PCLast:=iTIOProgCtr
				TIOI_RunCase(->iTIOProgCtr; ->tmFileID; $1)
				iTIOPCLast:=$PCLast
				iTIOProgCtr:=iTIOProgCtr+1
			End while 
			CLOSE DOCUMENT:C267(tmFileID)
			If (iTIOProgCtr>=-1)  //-2+1 is -1; -2 is normal terminate, -3 is error terminate
				$0:=<>ciTIOINoErr
			Else 
				$0:=<>ciTIOIData
			End if 
		Else 
			$0:=<>ciTIOIFile  //File won't open
		End if 
	End if 
Else 
	$0:=<>ciTIOIFile  //No File
	ELog_NewRecMsg(-47; "TIOI Error"; "The file "+$1->+" doesn't exist.")
End if 