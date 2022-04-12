//%attributes = {}
C_BOOLEAN:C305(<>prsWndOp)
C_LONGINT:C283($found)
//Procedure: Process_Running  //already done in the calling procedure
//TRACE
Process_InitLocal
<>prsWndOp:=True:C214
Prs_ListActive
ptCurTable:=(->[Customer:2])
C_LONGINT:C283($windHeigth)
C_LONGINT:C283($1; $currentProcess; $2; $originalProcess; $3; $syncProcess; $4; $TableNum)
C_TEXT:C284($5; $fieldValue)


$currentProcess:=$1
$originalProcess:=$2
$syncProcess:=$3
$TableNum:=$4
$fieldValue:=$5



$windH:=200

C_LONGINT:C283($center)
$center:=Screen width:C187-(Screen width:C187/2)
Open window:C153($center-150; 40; $center+150; $windH+40; -724; "Choose"; "Wind_CloseBox")
DIALOG:C40([Control:1]; "DeDup")
CLOSE WINDOW:C154
<>prsWndOp:=False:C215
<>viHasSaved:=0