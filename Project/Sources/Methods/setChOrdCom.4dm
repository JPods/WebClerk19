//%attributes = {"publishedWeb":true}
CREATE SET:C116([OrderComment:27]; "Current")
READ ONLY:C145([OrderComment:27])
QUERY:C277([OrderComment:27]; [OrderComment:27]Active:1=True:C214)
SELECTION TO ARRAY:C260([OrderComment:27]ComName:4; <>aStdOrdCom)
SORT ARRAY:C229(<>aStdOrdCom; >)
INSERT IN ARRAY:C227(<>aStdOrdCom; 1; 1)
<>aStdOrdCom{1}:="Std Comments"
<>aStdOrdCom:=1
READ WRITE:C146([OrderComment:27])
USE SET:C118("Current")
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([OrderComment:27])