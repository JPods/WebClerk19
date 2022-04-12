// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-29T00:00:00, 10:07:12
// ----------------------------------------------------
// Method: aURpLnType
// Description
// Modified: 07/29/13
// 
// 
//
// Parameters
// ----------------------------------------------------

//  zzz  aURpLnType{1}:="Record Count"
//  zzz  aURpLnType{2}:="Singles Loop"
//  zzz  aURpLnType{3}:="Custom Count"
//  zzz  aURpLnType{4}:="P_Var By Line"
//  zzz  aURpLnType{5}:="ScriptDriven"

Case of 
	: (aURpLnType=0)
		Case of 
			: ([UserReport:46]NumLines:10=0)
				aURpLnType:=1
			: ([UserReport:46]NumLines:10=-99)
				aURpLnType:=2
			: ([UserReport:46]NumLines:10=-1)
				aURpLnType:=3
			: ([UserReport:46]NumLines:10>0)
				aURpLnType:=4
			: ([UserReport:46]NumLines:10=-2)
				aURpLnType:=5
		End case 
	: (aURpLnType=1)
		[UserReport:46]NumLines:10:=0  //    "Record Count"
	: (aURpLnType=2)
		[UserReport:46]NumLines:10:=-99  //  "Singles Loop"
	: (aURpLnType=3)
		[UserReport:46]NumLines:10:=-1  //  "Custom Count"
	: (aURpLnType=4)
		[UserReport:46]NumLines:10:=15  // "P_Var By Line"
	: (aURpLnType=5)
		[UserReport:46]NumLines:10:=-2  // "P_Var By Line"
End case 