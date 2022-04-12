//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:18:18
// ----------------------------------------------------
// Method: TIOO_RunCase
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)  //pointer to text: the variable to append new text to
C_POINTER:C301($2)  //pointer to integer: index of command to run
C_BOOLEAN:C305($DebugON)
If (bTIOLogEvnt)
	$DebugON:=True:C214
	C_LONGINT:C283($DebugPC)
	$DebugPC:=$2->
	C_TEXT:C284($DebugStr)
	$DebugStr:="PC="+String:C10($DebugPC)  //Program Counter
	If (aTIOTypeCd{$DebugPC}<=Size of array:C274(<>aTOutTypes))
		$DebugStr:=$DebugStr+"!"+<>aTOutTypes{aTIOTypeCd{$DebugPC}}+"!"
	Else 
		Case of 
			: (aTIOTypeCd{$DebugPC}=<>ciTOutFRTkn)
				$DebugStr:=$DebugStr+"!FRToken!"
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
	: (aTIOTypeCd{$2->}=<>ciTOutWrite)
		C_LONGINT:C283($Type)
		$Type:=Type:C295(aTIOTypePtr{$2->}->)
		Case of 
			: (($Type=0) | ($Type=2) | ($Type=24))  //string
				$1->:=$1->+aTIOTypePtr{$2->}->
			: (($Type=1) | ($Type=8) | ($Type=9))  //number
				$1->:=$1->+String:C10(aTIOTypePtr{$2->}->)
			: ($Type=11)  //time
				$1->:=$1->+String:C10(aTIOTypePtr{$2->}->; 5)
			: ($Type=4)  //date
				$1->:=$1->+String:C10(aTIOTypePtr{$2->}->; 1)
			: ($Type=6)  //boolean
				If (aTIOTypePtr{$2->}->)
					$1->:=$1->+"True"
				Else 
					$1->:=$1->+"False"
				End if 
		End case 
	: (aTIOTypeCd{$2->}=<>ciTOutFRTkn)
		C_LONGINT:C283($result)
		$FRText:=aTIOTypePtr{$2->}->
		//aa4D_M_CreateReport_faceless 
		
		ExecuteText(0; $FRText; "TIOO_RunCase")
	: (aTIOTypeCd{$2->}=<>ciTOutBName)
		$2->:=aTIOTyIndex{$2->}-1  //the Index will imeadiately be incremented after this
	: (aTIOTypeCd{$2->}=<>ciTOutEName)
		//do nothing
	: (aTIOTypeCd{$2->}=<>ciTOutBLoop)
		If (iTIOPCLast<$2->)  //Entering loop for before first pass, init temp copy of iterator
			aTIOTyRData{$2->}:=Trunc:C95(aTIOTypePtr{$2->}->; 0)
		End if 
		If (aTIOTyRData{$2->}<1)  //skip to end of loop
			$2->:=aTIOTyIndex{$2->}-1  //the Index will imeadiately be incremented after this
			aTIOTyRData{$2->}:=-1
		Else 
			aTIOTyRData{$2->}:=aTIOTyRData{$2->}-1  //decrement temp copy
		End if 
	: (aTIOTypeCd{$2->}=<>ciTOutELoop)
		$2->:=aTIOTyIndex{$2->}-1  //the Index will imeadiately be incremented after this
	: (aTIOTypeCd{$2->}=<>ciTOutVersn)
		//do nothing
	: (aTIOTypeCd{$2->}=<>ciTOutTxOut)
		//do nothing
	: (aTIOTypeCd{$2->}=<>ciTOutDbug)
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
	$DebugStr:=$DebugStr+"!ToPC="+String:C10($2->+1)  //Next Program Counter
	ELog_NewRecMsg(0; "TIOO Run Log"; $DebugStr)
End if 