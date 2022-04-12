//%attributes = {"publishedWeb":true}
C_LONGINT:C283($w; $i; $j; $k; $c; $2; $4; $p)
C_POINTER:C301($1; $3)
C_LONGINT:C283(vShowCats; vTotCats)
ARRAY TEXT:C222(aShowCats; 0)
C_REAL:C285($grfMax; $grfMin)
C_PICTURE:C286(vPGraf)
TRACE:C157
$k:=Size of array:C274($1->)
ARRAY TEXT:C222(aCatagory; $k)
For ($i; 1; $k)
	aCatagory{$i}:=Substring:C12($1->{$i}; 1; 25)
End for 
INSERT IN ARRAY:C227(aCatagory; 1; 1)
aCatagory{1}:="U/D?"
ARRAY LONGINT:C221(aTally; 0)
$c:=Size of array:C274(aCatagory)
ARRAY LONGINT:C221(aTally; $c)  //make a square matrix to tally to
vTotCats:=$c-1
If (vTotCats>5)
	vShowCats:=5
Else 
	vShowCats:=vTotCats
End if 
vHeadTitle:="Pareto Analysis:  "+vPartNum
Case of 
	: ($2=1)
		vCatTitle:="Catagories:  Processes"
	: ($2=2)
		vCatTitle:="Catagories:  Attributes"
	: ($2=3)
		vCatTitle:="Catagories:  Causes"
End case 
$k:=Records in selection:C76($3->)
FIRST RECORD:C50($3->)
//If (theTypes{$2}="A")
For ($j; 1; $k)
	$w:=Find in array:C230(aCatagory; Field:C253(Table:C252($3); $4)->)
	If ($w>0)
		aTally{$w}:=aTally{$w}+1
		$p:=$w
	Else 
		If (Field:C253(Table:C252($3); $4)->="")
			aTally{1}:=aTally{1}+1
			$p:=1
		Else 
			INSERT IN ARRAY:C227(aCatagory; 2; 1)
			INSERT IN ARRAY:C227(aTally; 2; 1)
			aCatagory{2}:=Field:C253(Table:C252($3); $4)->
			aTally{2}:=1
		End if 
	End if 
	NEXT RECORD:C51($3->)
End for 
DELETE FROM ARRAY:C228(aTally; 1; 1)
DELETE FROM ARRAY:C228(aCatagory; 1; 1)
$k:=Size of array:C274(aTally)
C_LONGINT:C283($maxY)
For ($j; 1; $k)
	If ($maxY<aTally{$j})
		$maxY:=aTally{$j}
	End if 
End for 


SORT ARRAY:C229(aTally; aCatagory; <)
COPY ARRAY:C226(aCatagory; aShowCats)
$grfMax:=aTally{1}
$grfMin:=aTally{Size of array:C274(aTally)}
If (Size of array:C274(aShowCats)>vShowCats)
	DELETE FROM ARRAY:C228(aShowCats; vShowCats+1; (Size of array:C274(aShowCats)-vShowCats))
End if 
Case of 
	: ($grfMax=$grfMin)
		ALERT:C41("There are no x-axis values.")
	: (Size of array:C274(aShowCats)=0)
		ALERT:C41("There are no catagories.")
	Else 
		//TRACE
		//  http://doc.4d.com/4Dv15/4D/15.4/GRAPH.301-3273700.en.html
		// 1 column
		// 2 Proportional Columns
		// 3 Stacked Columns
		// 4 Line
		// 5 Area
		// 6 Scatter
		// 7 Pie
		// 8 Picture
		C_LONGINT:C283($grafType)
		$grafType:=1
		//
		//
		//End case 
		GRAPH:C169(vPGraf; $grafType; aShowCats; aTally)
		GRAPH SETTINGS:C298(vPGraf; 0; 0; 0; 0; False:C215; False:C215; True:C214)
		
		
		
		//GRAPH(useGraf;1;aX;aY1;aY2;aY3;aY4)
		//GRAPH SETTINGS(useGraf;0;0;0;0;False;False;True;"$";"$/R";"#I";"$I")
End case 
TRACE:C157
//XMLParseUnbalancedTags
