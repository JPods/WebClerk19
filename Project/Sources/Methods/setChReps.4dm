//%attributes = {"publishedWeb":true}
If (False:C215)
	//01/27/03.prf
	//Changed <>aReps to show up to 253 names, if > 253, add "Search" at top.
	VERSION_9919
	VERSION_9919_VAN
End if 
CREATE SET:C116([Rep:8]; "Current")
READ ONLY:C145([Rep:8])
QUERY:C277([Rep:8]; [Rep:8]active:21=True:C214)

//If (Records in selection([Rep])>120)
//array TEXT(<>aReps;2)
//ARRAY REAL(<>aRepRate;2)
//<>aReps{2}:="Search"
//<>aRepRate{2}:=0
//Else 
//SELECTION TO ARRAY([Rep]RepID;<>aReps;[Rep]ComRate;<>aRepRate)
//SORT ARRAY(<>aReps;<>aRepRate)
//INSERT ELEMENT(<>aReps;1;1)
//INSERT ELEMENT(<>aRepRate;1;1)
//End if 

If (Records in selection:C76([Rep:8])>253)
	ORDER BY:C49([Rep:8]; [Rep:8]repid:1)
	REDUCE SELECTION:C351([Rep:8]; 253)
	SELECTION TO ARRAY:C260([Rep:8]repid:1; <>aReps; [Rep:8]comRate:13; <>aRepRate)
	SORT ARRAY:C229(<>aReps; <>aRepRate)
	INSERT IN ARRAY:C227(<>aReps; 1; 1)
	INSERT IN ARRAY:C227(<>aRepRate; 1; 1)
	<>aReps{1}:="Search"
	<>aRepRate{1}:=0
	INSERT IN ARRAY:C227(<>aReps; 1; 1)
	INSERT IN ARRAY:C227(<>aRepRate; 1; 1)
Else 
	SELECTION TO ARRAY:C260([Rep:8]repid:1; <>aReps; [Rep:8]comRate:13; <>aRepRate)
	SORT ARRAY:C229(<>aReps; <>aRepRate)
	INSERT IN ARRAY:C227(<>aReps; 1; 1)
	INSERT IN ARRAY:C227(<>aRepRate; 1; 1)
End if 

<>aRepRate{1}:=0
<>aReps{1}:="Rep"
<>aReps:=1
READ WRITE:C146([Rep:8])
USE SET:C118("Current")
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([Rep:8])