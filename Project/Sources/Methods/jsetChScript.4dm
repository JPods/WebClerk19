//%attributes = {"publishedWeb":true}
CREATE SET:C116([QQQScript:12]; "Current")
READ ONLY:C145([QQQScript:12])
CREATE SET:C116([QQQScript:12]; "MySet")
QUERY:C277([QQQScript:12]; [QQQScript:12]Active:2=True:C214)
SELECTION TO ARRAY:C260([QQQScript:12]Title:3; <>aScripts)
SORT ARRAY:C229(<>aScripts; >)
INSERT IN ARRAY:C227(<>aScripts; 1; 1)
<>aScripts{1}:="Scripts"
<>aScripts:=1
READ WRITE:C146([QQQScript:12])
USE SET:C118("Current")
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([QQQScript:12])