var $doExport : Integer
$doExport:=0
var $exportParams : Text
process_o.ents:=LB_DataBrowser.ents
Case of 
	: (process_o.ents=Null:C1517)
	: ((process_o.ents.length>0) & (Not:C34(Shift down:C543)) | (process_o.sel.length=0))
		$doExport:=1
		USE ENTITY SELECTION:C1513(process_o.ents)
	Else 
		$doExport:=2
		USE ENTITY SELECTION:C1513(process_o.sel)
End case 
If ($doExport>0)
	READ ONLY:C145(process_o.dataClassPtr->)
	If ($doExport=1)
		USE ENTITY SELECTION:C1513(process_o.ents)
	Else 
		USE ENTITY SELECTION:C1513(process_o.sel)
	End if 
	EXPORT DATA:C666(""; $exportParams; *)  //The export Param can be saved and reused later
	REDUCE SELECTION:C351(process_o.dataClassPtr->; 0)
End if 

