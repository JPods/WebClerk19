//%attributes = {"publishedWeb":true}
//prntStateWrap//[Customer]LateNotice
C_LONGINT:C283($1)
C_LONGINT:C283($i)
C_TEXT:C284(prntTimes; prntTypeSal)
C_TEXT:C284($crStr)

C_LONGINT:C283($pages; $i; $lineCnt; $curPageLns)

$lineCnt:=16
$crStr:="###,##0.00  ;###,##0.00cr"

C_TEXT:C284($strTotal)
SRpt_StRayFill
$strTotal:=prntTotal  //work around for below (prntTotal used multi purpose)

$pages:=PageCnt(Size of array:C274(aDate1); $lineCnt)
//
$idNumForm:="0000-0000"

//
$e:=0
For ($i; 1; $pages)
	$curPageLns:=$i*$lineCnt
	vPage:="Page:  "+String:C10($i)+" of "+String:C10($pages)
	Print form:C5([Customer:2]; "prntOverDueNot")
	While ($e<$curPageLns)
		$e:=$e+1
		If ($e>Size of array:C274(aDate1))
			CLEAR VARIABLE:C89(prntCustPO)
			CLEAR VARIABLE:C89(prntOrdNum)
			CLEAR VARIABLE:C89(prntInvNum)
			CLEAR VARIABLE:C89(prntDateIn)
			CLEAR VARIABLE:C89(prntDateOut)
			CLEAR VARIABLE:C89(prntAmt)
			CLEAR VARIABLE:C89(prntTotal)
		Else 
			prntCustPO:=a25Str1{$e}
			If (aLongInt2{$e}=0)
				prntInvNum:=""
			Else 
				prntInvNum:=String:C10(aLongInt2{$e}; $idNumForm)
			End if 
			If ((aLongInt1{$e}=0) | (aLongInt1{$e}=1))
				prntOrdNum:=""
			Else 
				prntOrdNum:=String:C10(aLongInt1{$e}; $idNumForm)
			End if 
			prntDateIn:=String:C10(aDate1{$e}; 1)
			prntDateOut:=a3Str1{$e}
			prntAmt:=String:C10(aReal1{$e}; $crStr)
			prntTotal:=String:C10(aReal2{$e}; $crStr)
		End if 
		Print form:C5([Customer:2]; "StatemntLines")
	End while 
	prntTotal:=$strTotal
	//  prntTotal:=String($total;$crStr)
	Print form:C5([Customer:2]; "StateFooter")
	PAGE BREAK:C6
End for 
SRpt_StRayClr