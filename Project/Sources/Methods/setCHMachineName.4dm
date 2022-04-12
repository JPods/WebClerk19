//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/31/17, 23:58:04
// ----------------------------------------------------
// Method: setCHMachineName
// Description
// 
//
// Parameters
// ----------------------------------------------------

QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]VariableName:7="MachineName")
ARRAY TEXT:C222(<>aMachineName; 0)
DISTINCT VALUES:C339([DefaultSetup:86]Machine:13; <>aMachineName)
SORT ARRAY:C229(<>aMachineName)
INSERT IN ARRAY:C227(<>aMachineName; 1; 2)
<>aMachineName{1}:="Machine Name"
<>aMachineName{2}:="All Machines"
<>aMachineName:=1
REDUCE SELECTION:C351([DefaultSetup:86]; 0)
