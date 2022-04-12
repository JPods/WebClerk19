If (aLoText5>0)
	[UserReport:46]Creator:6:=aLoText5{aLoText5}
	doSearch:=1
Else 
	If ([UserReport:46]Creator:6="")
		[UserReport:46]Creator:6:="SuperReport"
	End if 
End if 
URpt_SetTypePrm

//   <>yURptTypes{1}:="Other"  //1 must always be other
//   <>yURptCreatr{1}:=""
//   <>yURptTypes{2}:="SuperReport"
//   <>yURptCreatr{2}:="GTSR"
//   <>yURptTypes{3}:="QuickReport"
//   <>yURptCreatr{3}:="JITA"
//   <>yURptTypes{4}:="FootRunner"
//   <>yURptCreatr{4}:="FRmk"
//   <>yURptTypes{5}:="Text-Out"
//   <>yURptCreatr{5}:="TxtO"
//   <>yURptTypes{6}:="EDI Out"
//   <>yURptCreatr{6}:="EDIO"
//   <>yURptTypes{7}:="EDI In"
//   <>yURptCreatr{7}:="EDII"
//   <>yURptTypes{8}:="Execute"
//   <>yURptCreatr{8}:="EDIx"
//   <>yURptTypes{9}:="Service"
//   <>yURptCreatr{9}:="MySv"
//   <>yURptTypes{10}:="Schedule"
//   <>yURptCreatr{10}:="ScOp"
//   <>yURptTypes{11}:="4d Write"
//   <>yURptCreatr{11}:="BGCV"
//   <>yURptTypes{12}:="Email"
//   <>yURptCreatr{12}:="Mail"
//   <>yURptTypes{13}:="Fax Attachment"
//   <>yURptCreatr{13}:="4com"
//   <>yURptTypes{14}:="Browser"
//   <>yURptCreatr{14}:="Brow"
//   <>yURptTypes{15}:="Clip"
//   <>yURptCreatr{15}:="Clip"