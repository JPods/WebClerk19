//%attributes = {"publishedWeb":true}
//Method: Http_MinOf2Values
C_TEXT:C284($1; $2; $3; $4)
C_LONGINT:C283($0; $pCR; $p1; $p2)
$pCr:=Position:C15("\r"; $2)
$p1:=Position:C15($3; $2)  //itemNum
$p2:=Position:C15($4; $2)  //p_Ln
Case of 
	: ($1="MaxOrCR")
		Case of 
			: ((($p1>0) & ($p1<$p2) & ($p1<$pCR)) | (($p1>0) & ($p2=0)) | (($p1>0) & ($p1<$p2) & ($pCR=0)))
				$0:=$p1
				
			: ((($p2>0) & ($p2<$pCR)) | (($p2>0) & ($pCR=0)))
				$0:=$p2
			Else 
				$0:=$pCR
				
		End case 
	: ($1="MinOrCR")
		
		
		
	: ($1="Max")
		
	: ($1="Max")
		
	: ($1="Max")
		
End case 