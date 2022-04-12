//%attributes = {"publishedWeb":true}
C_DATE:C307($1; $PeriodDate; $PeriodEnd)
C_LONGINT:C283($i; $k)
C_TEXT:C284($tallyItem)
C_BOOLEAN:C305($stopLoop)
$stopLoop:=False:C215

$vLdiffBeg:=DateTime_Enter($PeriodDate; ?23:59:59?)
$vLdiffEnd:=DateTime_Enter(Current date:C33; ?23:59:59?)
If (Count parameters:C259=1)
	$PeriodDate:=$1
	$PeriodEnd:=Date_ThisMon($1; 1)
	OK:=1
Else 
	$PeriodEnd:=Date_ThisMon(Current date:C33; 1)
	$PeriodDate:=Date_ThisMon(Current date:C33; 0)
	CONFIRM:C162("Tally End of Month inventory value for each item for "+String:C10($PeriodEnd)+".")
End if 
If (OK=1)
	ARRAY REAL:C219($aQtyOH; 0)
	ARRAY REAL:C219($aUnitCost; 0)
	ARRAY REAL:C219($aNonProd; 0)
	ARRAY REAL:C219($aDuty; 0)
	ARRAY REAL:C219($aExtValue; 0)
	If (Current date:C33>$PeriodEnd)
		C_LONGINT:C283($vLdiffBeg; $vLdiffEnd)
		$vLdiffBeg:=DateTime_Enter($PeriodDate; ?00:00:00?)
		$vLdiffEnd:=DateTime_Enter(Current date:C33; ?23:59:59?)
	End if 
	ALL RECORDS:C47([Item:4])
	$k:=Records in selection:C76([Item:4])
	If ($k>0)
		ORDER BY:C49([Item:4]tallyByType:19; [Item:4]type:26; [Item:4]itemNum:1)
		FIRST RECORD:C50([Item:4])
		$i:=0
		$tallyItem:="34aasdfgba"
		//ThermoInitExit ("Tally EOM Inventory Value";$k;True)
		$viProgressID:=Progress New
		
		While (($i<$k) & (Record number:C243([Item:4])>-1))
			If (([Item:4]tallyByType:19) & ($tallyItem#[Item:4]type:26))
				$tallyItem:=[Item:4]type:26
			Else 
				$tallyItem:=[Item:4]itemNum:1
			End if 
			If (($tallyItem#[Usage:5]itemNum:1) | ([Usage:5]periodDate:2#$PeriodDate))
				QUERY:C277([Usage:5]; [Usage:5]itemNum:1=$tallyItem; *)
				QUERY:C277([Usage:5];  & [Usage:5]periodDate:2=$PeriodDate)
				If (Records in selection:C76([Usage:5])=0)
					CREATE RECORD:C68([Usage:5])
					[Usage:5]periodDate:2:=$PeriodDate
					[Usage:5]itemNum:1:=$tallyItem
					
				End if 
			End if 
			[Usage:5]inventoryActual:6:=0  //reset to zero if it has be done before      
			Repeat 
				$i:=$i+1
				//Thermo_Update ($i)
				ProgressUpdate($viProgressID; $i; $k; "Tally EOM Inventory Value")
				
				If (<>ThermoAbort)
					$i:=$k
				End if 
				[Usage:5]inventoryEOMCount:37:=[Usage:5]inventoryEOMCount:37+[Item:4]qtyOnHand:14
				[Usage:5]inventoryActual:6:=[Usage:5]inventoryActual:6+([Item:4]costAverage:13*[Item:4]qtyOnHand:14)
				If ([Usage:5]inventoryActual:6>0)
					[Usage:5]actualTurns:24:=Round:C94(([Usage:5]costActual:17/[Usage:5]inventoryActual:6)*12; 1)
				Else 
					[Usage:5]actualTurns:24:=0
				End if 
				If ([Usage:5]salesActual:10>0)
					[Usage:5]marginFactor:15:=Round:C94((([Usage:5]salesActual:10-[Usage:5]costActual:17)/[Usage:5]salesActual:10)*[Usage:5]actualTurns:24; 1)
				Else 
					[Usage:5]marginFactor:15:=0
				End if 
				QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Item:4]itemNum:1; *)
				QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=$vLdiffBeg; *)
				QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=$vLdiffEnd)
				SELECTION TO ARRAY:C260([DInventory:36]qtyOnHand:2; $aQtyOH; [DInventory:36]unitCost:7; $aUnitCost; [DInventory:36]nonProdCost:25; $aNonProd; [DInventory:36]duties:26; $aDuty)
				C_LONGINT:C283($indRay; $cntRay)
				$cntRay:=Size of array:C274($aQtyOH)
				C_REAL:C285($changeQty; $changeValue)
				$changeQty:=0
				$changeValue:=0
				$changeNon:=0
				For ($indRay; 1; $cntRay)
					Case of 
						: ($aQtyOH{$indRay}#0)
							$changeQty:=$changeQty+$aQtyOH+$aQtyOH{$indRay}
							$changeValue:=$changeValue+($aQtyOH{$indRay}*$aUnitCost)
						: (($aNonProd{$indRay}#0) | ($aDuty{$indRay}#0))
							$changeNon:=$changeNon-$aNonProd{$indRay}-$aDuty{$indRay}
					End case 
				End for 
				[Usage:5]inventoryActual:6:=[Usage:5]inventoryActual:6-$changeValue-$changeNon
				NEXT RECORD:C51([Item:4])
				If ([Item:4]tallyByType:19)
					$stopLoop:=($tallyItem#[Item:4]type:26)
				Else 
					$stopLoop:=($tallyItem#[Item:4]itemNum:1)
				End if 
			Until (($i=$k) | ($stopLoop))
			SAVE RECORD:C53([Usage:5])
		End while 
		//Thermo_Close 
		Progress QUIT($viProgressID)
		
	End if 
End if 
UNLOAD RECORD:C212([Usage:5])
UNLOAD RECORD:C212([Item:4])