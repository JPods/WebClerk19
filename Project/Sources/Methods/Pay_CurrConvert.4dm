//%attributes = {"publishedWeb":true}
C_REAL:C285($inNewDoll; $inOrig; pDiff; $theTotal)
C_LONGINT:C283(viExDisPrec)
$theTotal:=pPayment+(pDiff*bCredit)
$inNewDoll:=Round:C94($theTotal/rUExchRate; viExDisPrec)  //back to orig $, combined pay & curr diff
$inOrig:=Round:C94($theTotal/rExchRate; viExDisPrec)
pDiffCurr:=$inOrig-$inNewDoll