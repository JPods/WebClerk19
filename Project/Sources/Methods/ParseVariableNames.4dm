//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-08-05T00:00:00, 13:06:23
// ----------------------------------------------------
// Method: ParseVariableNames
// Description
// Modified: 08/05/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// Parse, search for variable names

//Script variables

//(\$.+?\b | \<>.+?\b | \bv.+?\b)


QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="cronjob@"; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]RealName1:16="Active@"; *)
QUERY:C277([TallyMaster:60])

C_TEXT:C284(vtRegex)
vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b)"
QUERY SELECTION BY FORMULA:C207([TallyMaster:60]; Preg Match(vtRegex; [TallyMaster:60]Script:9)=1)

CREATE SET:C116([TallyMaster:60]; "Script")

QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="cronjob@"; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]RealName1:16="Active@"; *)
QUERY:C277([TallyMaster:60])

C_TEXT:C284(vtRegex)
vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b)"
QUERY SELECTION BY FORMULA:C207([TallyMaster:60]; Preg Match(vtRegex; [TallyMaster:60]Build:6)=1)

CREATE SET:C116([TallyMaster:60]; "Build")
UNION:C120("Script"; "Build"; "Both")
USE SET:C118("Both")
CLEAR SET:C117("Script")
CLEAR SET:C117("Build")
CLEAR SET:C117("Both")
