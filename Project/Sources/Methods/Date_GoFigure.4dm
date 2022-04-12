//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/20/12, 15:06:14
// ----------------------------------------------------
// Method: Date_GoFigure
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $dateString)
C_LONGINT:C283($2; $formatNum)
C_LONGINT:C283(<>DateFormat)
$dateString:=String:C10(Current date:C33)
If (Count parameters:C259>0)
	$dateString:=$1
	If (Count parameters:C259>1)
		$formatNum:=$2
	End if 
End if 
If (Count parameters:C259=2)
	$dateOpt:=$2
Else 
	$dateOpt:=<>DateFormat
End if 
C_LONGINT:C283($dateOpt)
C_DATE:C307($0; $tempDate; $dateOut)
C_LONGINT:C283($p; $pStop; $pCom; $pDash; $pspace; $firstDeliminator; $isDeliminator)
C_TEXT:C284($deLim)
$p:=Position:C15("/"; $dateString)
$pStop:=Position:C15("."; $dateString)
$pCom:=Position:C15(","; $dateString)
$pDash:=Position:C15("-"; $dateString)
$doUS:=True:C214
$pspace:=Position:C15(" "; $dateString)
$isDeliminator:=Num:C11(($pspace+$pDash+$pCom+$pStop+$p)>0)

If ($pSpace>0)  //for use with Access
	$dateString:=Substring:C12($dateString; 1; $pSpace-1)
End if 
$doUS:=Not:C34(<>vbDateByDDMMYY)
Case of 
	: ($p>0)
		$deLim:="/"
	: ($pDash>0)
		$deLim:="-"
		$p:=$pDash
	: ($pStop>0)
		$p:=$pStop
		$deLim:="."
		$doUS:=False:C215
	: ($pCom>0)
		$p:=$pCom
		$deLim:="."
		$doUS:=False:C215
End case 
C_LONGINT:C283($theLength)
$theLength:=Length:C16($dateString)
$yearFirst:=($p=5)

Case of 
	: ($theLength=0)
		$dateOut:=!00-00-00!
	: (($theLength=10) & ($yearFirst))  //ISO  YEAR-MM-DD
		$dateOut:=Date:C102(Substring:C12($dateString; 6; 2)+"/"+Substring:C12($dateString; 9; 2)+"/"+Substring:C12($dateString; 1; 4))
	: (($theLength=6) & ($dateOpt=0) & ($p=0))
		$dateOut:=Date:C102(Substring:C12($dateString; 1; 2)+"/"+Substring:C12($dateString; 3; 2)+"/"+String:C10(Date_YrCent(Substring:C12($dateString; 5; 2))))
	: (($theLength=6) & ($p=0))
		//$dateOut:=Date_CvrtYyMmDd ($dateString)
		$dateOut:=Date:C102(Substring:C12($dateString; 1; 2)+"/"+Substring:C12($dateString; 3; 2)+"/"+String:C10(Date_YrCent(Substring:C12($dateString; 5; 2))))
	: (($theLength=4) & ($p=2))
		If (<>vbDateByDDMMYY)
			$tempDate:=Date:C102("1/"+Substring:C12($dateString; 1; 1)+"/"+String:C10(Date_YrCent(Substring:C12($dateString; 3; 2))))
		Else 
			$tempDate:=Date:C102(Substring:C12($dateString; 1; 1)+"/1/"+String:C10(Date_YrCent(Substring:C12($dateString; 3; 2))))
		End if 
		$dateOut:=Date_ThisMon($tempDate; 1)
	: (($theLength=5) & ($p=3))
		If (<>vbDateByDDMMYY)
			$dateOut:=Date:C102("1/"+Substring:C12($dateString; 1; 2)+"/"+String:C10(Date_YrCent(Substring:C12($dateString; 4; 2))))
		Else 
			$dateOut:=Date:C102(Substring:C12($dateString; 1; 2)+"/1/"+String:C10(Date_YrCent(Substring:C12($dateString; 4; 2))))
		End if 
	: (($theLength=4) & ($p=0))
		If (<>vbDateByDDMMYY)
			$tempDate:=Date:C102("1/"+Substring:C12($dateString; 1; 2)+"/"+String:C10(Date_YrCent(Substring:C12($dateString; 3; 2))))
		Else 
			$tempDate:=Date:C102(Substring:C12($dateString; 1; 2)+"/1/"+String:C10(Date_YrCent(Substring:C12($dateString; 3; 2))))
		End if 
		$dateOut:=Date_ThisMon($tempDate; 1)
	: (($theLength>4) & ($p>1))
		$dateStr:=$dateString
		If ($doUS)
			$monStr:=Substring:C12($dateStr; 1; $p-1)
			$monStr:=("0"*Num:C11(Length:C16($monStr)=1))+$monStr
			$dateStr:=Substring:C12($dateStr; $p+1)
			$p:=Position:C15($deLim; $dateStr)
			If ($p=0)
				$yrStr:=Substring:C12($dateStr; $p+1)
				$yrStr:=String:C10(Date_YrCent($yrStr))
				$dateOut:=Date:C102($monStr+"/1/"+$yrStr)
			Else 
				$dayStr:=Substring:C12($dateStr; 1; $p-1)
				$dayStr:=("0"*Num:C11(Length:C16($dayStr)=1))+$dayStr
				$yrStr:=Substring:C12($dateStr; $p+1)
				$yrStr:=String:C10(Date_YrCent($yrStr))
				If (($yrStr#"") & ($dayStr#"") & ($monStr#""))
					$dateOut:=Date:C102($monStr+"/"+$dayStr+"/"+$yrStr)
				Else 
					$dateOut:=!00-00-00!
				End if 
			End if 
		Else 
			$dayStr:=Substring:C12($dateStr; 1; $p-1)
			$dateStr:=("0"*Num:C11(Length:C16($dateStr)=1))+$dateStr
			$dateStr:=Substring:C12($dateStr; $p+1)
			$p:=Position:C15($deLim; $dateStr)
			$monStr:=Substring:C12($dateStr; 1; $p-1)
			$monStr:=("0"*Num:C11(Length:C16($monStr)=1))+$monStr
			$yrStr:=Substring:C12($dateStr; $p+1)
			$yrStr:=String:C10(Date_YrCent($yrStr))
			If (($yrStr#"") & ($dayStr#"") & ($monStr#""))
				$dateOut:=Date:C102($dayStr+"/"+$monStr+"/"+$yrStr)
			Else 
				$dateOut:=!00-00-00!
			End if 
		End if 
	Else 
		$dateOut:=!00-00-00!
End case 
$0:=$dateOut