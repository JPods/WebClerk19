//%attributes = {"publishedWeb":true}
//Procedure: GL2_PeachTree
TRACE:C157
KeyModifierCurrent
C_LONGINT:C283(viSaveChoice)
viSaveChoice:=0
If ((OptKey=1) | (CmdKey=1))
	viSaveChoice:=1
End if 
GL_Post2PeachTr(->[SalesJournal:50]; False:C215; 1)
GL_Post2PeachTr(->[CashJournal:52]; False:C215; 1)
GL_Post2PeachTr(->[PurchaseJournal:51]; False:C215; 1)