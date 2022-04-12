//%attributes = {}
If (False:C215)
	Version_0602
	//TC_ReviewWindow
End if 


<>prcControl:=0
Process_InitLocal
//jSetAutoReMenus 
WindowOpenTaskOffSets
myOK:=1
DIALOG:C40([Time:56]; "diaReviewTimes")
CLOSE WINDOW:C154
TC_FillArrays(0)
// calSupport:=File([Service])//to be used for mixing calanders between files
MESSAGES ON:C181
Process_Running


