//%attributes = {}

CONFIRM:C162("Calculate Historical Inventory for Selection"; "Calculate"; "Cancel")

If (OK=1)
	$vtDate:=Request:C163("Enter a Date"; ""; "OK"; "Cancel")
	$vdDate:=Date:C102($vtDate)
	If (OK=0)
		// report cancelled
	Else 
		If (($vdDate=!00-00-00!) | (String:C10($vdDate)=""))
			ALERT:C41("ERROR: INVALID DATE")
		Else 
			
			ARRAY TEXT:C222($atReport; 0)
			
			//C_TEXT($vResultPlan;$vResultPath)
			//DESCRIBE QUERY EXECUTION(True)  //analysis mode
			
			//QUERY BY FORMULA([Item];(([Item]Profile4="2-HA-LPC") | ([Item]Profile4="3-HA-HPC") | ([Item]Profile4="4-LA-HPC")) & ([Item]Profile1%"model"))
			
			//Profile4Count
			//2-HA-LPC903
			//3-HA-HPC174
			//4-LA-HPC120
			//5-NA-HPC271
			
			
			ds:C1482.Item.query("(profile4 = :1 or profile4 = :2 or profile4 = :3 ) and profile1 % :4"; "2-HA-LPC"; "3-HA-HPC"; "4-LA-HPC"; "model")
			
			
			//$vResultPlan:=Get last query plan(Description in text format)
			//$vResultPath:=Get last query path(Description in text format)
			
			//Console_Log ($vResultPlan)
			//Console_Log ($vResultPath)
			//Console_Log ("\r")
			
			//DESCRIBE QUERY EXECUTION(False)  //End of analysis mode
			
			$viProgressID:=Progress New
			
			
			APPEND TO ARRAY:C911($atReport; "\"id\",\"typeID\",\"itemNum\",\"qty\",\"cost\",\"value\",\"profile1\",\"profile2\",\"description\"\r")
			
			$vi2:=Records in selection:C76([Item:4])
			FIRST RECORD:C50([Item:4])
			
			For ($vi1; 1; $vi2)
				// escape sequence
				If (Shift down:C543 & Caps lock down:C547)
					$vi1:=$vi2
				End if 
				
				$vtReport:=""  // initialize report line
				
				ProgressUpdate($viProgressID; $vi1; $vi2; "Calculating Inventory...")
				
				$viDateItem:=DateTime_DTTo($vdDate; ?23:59:00?)
				
				$vdDateStart:=Add to date:C393($vdDate; -1; 0; 0)
				
				$viDateStart:=DateTime_DTTo($vdDateStart; ?23:59:00?)
				
				$vtItemNum:=[Item:4]itemNum:1
				
				//QUERY BY FORMULA([dInventory];(([dInventory]ItemNum=$vtItemNum) & ([dInventory]DTItemCard>$viDateStart) &  ([dInventory]DTItemCard<$viDateItem) & ([dInventory]QtyOnHand#0)))
				
				ds:C1482.dInventory.query("itemNum = :1 and dtItemCard > :2 and dtItemCard < :3 and qtyOnHand # 0"; $vtItemNum; $viDateStart; $viDateItem; 0)
				
				
				If (Records in selection:C76([DInventory:36])>0)
					ORDER BY:C49([DInventory:36]; [DInventory:36]dtItemCard:16; <)
					REDUCE SELECTION:C351([DInventory:36]; 1)
					
					
					If ([DInventory:36]qtyOHAfterApplied:31>0)
						
						$vtReport:="\""+[DInventory:36]id:38+"\""
						
						$vtReport:=$vtReport+",\""+[DInventory:36]typeID:14+"\""
						
						$vtReport:=$vtReport+",\""+[Item:4]itemNum:1+"\""
						
						$vtReport:=$vtReport+","+String:C10([DInventory:36]qtyOHAfterApplied:31)
						
						$vtReport:=$vtReport+","+String:C10([DInventory:36]unitCostAfterChange:35)
						
						$vrValue:=[DInventory:36]qtyOHAfterApplied:31*[DInventory:36]unitCostAfterChange:35
						
						$vtReport:=$vtReport+","+String:C10($vrValue)
						
						$vtReport:=$vtReport+",\""+[Item:4]profile1:35+"\""
						
						$vtReport:=$vtReport+",\""+[Item:4]profile2:36+"\""
						
						$vtReport:=$vtReport+",\""+[Item:4]description:7+"\""
						
						$vtReport:=$vtReport+"\r"
						
					End if 
				Else 
					If ([Item:4]qtyOnHand:14>0)
						
						$vtUUID:="\"NA\""
						
						$vtReport:=$vtUUID
						
						$vttypeID:="\"NA\""
						
						$vtReport:=$vtReport+","+$vttypeID
						
						$vtReport:=$vtReport+",\""+[Item:4]itemNum:1+"\""
						
						$vtReport:=$vtReport+","+String:C10([Item:4]qtyOnHand:14)  // qty
						
						$vtReport:=$vtReport+","+String:C10([Item:4]costAverage:13)  // cost
						
						$vtReport:=$vtReport+","+String:C10([Item:4]qtyOnHand:14*[Item:4]costAverage:13)  // value
						
						$vtReport:=$vtReport+",\""+[Item:4]profile1:35+"\""
						
						$vtReport:=$vtReport+",\""+[Item:4]profile2:36+"\""
						
						$vtReport:=$vtReport+",\""+[Item:4]description:7+"\""
						
						$vtReport:=$vtReport+"\r"
					End if 
				End if 
				If ($vtReport#"")
					APPEND TO ARRAY:C911($atReport; $vtReport)
				End if 
				
				NEXT RECORD:C51([Item:4])
				
			End for 
			
			Progress QUIT($viProgressID)
			
			UNLOAD RECORD:C212([Item:4])
			
			ALERT:C41("Choose location to save Inventory Report")
			
			$vtDate:=DateTime("yyyymmdd_hhmm")
			
			vtFile:="Inventory "+$vtDate+".csv"
			vtFolder:=Select folder:C670("Select a folder to Save Inventory Report")
			$vtPath:=vtFolder+vtFile
			
			myDoc:=Create document:C266($vtPath)
			
			vi2:=Size of array:C274($atReport)
			
			For (vi1; 1; vi2)
				SEND PACKET:C103(myDoc; $atReport{vi1})
			End for 
			
			CLOSE DOCUMENT:C267(myDoc)
			
			ALERT:C41("Report Complete")
			
			OPEN URL:C673($vtPath)
			
		End if 
		
	End if 
	
End if 

