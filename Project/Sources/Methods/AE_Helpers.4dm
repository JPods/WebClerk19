//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/06/06, 10:09:35
// ----------------------------------------------------
// Method: AE_Helpers
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	TCStrong_prf_v142_RWVar
	TCStrong_prf_v142_FilePack
	TCStrong_prf_v144_FilePackReTok
	//02/03/03.prf
	//code changes to replace RWVar plugin
	//code changes to replace FilePack plugin
End if 
C_LONGINT:C283($1)  //instruction
C_LONGINT:C283($0)  //the array element
C_TEXT:C284($2)  //document name

C_LONGINT:C283($wCrea; $wSuff; $wApp)
C_BOOLEAN:C305($doWriteLog; $doApp; $doCreator)
$doApp:=False:C215
$doWriteLog:=False:C215
$doCreator:=False:C215
If (Size of array:C274(<>aLaunchSuff)=0)
	C_TEXT:C284($locItems)
	$locItems:=Storage:C1525.folder.jitPrefPath+"LaunchHelpers.txt"
	
	//02/03/03.prf
	
	//If (HFSExists ($locItems)#0)
	//$doc:=OpenVarFile ($locItems)
	//If (ReadWriteVarErr =0)
	//ReadVarArray ($doc;<>aLaunchApp)
	//ReadVarArray ($doc;<>aLaunchSuff)
	//ReadVarArray ($doc;<>aLaunchCrea)
	//CloseVarFile ($doc)
	//End if 
	//End if 
	
End if 
$w:=-1
//If ($1=-3)
$theCreator:=""
$theSuff:=SuffixGet($2)
$thePref:=Substring:C12($2; 1; 3)
If (Length:C16($theSuff)>1)  // Modified by: williamjames (111216 checked for <= length protection)
	If ($theSuff[[2]]=".")  //allow for .html
		$theSuff:=Substring:C12($theSuff; 2)
	End if 
	//End if
	$doSuffLength:=False:C215
	If (Length:C16($theSuff)>0)
		If ($theSuff[[1]]=".")
			$doSuffLength:=True:C214
		End if 
	End if 
	Case of 
		: (($theSuff=".4SP") | ($thePref="4S["))
			$w:=Find in array:C230(<>aLaunchCrea; "4DSP")
			If ($w=-1)
				$w:=Size of array:C274(<>aLaunchApp)+1
				INSERT IN ARRAY:C227(<>aLaunchApp; $w)
				INSERT IN ARRAY:C227(<>aLaunchSuff; $w)
				INSERT IN ARRAY:C227(<>aLaunchCrea; $w)
				<>aLaunchApp{$w}:="internal"
				<>aLaunchSuff{$w}:="4SP"
				<>aLaunchCrea{$w}:="4DSP"
				$doWriteLog:=True:C214
			End if 
			
		: (($theSuff=".SRP") | ($thePref="SR["))
			$theCreator:="gTSR"
			$w:=Find in array:C230(<>aLaunchCrea; "gTSR")
			If ($w=-1)
				$w:=Size of array:C274(<>aLaunchApp)+1
				INSERT IN ARRAY:C227(<>aLaunchApp; $w)
				INSERT IN ARRAY:C227(<>aLaunchSuff; $w)
				INSERT IN ARRAY:C227(<>aLaunchCrea; $w)
				<>aLaunchApp{$w}:="internal"
				<>aLaunchSuff{$w}:="SRP"
				<>aLaunchCrea{$w}:="gTSR"
				$doWriteLog:=True:C214
			End if 
		: (ShftKey=1)
			$doApp:=True:C214
			If ($doSuffLength)
				$w:=Find in array:C230(<>aLaunchCrea; $theSuff)
				If ($w>0)
					DELETE FROM ARRAY:C228(<>aLaunchApp; $w)
					DELETE FROM ARRAY:C228(<>aLaunchSuff; $w)
					DELETE FROM ARRAY:C228(<>aLaunchCrea; $w)
				End if 
			End if 
		: ($doSuffLength)
			$w:=Find in array:C230(<>aLaunchSuff; Substring:C12($theSuff; 2))
			Case of 
				: (($w=-1) & ($theCreator#""))
					$doCreator:=True:C214
				: ($w=-1)
					$doApp:=True:C214
			End case 
		: ($theCreator#"")
			$w:=Find in array:C230(<>aLaunchCrea; $theCreator)
			If ($w=-1)
				$doCreator:=True:C214
			End if 
	End case 
	If ($doCreator)
		$w:=Size of array:C274(<>aLaunchApp)+1
		INSERT IN ARRAY:C227(<>aLaunchApp; $w)
		INSERT IN ARRAY:C227(<>aLaunchSuff; $w)
		INSERT IN ARRAY:C227(<>aLaunchCrea; $w)
		<>aLaunchApp{$w}:=""
		<>aLaunchCrea{$w}:=$theCreator
		<>aLaunchSuff{$w}:=Substring:C12($theSuff; 2)*Num:C11($doSuffLength)
		$doWriteLog:=True:C214
	End if 
End if 
If ($doApp)
	TRACE:C157
	$myAppName:=Get_FileName("Select Application"; "")
	If ($myAppName#"")
		$w:=0
		Case of 
			: ($doSuffLength)
				$w:=Find in array:C230(<>aLaunchSuff; Substring:C12($theSuff; 2))
			: ($theCreator#"")
				$w:=Find in array:C230(<>aLaunchCrea; $theCreator)
			Else 
				$w:=Find in array:C230(<>aLaunchApp; $myAppName)
		End case 
		If ($w=-1)
			$w:=Size of array:C274(<>aLaunchApp)+1
			INSERT IN ARRAY:C227(<>aLaunchApp; $w)
			INSERT IN ARRAY:C227(<>aLaunchSuff; $w)
			INSERT IN ARRAY:C227(<>aLaunchCrea; $w)
		End if 
		$doWriteLog:=True:C214
		<>aLaunchApp{$w}:=$myAppName
		<>aLaunchCrea{$w}:="n/a"
		<>aLaunchSuff{$w}:=Substring:C12($theSuff; 2)*Num:C11($doSuffLength)
	End if 
End if 
$0:=$w
If ($doWriteLog)
	$locItems:=Storage:C1525.folder.jitPrefPath+"LaunchHelpers.txt"
	
	//02/03/03.prf
	
	//If (HFSExists ($locItems)#0)
	//$rslt:=HFSDelete ($locItems)
	//End if 
	
	//CreateVarFile ($locItems;"JITA")//;"Text")
	//$doc:=OpenVarFile ($locItems)
	//WriteVarArray ($doc;<>aLaunchApp)
	//WriteVarArray ($doc;<>aLaunchSuff)
	//WriteVarArray ($doc;<>aLaunchCrea)
	//CloseVarFile ($doc)
	
End if 