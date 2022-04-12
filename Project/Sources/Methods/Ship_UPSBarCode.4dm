//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $0)
C_LONGINT:C283($2)
If ([QQQCarrier:11]CarrierID:10#$1)
	QUERY:C277([QQQCarrier:11]; [QQQCarrier:11]CarrierID:10=$1)
End if 
$vtext1:=String:C10($2; "00")
$vText2:=String:C10([Invoice:26]invoiceNum:2; "#########0000")
$vtext1:=$vText2+$vtext1
$len:=Length:C16($vtext1)
$vText3:=Substring:C12($vtext1; ($len-6))
//"1Z"
$theCheck:=[QQQCarrier:11]ShipperID:21
$k:=Length:C16($theCheck)
$theOriginal:=""
If ($k>6)
	For ($i; 1; $k)
		If ((($theCheck[[$i]]>="0") & ($theCheck[[$i]]<="9")) | (($theCheck[[$i]]>"@") & ($theCheck[[$i]]<"{")))
			$theOriginal:=$theOriginal+$theCheck[[$i]]
		End if 
	End for 
End if 
$theCheck:=[QQQCarrier:11]ShipperID:21+String:C10([QQQCarrier:11]ServcIndicator:32; "00")+$vText3
$theOriginal:=$theCheck
$k:=Length:C16($theCheck)
$checkSum:=0
$sumOdd:=0
$sumEven:=0
For ($i; 1; $k)
	Case of 
		: ($theCheck[[$i]]<":")
			//no action required      
		: ($theCheck[[$i]]="A")
			$theCheck[[$i]]:="2"
		: ($theCheck[[$i]]="B")
			$theCheck[[$i]]:="3"
		: ($theCheck[[$i]]="C")
			$theCheck[[$i]]:="4"
		: ($theCheck[[$i]]="D")
			$theCheck[[$i]]:="5"
		: ($theCheck[[$i]]="E")
			$theCheck[[$i]]:="6"
		: ($theCheck[[$i]]="F")
			$theCheck[[$i]]:="7"
		: ($theCheck[[$i]]="G")
			$theCheck[[$i]]:="8"
		: ($theCheck[[$i]]="H")
			$theCheck[[$i]]:="9"
		: ($theCheck[[$i]]="I")
			$theCheck[[$i]]:="0"
		: ($theCheck[[$i]]="J")
			$theCheck[[$i]]:="1"
		: ($theCheck[[$i]]="K")
			$theCheck[[$i]]:="2"
		: ($theCheck[[$i]]="L")
			$theCheck[[$i]]:="3"
		: ($theCheck[[$i]]="M")
			$theCheck[[$i]]:="4"
		: ($theCheck[[$i]]="N")
			$theCheck[[$i]]:="5"
		: ($theCheck[[$i]]="O")
			$theCheck[[$i]]:="6"
		: ($theCheck[[$i]]="P")
			$theCheck[[$i]]:="7"
		: ($theCheck[[$i]]="Q")
			$theCheck[[$i]]:="8"
		: ($theCheck[[$i]]="R")
			$theCheck[[$i]]:="9"
		: ($theCheck[[$i]]="S")
			$theCheck[[$i]]:="0"
		: ($theCheck[[$i]]="T")
			$theCheck[[$i]]:="1"
		: ($theCheck[[$i]]="U")
			$theCheck[[$i]]:="2"
		: ($theCheck[[$i]]="V")
			$theCheck[[$i]]:="3"
		: ($theCheck[[$i]]="W")
			$theCheck[[$i]]:="4"
		: ($theCheck[[$i]]="X")
			$theCheck[[$i]]:="5"
		: ($theCheck[[$i]]="Y")
			$theCheck[[$i]]:="6"
		: ($theCheck[[$i]]="Z")
			$theCheck[[$i]]:="7"
	End case 
	If ($i%2=1)
		$sumOdd:=$sumOdd+Num:C11($theCheck[[$i]])
	Else 
		$sumEven:=$sumEven+Num:C11($theCheck[[$i]])
	End if 
End for 
$endNum:=$sumOdd+(2*$sumEven)
$checkStr:=String:C10($endNum)
$checkStr:=$checkStr[[Length:C16($checkStr)]]
If ($checkStr#"0")
	$checkStr:=String:C10(10-Num:C11($checkStr))
End if 
$0:="1Z"+$theOriginal+$checkStr