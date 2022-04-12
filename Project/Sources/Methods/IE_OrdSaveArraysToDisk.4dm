//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  IE_OrdSaveArraysToDisk 
	//Desc.:  Wrapper routine to create & save [Customer], [Order] & [OrdLine] recs
	//NB:      
	//CB:   IE_OrdImportOrdLines   
	//New:    04/17/2000.nds   
End if 

MESSAGES OFF:C175
//C_TEXT($1)


C_LONGINT:C283($lCust; $lOrdr)

$soa:=Size of array:C274(atCustomerImport)

ARRAY TEXT:C222(asIEOrdImportcustomerID; $soa)
ARRAY TEXT:C222(asIEOrdActualcustomerID; $soa)

For ($lCust; 1; $soa)
	IE_OrdParseCustomerImport($lCust)
End for 

For ($lOrdr; 1; Size of array:C274(atOrderImport))
	
	MESSAGE:C88("Saving Orders to disk: "+String:C10($lOrdr))
	IE_OrdParseOrderImport($lOrdr)
End for 

MESSAGES ON:C181

ALERT:C41("Import Complete")  //:  "+$1)

REDRAW WINDOW:C456

//End of routine