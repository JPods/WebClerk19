//%attributes = {"publishedWeb":true}
CREATE SET:C116(ptCurTable->; "Current")
COPY SET:C600("UserSet"; "ServerSet")
DIFFERENCE:C122("Current"; "ServerSet"; "Current")
CLEAR SET:C117("ServerSet")
USE SET:C118("Current")
CLEAR SET:C117("Current")


$setName:="<>set"+Table name:C256(ptCurTable)
CLEAR SET:C117($setName)
CREATE SET:C116(ptCurTable->; $setName)

booSorted:=False:C215

SET WINDOW TITLE:C213(Table name:C256(ptCurTable)+":  "+String:C10(Records in selection:C76(ptCurTable->))+" - "+Storage:C1525.default.company)