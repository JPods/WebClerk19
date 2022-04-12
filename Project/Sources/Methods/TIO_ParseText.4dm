//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a field
C_POINTER:C301($1)  //pointer to Text:  Quoted Constant Text, ie. "Hello"
C_LONGINT:C283($pos; $soa)
$soa:=Size of array:C274(aTIOText)+1
INSERT IN ARRAY:C227(aTIOText; $soa)
aTIOText{$soa}:=""
$1->:=Substring:C12($1->; 2; Length:C16($1->)-2)  //lose quotes (")
Repeat 
	$pos:=Position:C15("\\"; $1->)
	If ($pos>0)
		Case of 
			: ($1->[[$pos+1]]="n")
				aTIOText{$soa}:=aTIOText{$soa}+Substring:C12($1->; 1; $pos-1)+"\r"
				$1->:=Substring:C12($1->; $pos+2)
			: ($1->[[$pos+1]]="t")
				aTIOText{$soa}:=aTIOText{$soa}+Substring:C12($1->; 1; $pos-1)+"\t"
				$1->:=Substring:C12($1->; $pos+2)
			: ($1->[[$pos+1]]="l")
				aTIOText{$soa}:=aTIOText{$soa}+Substring:C12($1->; 1; $pos-1)+"\n"
				$1->:=Substring:C12($1->; $pos+2)
			: ($1->[[$pos+1]]="a")
				aTIOText{$soa}:=aTIOText{$soa}+Substring:C12($1->; 1; $pos-1)+Storage:C1525.char.crlf
				$1->:=Substring:C12($1->; $pos+2)
			Else 
				aTIOText{$soa}:=aTIOText{$soa}+Substring:C12($1->; 1; $pos)
				$1->:=Substring:C12($1->; $pos+1)
		End case 
	Else 
		aTIOText{$soa}:=aTIOText{$soa}+$1->
	End if 
Until ($pos=0)
$0:=->aTIOText{$soa}