//%attributes = {"publishedWeb":true}
//Method: PM:  Txt_StripCharsFromNum
//Noah Dykoski   January 15, 2000 / 4:12 PM
C_TEXT:C284($0)  //Number characters only (posible proceeded by a minus and/or having 1 decimal .)
C_TEXT:C284($1; $InStr)
$InStr:=$1

C_LONGINT:C283($index)

Case of 
	: (Length:C16($InStr)=0)
		$index:=1
		$0:=""
	: ($InStr[[1]]="-")
		$index:=2  //Leave a single first char minus sign in place
		$0:="-"
	Else 
		$index:=1
		$0:=""
End case 
$OnePeriod:=False:C215
While ($index<=Length:C16($InStr))
	If (((Character code:C91($InStr[[$index]])>=Character code:C91("0")) & (Character code:C91($InStr[[$index]])<=Character code:C91("9"))) | ($InStr[[$index]]="."))
		If ($InStr[[$index]]=".")
			If ($OnePeriod=False:C215)
				$OnePeriod:=True:C214
				$0:=$0+"."
			End if 
		Else 
			$0:=$0+$InStr[[$index]]
		End if 
	End if 
	$index:=$index+1
End while 