//%attributes = {"publishedWeb":true}
//Procedure: GL_MapInsightAc
//Noah Dykoski  February 6, 1999 / 5:50 PM

C_TEXT:C284($0)  //The Insight Account Num modified by look up from the DivDefaults
C_TEXT:C284($1; $DivDfltID)  //The theCustomer Division
$DivDfltID:=$1
C_TEXT:C284($2; $AcctNum)
$AcctNum:=$2
C_TEXT:C284($3; $SepChar)
If (Count parameters:C259>=3)
	$SepChar:=$3
Else 
	$SepChar:="-"
End if 

ALL RECORDS:C47([DefaultAccount:32])
FIRST RECORD:C50([DefaultAccount:32])
If (($AcctNum#[DefaultAccount:32]acctReceivables:8) & ($AcctNum#[DefaultAccount:32]purchaseAcct:27) & ($AcctNum#[DefaultAccount:32]cash:4) & ($AcctNum#[DefaultAccount:32]commRepPay:10) & ($AcctNum#[DefaultAccount:32]commEmpPay:2))
	QUERY:C277([DivisionDefault:85]; [DivisionDefault:85]idNum:1=$DivDfltID)
	C_LONGINT:C283($firstSep; $secondSep)
	$firstSep:=Position:C15($SepChar; $AcctNum)
	If ($firstSep>0)
		$secondSep:=Position:C15($SepChar; Substring:C12($AcctNum; $firstSep+1))+$firstSep
		If ($secondSep>0)
			If (Records in selection:C76([DivisionDefault:85])=1)
				Case of 
					: (([DivisionDefault:85]department:23="") & ([DivisionDefault:85]profitCenter:24=""))
						$0:=$AcctNum
					: (([DivisionDefault:85]department:23#"") & ([DivisionDefault:85]profitCenter:24=""))
						$0:=Substring:C12($AcctNum; 1; $firstSep)+[DivisionDefault:85]department:23+Substring:C12($AcctNum; $secondSep)
					: (([DivisionDefault:85]department:23="") & ([DivisionDefault:85]profitCenter:24#""))
						$0:=Substring:C12($AcctNum; 1; $secondSep)+[DivisionDefault:85]profitCenter:24
					Else 
						$0:=Substring:C12($AcctNum; 1; $firstSep)+[DivisionDefault:85]department:23+$SepChar+[DivisionDefault:85]profitCenter:24
				End case 
			Else 
				$0:=$AcctNum
			End if 
		Else 
			$0:="Err no 2nd [DefaultAccount] "+$SepChar+":"+$AcctNum
		End if 
	Else 
		$0:="Err no [DefaultAccount] "+$SepChar+":"+$AcctNum
	End if 
Else 
	$0:=$AcctNum
End if 