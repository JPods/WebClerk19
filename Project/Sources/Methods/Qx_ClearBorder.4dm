//%attributes = {"publishedWeb":true}
//Method: Qx_ClearBorder
//
C_TEXT:C284($workingText)
C_LONGINT:C283($p)
$workingText:=Get text from pasteboard:C524
$p:=Position:C15("jitBorder"; $workingText)
While ($p>0)
	$workingText:=Tx_ClipArround($workingText; "jitBorder"; "<&tbu2"; "<&te>")
	$p:=Position:C15("jitBorder"; $workingText)
End while 
$p:=Position:C15("&g"; $workingText)
While ($p>0)
	$workingText:=Tx_ClipArround($workingText; "&g"; "<"; ">")
	$p:=Position:C15("&g"; $workingText)
End while 
SET TEXT TO PASTEBOARD:C523($workingText)




//C_TEXT($workingText;$cmpltText;$testText;$preStr)
//$workingText:=Get text from clipboard
//$testText:=$workingText
//ARRAY TEXT($aMessPreBor;1)
//ARRAY REAL($aBoxX;1)
//ARRAY REAL($aBoxY;1)
//ARRAY REAL($aChangeX;1)
//ARRAY REAL($aChangeY;1)
//ARRAY REAL($aBoxWidth;1)
//ARRAY REAL($aBoxHeight;1)
//ARRAY TEXT($aMessStart;1)
//ARRAY TEXT($aMessBorder;1)
//ARRAY TEXT($aBordColor;1)
//ARRAY TEXT($aMessRest;1)
//$dropOut:=False
//$cmpltText:=""
//Repeat 
//$pT:=Position("<&tbu2";$workingText)
//$pP:=Position("<&pbu2";$workingText)
//If (($pT=0)&($pP=0))
//$dropOut:=True
//Else 
//$aMessPreBor{1}:=""
//$aMessStart{1}:=""
//$preStr:=""
//If ((($pT<$pP)&($pP>0))|(($pT>0)&($pP=0)))
//If ($pT>1)
//$preStr:=Substring($workingText;1;$pT-1)
//End if 
//$pEnd:=Position("<&te>";$workingText)
//$splitMess:=Substring($workingText;$pT;$pEnd+4-$pT+1)
//$workingText:=Substring($workingText;$pEnd+5)
//Else 
//If ($pP>1)
//$preStr:=Substring($workingText;1;$pT-1)
//End if 
//$pEnd:=Position(">";$workingText)
//$splitMess:=Substring($workingText;$pP;$pEnd-$pP+1)
//$workingText:=Substring($workingText;$pEnd+1)
//
//End if 
//$p:=Position("(";$splitMess)
//$aMessStart{1}:=Substring($splitMess;1;$p)
//$splitMess:=Substring($splitMess;$p+1)
//$p:=Position(",";$splitMess)
//$aBoxX{1}:=Num(Substring($splitMess;1;$p-1))
//$splitMess:=Substring($splitMess;$p+1)
//$p:=Position(",";$splitMess)
//$aBoxY{1}:=Num(Substring($splitMess;1;$p-1))
//$splitMess:=Substring($splitMess;$p+1)
//$p:=Position(",";$splitMess)
//$aBoxWidth{1}:=Num(Substring($splitMess;1;$p-1))
//$splitMess:=Substring($splitMess;$p+1)
//$p:=Position(",";$splitMess)
//$aBoxHeight{1}:=Num(Substring($splitMess;1;$p-1))
//$splitMess:=Substring($splitMess;$p+1)
////<&tbu2(571.438,50.537,72.562,36.175,0,0,,i,0,K,100,1,n,100,1,1,0,1,0
//,,t,0,"")   
//For ($incBorder;1;4)
//$p:=Position(",";$splitMess)
//$aMessPreBor{1}:=$aMessPreBor{1}+Substring($splitMess;1;$p-1)+","
//$splitMess:=Substring($splitMess;$p+1)
//End for 
//$p:=Position(",";$splitMess)
//$aMessBorder{1}:=Substring($splitMess;1;$p-1)
//If (Num($aMessBorder{1})=0)
//$aMessBorder{1}:="0.2"
//End if 
//$splitMess:=Substring($splitMess;$p+1)
//$p:=Position(",";$splitMess)
//$aBordColor{1}:=Substring($splitMess;1;$p-1)
//$aBordColor{1}:="K"
//$aMessRest{1}:=Substring($splitMess;$p+1)
//$splitMess:=""
//$cmpltText:=$cmpltText+$preStr+$aMessStart{1}+String($aBoxX{1})+","
//+String($aBoxY{1})+","+String($aBoxWidth{1})+","+String($aBoxHeight{1})+","
//+$aMessPreBor{1}+$aMessBorder{1}+","+$aBordColor{1}+","+$aMessRest{1}
//End if //case 
//Until ($dropOut)
//$cmpltText:=$cmpltText+$workingText
//SET TEXT TO CLIPBOARD($cmpltText)