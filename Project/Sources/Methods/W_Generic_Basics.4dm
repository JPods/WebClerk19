//%attributes = {}



// 4D_25Invoice - 2022-01-15

C_OBJECT:C1216($settings;$targetSelection)
C_LONGINT:C283($left;$top;$right;$bottom;$windowRef)
C_BOOLEAN:C305($fl_Select)

$dialog:=$1  //Name of the dialog to display

$fl_Exist:=(Storage:C1525.windowList[$dialog]#Null:C1517)  //We check if this Window already exists

If ($fl_Exist)  //If it is already in Storage
	ARRAY LONGINT:C221($ar_References;0)
	WINDOW LIST:C442($ar_References)
	$windowRef:=Storage:C1525.windowList[$dialog]
	$fl_Exist:=(Find in array:C230($ar_References;$windowRef)>0)  //...we have to verify if the window itself still exists
End if 

If ($fl_Exist)  //If yes, we just bring the Dialog to front
	SHOW WINDOW:C435($windowRef)
	
Else   //if not, we create the Dialog
	Case of 
		: ($dialog="StartupScreen")
			$windowRef:=Open form window:C675($dialog;Plain form window:K39:10;*)
			
		: ($dialog="Settings")
			$windowRef:=Open form window:C675($dialog;Controller form window:K39:17;Horizontally centered:K39:1;Vertically centered:K39:4)
			
		Else   //Generic case
			
	End case 
	
	Use (Storage:C1525)  //We add the window reference to Storage
		If (Storage:C1525.windowList=Null:C1517)
			Storage:C1525.windowList:=New shared object:C1526
		End if 
		Use (Storage:C1525.windowList)
			Storage:C1525.windowList[$dialog]:=$windowRef
		End use 
	End use 
	
	DIALOG:C40($dialog;*)  //If it does not exist, we create the Dialog (with the '*', obviously)
End if 




