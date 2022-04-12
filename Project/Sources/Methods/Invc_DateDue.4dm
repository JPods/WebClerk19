//%attributes = {"publishedWeb":true}
//Procedure: Terms_DateDue
C_DATE:C307($0; $DateDue)  //the date this invoice is due
C_POINTER:C301($1; $DayStrPtr)  //opt return param: might be needed later by the caller (i.e. see Ledger_InvSave)
If (Count parameters:C259>=1)
	$DayStrPtr:=$1
End if 

If (Count parameters:C259>=1)
	$DayStrPtr->:=""
End if 
C_LONGINT:C283($fiaTerm)
$fiaTerm:=Find in array:C230(<>aTerms; [Invoice:26]terms:24)
If ($fiaTerm>0)
	Case of 
		: (<>aTermDueDay{$fiaTerm}>0)  //based on days from invoice
			$DateDue:=Invc_PrimeDate+<>aTermDueDay{$fiaTerm}
		: ((<>aTermDCutOf{$fiaTerm}#0) & (<>aTermDCutDu{$fiaTerm}#0))
			C_TEXT:C284($monStr; $yrStr; $dayStr)
			C_DATE:C307($probeDate)
			If (<>aTermDueDay{$fiaTerm}>0)
				$probeDate:=Invc_PrimeDate
			Else 
				$probeDate:=Invc_PrimeDate+Abs:C99(<>aTermDueDay{$fiaTerm})
			End if 
			$monStr:=String:C10(Month of:C24($probeDate))
			$yrStr:=String:C10(Year of:C25($probeDate))
			$dayStr:=String:C10(<>aTermDCutDu{$fiaTerm})
			
			//
			// MustFixQQQZZZ: Bill James (2022-01-26T06:00:00Z)
			// shift to ISO Date or javascript dt
			If (Count parameters:C259>=1)
				$DayStrPtr->:=$dayStr
			End if 
			$DateDue:=Date:C102($monStr+"/"+$dayStr+"/"+$yrStr)
			
			If ($DateDue=Invc_PrimeDate)
				$DateDue:=Date:C102(String:C10(Month of:C24($DateDue+30))+"/"+String:C10(<>aTermDCutDu{$fiaTerm})+"/"+String:C10(Year of:C25($DateDue+30)))
			Else 
				$DateDue:=Date:C102(String:C10(Month of:C24($DateDue+60))+"/"+String:C10(<>aTermDCutDu{$fiaTerm})+"/"+String:C10(Year of:C25($DateDue+60)))
			End if 
		: (<>aTermDate{$fiaTerm}>Invc_PrimeDate)
			$DateDue:=<>aTermDate{$fiaTerm}
		Else 
			$DateDue:=Invc_PrimeDate
	End case 
Else 
	$DateDue:=Invc_PrimeDate
End if 

$0:=$DateDue