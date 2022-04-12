//%attributes = {"publishedWeb":true}
If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 635; 475; 8)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 
QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9=Current user:C182; *)
QUERY:C277([Proposal:42];  | [Proposal:42]takenBy:61=Current user:C182; *)
QUERY:C277([Proposal:42];  & [Proposal:42]complete:56=False:C215)
ProcessTableOpen(->[Proposal:42])