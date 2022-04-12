//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_LONGINT:C283($2; $3; $i; $rescID)
C_PICTURE:C286(pagePict1; pagePict2; pagePict3; pagePict4; pagePict5; pagePict6; pagePict7; pagePict8)

CLEAR VARIABLE:C89(pagePict1)
CLEAR VARIABLE:C89(pagePict2)
CLEAR VARIABLE:C89(pagePict3)
CLEAR VARIABLE:C89(pagePict4)
CLEAR VARIABLE:C89(pagePict5)
CLEAR VARIABLE:C89(pagePict6)
CLEAR VARIABLE:C89(pagePict7)
CLEAR VARIABLE:C89(pagePict8)
$doPict:=False:C215
Case of 
	: (($1=(->[Control:1])) & ($3#-1))
		$rescID:=21000+$3
		$doPict:=True:C214
	: ($1#(->[Control:1]))
		$rescID:=21000+(Table:C252($1)*10)
		$doPict:=True:C214
End case 
If ($doPict)
	If ($2>0)
		GET PICTURE RESOURCE:C502($rescID; pagePict1)
		If ($2>1)
			$rescID:=$rescID+1
			GET PICTURE RESOURCE:C502($rescID; pagePict2)
			If ($2>2)
				$rescID:=$rescID+1
				GET PICTURE RESOURCE:C502($rescID; pagePict3)
				If ($2>3)
					$rescID:=$rescID+1
					GET PICTURE RESOURCE:C502($rescID; pagePict4)
					If ($2>4)
						$rescID:=$rescID+1
						GET PICTURE RESOURCE:C502($rescID; pagePict5)
						If ($2>5)
							$rescID:=$rescID+1
							GET PICTURE RESOURCE:C502($rescID; pagePict6)
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 