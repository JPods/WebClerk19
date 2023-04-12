//%attributes = {}

// Modified by: Bill James (2022-01-15T06:00:00Z)
// Method: Splash_TableLists
// Description
// Parameters
// ----------------------------------------------------
#DECLARE($lbName : Text)
var $tableList_t; $1; $lbName : Text
$lbName:=$1
var $event_o; obDisplay : Object
var $viRow; viRow : Integer
$event_o:=FORM Event:C1606

Case of 
	: (Form event code:C388=On Load:K2:1)
		// load the appropriate listbox
		If ($lbName="LB_Primes")
			STR_PrimeListBox($lbName)
		Else 
			STR_TablesListBox($lbName)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		// act on the appropriate listbox
		var $data; $rec : Object
		// $new_o:=cs.TableShow.new("Customer")
		var $new_o : cs:C1710.cProcess
		Case of 
			: ($lbName="LB_Primes")
				$new_o:=cs:C1710.cProcess.new("OutputDS"; Form:C1466[$lbName].cur.tableName)
				If ($data#Null:C1517)
					//$new_o.setSource(ds[Form[$lbName].cur.tableName].all())
					$new_o.setSource($data)  // if there is a exiting data set desired
				End if 
				// $new_o becomes process_o in the new process
				$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$new_o.dataClassName; $new_o)
			: ($lbName="DataBrowser")
				var $new_o : cs:C1710.cProcess
				$new_o:=cs:C1710.cProcess.new("DataBrowser"; Form:C1466.LB_Tables.cur.tableName; Current process:C322)
				$processNum:=New process:C317("LBX_DataBrowser"; 0; "DataBrowser"; $new_o)
		End case 
		//release any data and objects referenced
		$new_o.destructor()
		DELAY PROCESS:C323(Current process:C322; 30)
		CALL WORKER:C1389("Processes"; "Process_ListActive")
		
		
End case 