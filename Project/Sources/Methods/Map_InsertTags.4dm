//%attributes = {"publishedWeb":true}
//Method: Map_InsertTags
C_TEXT:C284($1; $2; $3; $5)  //Text;tag
C_POINTER:C301($4)
C_LONGINT:C283($p)
C_TEXT:C284($mapID)
C_TEXT:C284($bioText; $movieName)
$bioText:=""
If (Count parameters:C259<5)
	$mapID:=""
Else 
	$mapID:=$5
End if 
$p:=Position:C15($2; $1)
If ($p>0)
	Repeat 
		$bioText:=$bioText+Substring:C12($1; 1; $p-1)
		$1:=Substring:C12($1; $p+1)
		$p:=Position:C15($3; $1)
		If ($p>0)
			$movieName:=Substring:C12($1; 1; $p-1)
			$1:=Substring:C12($1; $p+1)
			QUERY:C277(Table:C252(Table:C252($4))->; $4->=$movieName)
			If (Records in selection:C76(Table:C252(Table:C252($4))->)=1)
				$movieName:=Map_Output($movieName; $2+$3; "Wrap")
			Else 
				If ($mapID#"")
					$movieName:=Map_Output($movieName; $mapID; "Wrap")
				Else 
					$movieName:=$2+$movieName+$3  //leave it as it was
				End if 
			End if 
		Else 
			$movieName:=$2+$1  //leave it as it was
		End if 
		$bioText:=$bioText+$movieName
		$p:=Position:C15($2; $1)
	Until ($p=0)
End if 
$0:=$bioText+$1