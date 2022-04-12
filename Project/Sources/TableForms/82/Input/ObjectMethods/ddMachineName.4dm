
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/01/18, 00:32:39
// ----------------------------------------------------
// Method: [CronJob].Input.ddMachineName
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20180101_0034 added Dropdown menu for MachineName

If (<>aMachineName>1)
	[CronJob:82]MachineName:22:=<>aMachineName{<>aMachineName}
End if 
<>aMachineName:=1
