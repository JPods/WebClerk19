//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/01/02
	//Who: Dan Bentson, Arkware
	//Description: Fixed divide by 0 - causing 4d to crash
	VERSION_960
End if 

// ### jwm ### 20190306_1550
// what is this graph trying to display ?
If (True:C214)
	//QtyAct;QtyPlan;InvtAct;CostAct;DaysLeadTime
	C_PICTURE:C286(vpGraph)  //Variable of graph
	ARRAY TEXT:C222(aX; 1)
	aX{1}:="Normalized"
	ARRAY REAL:C219(aY1; 1)
	ARRAY REAL:C219(aY2; 1)
	ARRAY REAL:C219(aY3; 1)
	ARRAY REAL:C219(aY4; 1)
	aY1{1}:=1
	If ($2->#0)  // prevent divide by 0
		aY2{1}:=$1->/$2->
	Else 
		aY2{1}:=0
	End if 
	aY3{1}:=$5->/30
	If ($4->#0)  // prevent divide by 0
		aY4{1}:=$3->/$4->
	Else 
		aY4{1}:=0
	End if 
	GRAPH:C169(vpGraph; 1; aX; aY1; aY2; aY3; aY4)
	GRAPH SETTINGS:C298(vpGraph; 0; 0; 0; 0; False:C215; False:C215; True:C214; "P"; "A"; "T"; "H")
	
	
Else 
	// test
	C_PICTURE:C286(vpGraph)  //Variable of graph
	ARRAY TEXT:C222($atX; 2)  //Create an array for the x-axis
	$atX{1}:="1995"  //X Label #1
	$atX{2}:="1996"  //X Label #2
	ARRAY REAL:C219($arA; 2)  //Create an array for the y-axis
	$arA{1}:=30  //Insert some data
	$arA{2}:=40
	ARRAY REAL:C219($arB; 2)  //Create an array for the y-axis
	$arB{1}:=50  //Insert some data
	$arB{2}:=80
	vType:=1  //Initialize graph type
	GRAPH:C169(vpGraph; vType; $atX; $arA; $arB)  //Draw the graph
	GRAPH SETTINGS:C298(vpGraph; 0; 0; 0; 0; False:C215; False:C215; True:C214; "France"; "USA")  //Set the legends for th
End if 
