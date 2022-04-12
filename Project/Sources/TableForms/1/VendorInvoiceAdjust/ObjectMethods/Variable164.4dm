ARRAY LONGINT:C221(aPoLnSelct; 0)
C_LONGINT:C283($i; $k; $w)
$k:=Size of array:C274(aPOQtyNow)
iLoReal9:=0
If ($k>0)
	For ($i; 1; $k)
		If (aPOQtyNow{$i}#0)
			$w:=Size of array:C274(aPoLnSelct)+1
			INSERT IN ARRAY:C227(aPoLnSelct; $w; 1)
			aPoLnSelct{$w}:=$i
			iLoReal9:=iLoReal9+(aPOQtyNow{$i}*aPoDscntUP{$i})
		End if 
	End for 
	iLoReal10:=vrVendorInvoiceAmount-iLoReal9
	//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
	// -- AL_SetSelect(ePoLines; aPoLnSelct)
	viALVert:=aPoLnSelct{1}
	// -- AL_SetScroll(ePoLines; viALVert; viALHorz)
	
Else 
	BEEP:C151
	BEEP:C151
End if 