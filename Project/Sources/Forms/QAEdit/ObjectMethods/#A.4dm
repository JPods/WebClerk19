var $reset_i : Integer
var $char_t : Text

If ((answerCnt_i<101) | (answerCnt_i>=900))
	answerCnt_i:=101
Else 
	$char_t:=String:C10(answerCnt_i)[[1]]
	answerCnt_i:=((Num:C11($char_t)+1)*100)+1
End if 

