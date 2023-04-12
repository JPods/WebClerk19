Class constructor($dataClassName : Text)
	ASSERT:C1129(Count parameters:C259=1)
	This:C1470.dataClassName:=$dataClassName
	
Function setInit($action : Text; $oldEntity : Object)->$entry_o : Object
	If ($action="")
		$action:="new"
	End if   // else clone
	var $cloneFrom : Object
	$cloneFrom:=Null:C1517
	If ($oldEntity#Null:C1517)
		$cloneFrom:=$oldEntity
	End if 
	Case of 
		: (This:C1470.dataClassName="Customer")
			$entry_o:=DB_InitCustomer("$action"; $cloneFrom)
		: (This:C1470.dataClassName="Proposal")
			$entry_o:=DB_initProposal("$action"; $cloneFrom)
		: (This:C1470.dataClassName="Order")
			$entry_o:=DB_initOrder("$action"; $cloneFrom)
		: (This:C1470.dataClassName="Invoice")
			$entry_o:=DB_initInvoice("$action"; $cloneFrom)
		: (This:C1470.dataClassName="PO")
			$entry_o:=DB_initPO("$action"; $cloneFrom)
		: (This:C1470.dataClassName="Item")
			$rec_o:=DB_InitItem("$action"; $cloneFrom)
		Else 
			$rec_o:=ds:C1482[$tableName].new()
	End case 
	var $oTM : Object
	$oTM:=ds:C1482.TallyMaster.query("tableName = :1 & purpose = :2"; This:C1470.dataClassName; $action).first()
	If ($oTM.id#Null:C1517)
		var echo_o : Object
		echo_o:=$rec_o
		$vtResponse:=ExecuteScript($oTM.script)
		// $rec_o:=echo_o
		// test to make sure was not needed
		echo_o:=New object:C1471
	End if 
	$rec_o.save()
	$entry_o:=$rec_o.toObject()
	