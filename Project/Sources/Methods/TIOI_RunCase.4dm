//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:16:04
// ----------------------------------------------------
// Method: TIOI_RunCase
// Description
// Reason:  <>ciTInFRTkn and Token
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)  //pointer to integer: index of command to run
C_POINTER:C301($2)  //Ptr to File ID or Text Var
C_POINTER:C301($3)  //Ptr to Text: Path of File to Read
C_BOOLEAN:C305($DebugON)
If (bTIOLogEvnt)
	$DebugON:=True:C214
	C_LONGINT:C283($DebugPC)
	$DebugPC:=$1->
	C_TEXT:C284($DebugStr)
	$DebugStr:="PC="+String:C10($DebugPC)  //Program Counter
	If (aTIOTypeCd{$DebugPC}<=Size of array:C274(<>aTInTypes))
		$DebugStr:=$DebugStr+"!"+<>aTInTypes{aTIOTypeCd{$DebugPC}}+"!"
	Else 
		Case of 
			: (aTIOTypeCd{$DebugPC}=<>ciTInFRTkn)
				$DebugStr:=$DebugStr+"!FRToken!"
			: (aTIOTypeCd{$DebugPC}=<>ciTInBLpNoI)
				$DebugStr:=$DebugStr+"!Begin Loop!"
		End case 
	End if 
	C_LONGINT:C283($DebugType)
	If (Is nil pointer:C315(aTIOTypePtr{$DebugPC}))
		$DebugStr:=$DebugStr+"Nil"
		$DebugType:=-1
	Else 
		If (Is a variable:C294(aTIOTypePtr{$DebugPC}))
			$DebugStr:=$DebugStr+"Var="
		Else 
			$DebugStr:=$DebugStr+"["+Table name:C256(aTIOTypePtr{$DebugPC})+"]"+Field name:C257(aTIOTypePtr{$DebugPC})+"="
		End if 
		$DebugType:=Type:C295(aTIOTypePtr{$DebugPC}->)
		Case of 
			: (($DebugType=0) | ($DebugType=2) | ($DebugType=24))  //string
				$DebugStr:=$DebugStr+aTIOTypePtr{$DebugPC}->
			: (($DebugType=1) | ($DebugType=8) | ($DebugType=9))  //number
				$DebugStr:=$DebugStr+String:C10(aTIOTypePtr{$DebugPC}->)
			: ($DebugType=11)  //time
				$DebugStr:=$DebugStr+String:C10(aTIOTypePtr{$DebugPC}->; 5)
			: ($DebugType=4)  //date
				$DebugStr:=$DebugStr+String:C10(aTIOTypePtr{$DebugPC}->; 1)
			: ($DebugType=6)  //boolean
				$DebugStr:=$DebugStr+(("T"*Num:C11(aTIOTypePtr{$DebugPC}->))+("F"*Num:C11(Not:C34(aTIOTypePtr{$DebugPC}->))))
		End case 
	End if 
	If (aTIOTyIndex{$DebugPC}>0)
		$DebugStr:=$DebugStr+"!Index="+String:C10(aTIOTyIndex{$DebugPC})  //Next Index
	End if 
	If (aTIOTyRData{$DebugPC}#-1)
		$DebugStr:=$DebugStr+"!RunD="+String:C10(aTIOTyRData{$DebugPC})  //Runtime Data
	End if 
Else 
	$DebugON:=False:C215
End if 
Case of 
	: (aTIOTypeCd{$1->}=<>ciTInReadNm)
		TIOI_ReadNumber($1; $2; $3)
	: (aTIOTypeCd{$1->}=<>ciTInReadSt)
		TIOI_ReadString($1; $2; $3; True:C214)
	: (aTIOTypeCd{$1->}=<>ciTInRdToSt)
		TIOI_ReadString($1; $2; $3; False:C215)  //false: don't put the Search string in the buffer
	: (aTIOTypeCd{$1->}=<>ciTInUnRead)
		C_LONGINT:C283($RemainLen)
		$RemainLen:=Trunc:C95(aTIOTypePtr{$1->}->; 0)
		If ($RemainLen>0)
			$RemainLen:=Length:C16(tTIOIBuffer)-$RemainLen  //# of chars to leave behind
			tTIOIUnRead:=Substring:C12(tTIOIBuffer; $RemainLen+1)+tTIOIUnRead
			tTIOIBuffer:=Substring:C12(tTIOIBuffer; 1; $RemainLen)
		Else 
			tTIOIUnRead:=tTIOIBuffer+tTIOIUnRead
			tTIOIBuffer:=""
		End if 
	: (aTIOTypeCd{$1->}=<>ciTInPutBuf)
		C_LONGINT:C283($Type)
		$Type:=Type:C295(aTIOTypePtr{$1->}->)
		Case of 
			: (($Type=0) | ($Type=2) | ($Type=24))  //string
				aTIOTypePtr{$1->}->:=tTIOIBuffer
			: (($Type=1) | ($Type=8) | ($Type=9))  //number
				aTIOTypePtr{$1->}->:=Num:C11(tTIOIBuffer)
			: ($Type=11)  //time
				aTIOTypePtr{$1->}->:=Time:C179(tTIOIBuffer)
			: ($Type=4)  //date
				aTIOTypePtr{$1->}->:=Date:C102(tTIOIBuffer)
			: ($Type=6)  //boolean
				aTIOTypePtr{$1->}->:=((tTIOIBuffer="1") | (tTIOIBuffer="true") | (tTIOIBuffer="t") | (tTIOIBuffer="Yes") | (tTIOIBuffer="Y"))
		End case 
	: (aTIOTypeCd{$1->}=<>ciTInSetBuf)
		tTIOIBuffer:=aTIOTypePtr{$1->}->
	: (aTIOTypeCd{$1->}=<>ciTInFRTkn)
		C_LONGINT:C283($result)
		$FRText:=aTIOTypePtr{$1->}->
		ExecuteText(0; $FRText; "TIOI_RunCase")
	: (aTIOTypeCd{$1->}=<>ciTInBIsLst)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInIsBuff)
		If (Not:C34(TIOI_WildSMatch(aTIOTypePtr{$1->})))  //if there is no match goto next Is command
			$1->:=aTIOTyIndex{$1->}-1  //the Index will immeadiately be incremented after this
		End if 
	: (aTIOTypeCd{$1->}=<>ciTInReadEr)
		If (Not:C34(bTIOIError))  //if there     is no read error goto next Is command
			$1->:=aTIOTyIndex{$1->}-1  //the Index will immeadiately be incremented after this
		End if 
	: (aTIOTypeCd{$1->}=<>ciTInIsEOF)
		If (Not:C34(bTIOIAtEOF))  //if there is no read error goto next Is command
			$1->:=aTIOTyIndex{$1->}-1  //the Index will immeadiately be incremented after this
		End if 
	: (aTIOTypeCd{$1->}=<>ciTInIsOthr)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInEIsLst)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInBName)  //skip to one after end  name
		$1->:=aTIOTyIndex{$1->}-1  //the Index will immeadiately be incremented after this
	: (aTIOTypeCd{$1->}=<>ciTInEName)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInBLoop)
		If (iTIOPCLast<$1->)  //Entering loop for before first pass, init temp copy of iterator
			aTIOTyRData{$1->}:=Trunc:C95(aTIOTypePtr{$1->}->; 0)
		End if 
		If (aTIOTyRData{$1->}<1)  //skip to end of loop
			$1->:=aTIOTyIndex{$1->}-1  //the Index will imeadiately be incremented after this
			aTIOTyRData{$1->}:=-1
		Else 
			aTIOTyRData{$1->}:=aTIOTyRData{$1->}-1  //decrement temp copy
		End if 
	: (aTIOTypeCd{$1->}=<>ciTInBLpNoI)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInELoop)  //return to begin loop
		$1->:=aTIOTyIndex{$1->}-1  //the Index will immeadiately be incremented after this
	: (aTIOTypeCd{$1->}=<>ciTInExitLp)  //goto one after end loop
		$1->:=aTIOTyIndex{$1->}-1  //the Index will immeadiately be incremented after this
	: (aTIOTypeCd{$1->}=<>ciTInQuit)
		If (aTIOTypePtr{$1->}->#"")
			ELog_NewRecMsg(0; "TIOI"; "Done in "+Util_GetShortName($3->)+":  "+aTIOTypePtr{$1->}->)
		End if 
		$1->:=-2  //terminate; -2 so that after the immeadiate increment it will be -1
	: (aTIOTypeCd{$1->}=<>ciTInStop)
		If (aTIOTypePtr{$1->}->#"")
			ELog_NewRecMsg(-1; "TIOI Error"; "Stop in "+Util_GetShortName($3->)+":  "+aTIOTypePtr{$1->}->)
		End if 
		$1->:=-3  //terminate; -3 so that after the immeadiate increment it will be -2
	: (aTIOTypeCd{$1->}=<>ciTInVersn)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInTextIn)
		//Do Nothing
	: (aTIOTypeCd{$1->}=<>ciTInDebug)
		bTIOLogEvnt:=Not:C34(bTIOLogEvnt)  //toggle Event logging
End case 
If (($DebugON) & (bTIOLogEvnt))
	If ($DebugType#-1)
		Case of 
			: (($DebugType=0) | ($DebugType=2) | ($DebugType=24))  //string
				$DebugStr:=$DebugStr+"!=>"+aTIOTypePtr{$DebugPC}->
			: (($DebugType=1) | ($DebugType=8) | ($DebugType=9))  //number
				$DebugStr:=$DebugStr+"!=>"+String:C10(aTIOTypePtr{$DebugPC}->)
			: ($DebugType=11)  //time
				$DebugStr:=$DebugStr+"!=>"+String:C10(aTIOTypePtr{$DebugPC}->; 5)
			: ($DebugType=4)  //date
				$DebugStr:=$DebugStr+"!=>"+String:C10(aTIOTypePtr{$DebugPC}->; 1)
			: ($DebugType=6)  //boolean
				$DebugStr:=$DebugStr+"!=>"+(("T"*Num:C11(aTIOTypePtr{$DebugPC}->))+("F"*Num:C11(Not:C34(aTIOTypePtr{$DebugPC}->))))
		End case 
	End if 
	$DebugStr:=$DebugStr+"!ToPC="+String:C10($1->+1)  //Next Program Counter
	If (tTIOIBuffer#"")
		$DebugStr:=$DebugStr+"!Buffer="+tTIOIBuffer
	End if 
	If (tTIOIUnRead#"")
		$DebugStr:=$DebugStr+"!UnRead="+tTIOIUnRead
	End if 
	If (bTIOIError)  //if there is no read error goto next Is command
		$DebugStr:=$DebugStr+"!Error="+String:C10(lTIOIErrNum)
	End if 
	If (bTIOIAtEOF)  //if there is no read error goto next Is command
		$DebugStr:=$DebugStr+"!EOF"
	End if 
	$DebugStr:=$DebugStr+"!File="+$3->
	ELog_NewRecMsg(0; "TIOI Run Log"; $DebugStr)
End if 