//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i; $k)
$k:=$1
ARRAY TEXT:C222(aVndAlpha; $k)
ARRAY TEXT:C222(aVndCompany; $k)
ARRAY LONGINT:C221(aVendRec; $k)
If ($k>0)
	MESSAGES OFF:C175
	READ ONLY:C145([Vendor:38])
	ORDER BY:C49([Vendor:38]; [Vendor:38]vendorID:1)
	FIRST RECORD:C50([Vendor:38])
	For ($i; 1; $k)
		aVndAlpha{$i}:=[Vendor:38]vendorID:1
		aVndCompany{$i}:=[Vendor:38]company:2
		aVendRec{$i}:=Record number:C243([Vendor:38])
		NEXT RECORD:C51([Vendor:38])
	End for 
	UNLOAD RECORD:C212([Vendor:38])
	READ WRITE:C146([Vendor:38])
	MESSAGES ON:C181
End if 