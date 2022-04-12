var $reset_i : Integer
var $char_t : Text

If ((questionCnt_i<101) | (questionCnt_i>=900))
	questionCnt_i:=101
Else 
	$char_t:=String:C10(questionCnt_i)[[1]]
	questionCnt_i:=((Num:C11($char_t)+1)*100)+1
End if 

