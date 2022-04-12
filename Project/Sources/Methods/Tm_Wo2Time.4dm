//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4; $5; $6; $8)
C_DATE:C307($9)
C_LONGINT:C283($7; $i; $index; $woSize; $tmSize; $w)  //$7 area id of time list
$woSize:=Size of array:C274(aWoStepLns)
C_LONGINT:C283(eWorkFlow)
//$1  ARRAY LONGINT(aTimeSlotBeg1;0)
//$2  ARRAY LONGINT(aTimeSlotEnd1;0)
//$3  array TEXT(aTimeSlotType1;0)
//$4  ARRAY TEXT(aTimeSlotWhat1;0)
//$5  array TEXT(aTimeSlotAction1;0)
//$6  ARRAY LONGINT(aTimeSlotWORec1;0)
//If ($woSize>0)
ARRAY LONGINT:C221(aTmpInt2x1; 2; 0)  //set the color  
//  If ($woSize>0)
MESSAGES OFF:C175
If (False:C215)
	QUERY:C277([PeriodAvailable:74]; [PeriodAvailable:74]nameID:1=$8->; *)  //
	QUERY:C277([PeriodAvailable:74];  & [PeriodAvailable:74]dateOf:4=$9)  //
	ORDER BY:C49([PeriodAvailable:74]; [PeriodAvailable:74]timeBegin:2)
	MESSAGES ON:C181
	If ($7#0)
		Sch_NotAvailSet($1; $7)
	End if 
End if 
C_LONGINT:C283($k; $i)
$k:=Size of array:C274($1->)
For ($i; 1; $k)
	$2->{$i}:=0
	$3->{$i}:=""
	$4->{$i}:=""
	$5->{$i}:=""
	$6->{$i}:=-1
End for 
//
WO_FillArrays(-7)
//// -- AL_SetCellColor ($7;2;1;2;$k;aTmpInt2x1;"black";0;"white";0)
//// -- AL_SetCellColor (AreaName;Cell1Col;Cell1Row;Cell2Col;Cell2Row;
//ForeColor2;BackColor1;BackColor2)
$tmSize:=Size of array:C274($1->)
ARRAY LONGINT:C221($aConflictCount; $tmSize)
ARRAY TEXT:C222($aConflictColor; $tmSize)
ARRAY LONGINT:C221($aConflictColorBG; $tmSize)
ARRAY LONGINT:C221($aConflictColorFG; $tmSize)
For ($i; 1; $tmSize)
	$aConflictCount{$i}:=0
	$aConflictColor{$i}:=""
	$aConflictColorBG{$i}:=0
	$aConflictColorFG{$i}:=15
End for 
C_LONGINT:C283($findEmployee)
//If ($tmSize>0)
//$minTime:=$2{1}
//End if 
//    ARRAY LONGINT(aTmpInt1;0)
For ($i; 1; $woSize)
	$startTime:=aWoTimeNd{aWoStepLns{$i}}
	$duration:=aWoDurationPlan{aWoStepLns{$i}}
	$endTime:=aWoTimeNd{aWoStepLns{$i}}+(3600*$duration)
	$index:=0
	$foundWoEnd:=False:C215
	Repeat 
		$index:=$index+1
		Case of 
			: ($index=$tmSize)  //WO is greater or equal to last time segment
				If (aWoTimeNd{aWoStepLns{$i}}>=$1->{$index})
					$aConflictCount{$index}:=$aConflictCount{$index}+1
					If ($aConflictCount{$index}=1)
						$findEmployee:=Find in array:C230(<>aNameID; aWoNameID{aWoStepLns{$i}})
						If ($findEmployee<1)
							$aConflictColorBG{$index}:=0
							$aConflictColorFG{$index}:=15
						Else 
							//$aConflictColor{$index}:="green"
							$aConflictColorBG{$index}:=<>aNameColorBG{$findEmployee}
							$aConflictColorFG{$index}:=<>aNameColorFG{$findEmployee}
						End if 
						//$aConflictColorBG{$index}:=0x00FF0000
						//$aConflictColorFG{$index}:=0xFF00
						//$aConflictColorBG{$index}:=50
						//$aConflictColorFG{$index}:=200
					Else 
						$aConflictColor{$index}:="yellow"
					End if 
					If ($5->{$index}="")
						$2->{$index}:=(aWoTimeNd{aWoStepLns{$i}}+(3600*aWoDurationPlan{aWoStepLns{$i}}))*1
						$4->{$index}:=aWoDescrpt{aWoStepLns{$i}}+", (RecordNum="+String:C10(aWoRecNum{aWoStepLns{$i}})
						$5->{$index}:=Substring:C12(aWoActivity{aWoStepLns{$i}}; 1; 3)+"-"+aWoNameID{aWoStepLns{$i}}
						$6->{$index}:=aWoRecNum{aWoStepLns{$i}}
					Else 
						$4->{$index}:=$4->{$index}+"; "+aWoDescrpt{aWoStepLns{$i}}+", (RecordNum="+String:C10(aWoRecNum{aWoStepLns{$i}})
						$2->{$index}:=(aWoTimeNd{aWoStepLns{$i}}+(3600*aWoDurationPlan{aWoStepLns{$i}}))*1
						$6->{$index}:=aWoRecNum{aWoStepLns{$i}}
					End if 
				End if 
			: (($startTime>=$1->{$index}) & ($startTime<$1->{$index+1}))  //find the beginning to the WO in time array
				$aConflictCount{$index}:=$aConflictCount{$index}+1
				If ($aConflictCount{$index}=1)
					$findEmployee:=Find in array:C230(<>aNameID; aWoNameID{aWoStepLns{$i}})
					If ($findEmployee<1)
						$aConflictColorBG{$index}:=0
						$aConflictColorFG{$index}:=15
					Else 
						//$aConflictColor{$index}:="green"
						$aConflictColorBG{$index}:=<>aNameColorBG{$findEmployee}
						$aConflictColorFG{$index}:=<>aNameColorFG{$findEmployee}
					End if 
					//$aConflictColorBG{$index}:=50
					//$aConflictColorFG{$index}:=200
				Else 
					$aConflictColor{$index}:="yellow"
				End if 
				If ($5->{$index}="")
					$2->{$index}:=(aWoTimeNd{aWoStepLns{$i}}+(3600*aWoDurationPlan{aWoStepLns{$i}}))*1
					$4->{$index}:=aWoDescrpt{aWoStepLns{$i}}+", (RecordNum="+String:C10(aWoRecNum{aWoStepLns{$i}})+")"
					$5->{$index}:=Substring:C12(aWoActivity{aWoStepLns{$i}}; 1; 3)+"-"+aWoNameID{aWoStepLns{$i}}
					$6->{$index}:=aWoRecNum{aWoStepLns{$i}}
				Else 
					$4->{$index}:=$4->{$index}+"; "+aWoDescrpt{aWoStepLns{$i}}+", (RecordNum="+String:C10(aWoRecNum{aWoStepLns{$i}})+")"
					$2->{$index}:=(aWoTimeNd{aWoStepLns{$i}}+(3600*aWoDurationPlan{aWoStepLns{$i}}))*1
					$6->{$index}:=aWoRecNum{aWoStepLns{$i}}
				End if 
				
				$endTime:=aWoTimeNd{aWoStepLns{$i}}+(aWoDurationPlan{aWoStepLns{$i}}*3600)
				$endIndex:=$index+1
				While (($endTime>$1->{$endIndex}) & ($endIndex<$tmSize))
					$4->{$endIndex}:=$4->{$endIndex}+"*"
					//If (($6->{$endIndex}=-1)|($6->{$endIndex}=$6->{$endIndex-1}))
					$6->{$endIndex}:=aWoRecNum{aWoStepLns{$i}}
					//End if 
					$endIndex:=$endIndex+1
				End while 
			Else 
				
		End case 
	Until (($index=$tmSize) | ($foundWoEnd))
End for 
C_LONGINT:C283($w)
If ($7#0)
	For ($index; 1; $tmSize)
		Case of 
			: ($aConflictCount{$index}=0)
				// -- AL_SetCellColor($7; 2; $index; 2; $index; aTmpInt2x1; "black"; 0; "white"; 0)
			: ($aConflictCount{$index}=1)
				// -- AL_SetCellColor($7; 2; $index; 2; $index; aTmpInt2x1; ""; $aConflictColorFG{$index}+1; ""; $aConflictColorBG{$index}+1)
				//// -- AL_SetCellColor ($7;2;$index;2;$index;aTmpInt2x1;"white";0;"green";0)
				
			Else 
				// -- AL_SetCellColor($7; 2; $index; 2; $index; aTmpInt2x1; "Red"; 0; "Yellow"; 0)
		End case 
	End for 
	//  --  CHOPPED  AL_UpdateArrays($7; -1)
End if 
