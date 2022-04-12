//%attributes = {"publishedWeb":true}
//Method: Map_Output
C_TEXT:C284($1; $0)  //(aText1{10};"ControlTag";"Wrap")
C_TEXT:C284($2; $3)  //wrap;begin;end
C_LONGINT:C283($w)
$0:=""
$w:=Find in array:C230(aMapControlTag; $2)
If ($w>0)
	Case of 
		: ($3="Wrap")
			$0:=aMapBeginTag{$w}+$1+aMapEndTag{$w}
		: ($3="begin")
			$0:=aMapBeginTag{$w}+$1
		: ($3="end")
			$0:=$1+aMapEndTag{$w}
	End case 
End if 