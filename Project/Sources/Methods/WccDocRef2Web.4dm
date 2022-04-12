//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: WccDocRef2Web
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($0; $1)
$theLocation:=$1
If ($theLocation#"")
	$p:=Position:C15("jitWeb"; $theLocation)
	If ($p>0)
		$theLocation:=Substring:C12($theLocation; $p+6)
		$theLocation:=Replace string:C233($theLocation; "\\"; "/")
		$theLocation:=Replace string:C233($theLocation; ":"; "/")
		$0:="<a href="+Txt_Quoted($theLocation)+" "+"target="+Txt_Quoted("_art")+">"+$theLocation+"</a><BR>"
		If (Position:C15(".jpg"; $theLocation)>0)
			$0:=$0+"\r"+"<img src="+Txt_Quoted($theLocation)+"><BR>"
		End if 
	End if 
End if 
