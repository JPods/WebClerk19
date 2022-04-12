////WO_FillArrays (-7)//sort arrays
//$woSize:=Size of array(aWoStepLns)
//KeyModifierCurrent 
//If ((optKey=0)&($woSize>0)&(eWorkFlow#0))
//C_DATE($testDate)
//$testDate:=aWoDateNd{aWoStepLns{1}}
//For ($i;$woSize;1;-1)
//If (aWoDateNd{aWoStepLns{$i}}#$testDate)
//DELETE ELEMENT(aWoStepLns;$i;1)
//End if 
//End for 
//$woSize:=Size of array(aWoStepLns)
//// -- AL_SetSelect (eWorkFlow;aWoStepLns)
//vDate1:=aWoDateNd{aWoStepLns{1}}
//If (<>aNameID>1)
//vText1:=<>aNameID{<>aNameID}
//Else 
//vText1:=<>aActivities{<>aActivities}
//End if 
//Tm_Wo2Time (aTimeSlotBegb;aTimeSlotEndb;aTimeSlotTypeb;aTimeSlotWhatb;aTimeSlotActionb
//;aTimeSlotWORecb;eTimeList;vText1;vDate1)
//End if 