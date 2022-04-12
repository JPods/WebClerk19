//%attributes = {"publishedWeb":true}
ARRAY TEXT:C222(ailoText1; 1)
ARRAY TEXT:C222(ailoText2; 1)
ARRAY TEXT:C222(ailoText3; 1)
ARRAY TEXT:C222(ailoText4; 0)
C_TEXT:C284($proReason)
C_LONGINT:C283($w; $i; $k; $p)
ailoText1{1}:="jitProgramming"
ailoText2{1}:="value"
ailoText3{1}:="Explanation"
$error:=HFS_CatToArray(Storage:C1525.folder.jitPrefPath; "ailoText4")
$k:=Size of array:C274(ailoText4)
For ($i; $k; 1; -1)
	$p:=0
	If (ailoText4{$i}="P_@")
		$p:=Position:C15(".txt"; ailoText4{$i})
		If ($p>0)
			ailoText4{$i}:=Substring:C12(ailoText4{$i}; 3; Length:C16(ailoText4{$i})-6)
		End if 
	End if 
	If ($p=0)
		DELETE FROM ARRAY:C228(ailoText4; $i; 1)
	End if 
End for 
INSERT IN ARRAY:C227(ailoText4; 1; 1)
ailoText4{1}:="Tools"
ailoText4:=1


