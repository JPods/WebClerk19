//%attributes = {"publishedWeb":true}
//Procedure: Http_ListMore
C_TEXT:C284($1)  //Command to search, ie "/item_List/?"
C_TEXT:C284($2)  //pageOne to use
C_TEXT:C284($3)  //pageList to use
C_TEXT:C284($4)  //target to use
C_TEXT:C284($5)  //Sequence to Use  "jitSkip"
C_POINTER:C301($6)  //File to use
C_POINTER:C301($7; $8)  //list of fields and values to search

//REDUCE SELECTION([Item];<>viMaxShow)
//Else 
ARRAY LONGINT:C221($aRecNums; 0)
ARRAY LONGINT:C221($aTheList; 0)
C_LONGINT:C283($seqNum; $i; $w)
$seqNum:=Num:C11($5)
Case of 
	: (($num<=100) | ($seqNum<=60))
		$i:=10
	: ($seqNum+60>$num)
		$i:=$num-100
	: ($seqNum>60)
		$i:=$seqNum-50
	Else 
		$i:=$seqNum
End case 

While (($num>$i) & (Size of array:C274($aTheList)<10))
	$w:=Size of array:C274($aTheList)+1
	INSERT IN ARRAY:C227($aTheList; $w; 1)
	$aTheList{$w}:=$i
	$i:=$i+10
End while 
If ($i>=($seqNum+90))
	$w:=Size of array:C274($aTheList)+1
	INSERT IN ARRAY:C227($aTheList; $w; 1)
	$aTheList{$w}:=$i
End if 
C_TEXT:C284(vListMore)
vListMore:=""
For ($i; 1; Size of array:C274($aTheList))
	If ($seqNum=$aTheList{$i})
		vListMore:=vListMore+String:C10($aTheList{$i}\10)+" - "
	Else 
		vListMore:=vListMore+"<a href="+Char:C90(34)+$1+"?"+$nextTarget+"&jitskip="+String:C10($aTheList{$i})
		If ($2#"")
			vListMore:=vListMore+"&jitPageOne="+$2
		End if 
		If ($3#"")
			vListMore:=vListMore+"&jitPageList="+$3
		End if 
		C_LONGINT:C283($i; $k)
		$k:=Count parameters:C259
		For ($i; 6; $k; 2)  //skip first 3
			If ($keyWord#"")
				vListMore:=vListMore+"&"+${$i}+"="+${$i+1}
			End if 
		End for 
		If (<>doeventID)
			vListMore:=vListMore+"jitUser="+String:C10(vleventID)
		End if 
		Case of 
			: (($aTheList{1}>10) & ($i=1))
				vListMore:=vListMore+Char:C90(34)+$jitTarget+">"+"Previous 10 </a> -  "
			: (($i=Size of array:C274($aTheList)) & ($aTheList{$i}<$num))
				vListMore:=vListMore+Char:C90(34)+$jitTarget+">"+"Next 10 </a>"
			Else 
				vListMore:=vListMore+Char:C90(34)+$jitTarget+">"+String:C10($aTheList{$i}\10)+"</a> - "
		End case 
	End if 
End for 
SELECTION RANGE TO ARRAY:C368($seqNum; $seqNum+10; $6->; $aRecNums)
CREATE EMPTY SET:C140($6->; "Current")
For ($i; 1; 10)
	GOTO RECORD:C242($6->; $aRecNums{$i})
	ADD TO SET:C119($6->; "Current")
End for 
USE SET:C118("Current")
CLEAR SET:C117("Current")