//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_LONGINT:C283($mouseX;$mouseY;$mouseButton)
$formData:=New object:C1471
$formData.how_1:=Num:C11(Form:C1466.qryType=1)
$formData.how_2:=Num:C11(Form:C1466.qryType=2)
$formData.how_3:=Num:C11(Form:C1466.qryType=3)
$formData.how_4:=Num:C11(Form:C1466.qryType=4)
$formData.indexOnly:=Form:C1466.indexOnly
$formData.inSelection:=Form:C1466.inSelection
GET MOUSE:C468($mouseX;$mouseY;$mouseButton)
$wRef:=Open form window:C675("QRY_Behavior";Pop up form window:K39:11;$mouseX;$mouseY)
DIALOG:C40("QRY_Behavior";$formData)

Form:C1466.qryType:=$formData.how_1+(2*$formData.how_2)+(3*$formData.how_3)+(4*$formData.how_4)
Form:C1466.indexOnly:=$formData.indexOnly
Form:C1466.inSelection:=$formData.inSelection

action_QuickSearch 