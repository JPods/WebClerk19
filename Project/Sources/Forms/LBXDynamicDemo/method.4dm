
// Modified by: Bill James (2021-12-18T06:00:00Z)
// Method: LBXDynamicDemo
// Description 
// Parameters
// ----------------------------------------------------
//  Called by LBX_DemoDynamic_00


Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(jsonText; $demoSpanText)
		C_LONGINT:C283($nCol)
		ARRAY TEXT:C222(PDDLDISP; 0)
		C_OBJECT:C1216(form_o)
		form_o:=New object:C1471("setup"; New object:C1471)
		
		APPEND TO ARRAY:C911(PDDLDISP; "Selection Based 1")
		APPEND TO ARRAY:C911(PDDLDISP; "Selection Based 2")
		APPEND TO ARRAY:C911(PDDLDISP; "Array Based")
		APPEND TO ARRAY:C911(PDDLDISP; "Collection Based")
		APPEND TO ARRAY:C911(PDDLDISP; "Entity Selection Based 1")
		APPEND TO ARRAY:C911(PDDLDISP; "Entity Selection Based 2")
		APPEND TO ARRAY:C911(PDDLDISP; "MyTest11")
		APPEND TO ARRAY:C911(PDDLDISP; "MyTest22")
		
		// Display the first option on the Popup Drop Down List
		PDDLDISP:=1
		ALL RECORDS:C47([Customer:2])
		$nCol:=3
		$form:=LBX_DemoDynamic_02(5; ->[Customer:2]; ->$nCol)  // Selection based
		jsonText:=JSON Stringify:C1217($form; *)
		jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
		
		
		If (Folder separator:K24:12=":")
			$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt\"><span style=\"font-weight:bold\"> Selection Based 1</span><br/></span><br/><span style=\"font-weight:bold\"> Description: </span><br/> Querying a table that display three fields.<br/><"+"br/><span style=\"font-weight:bold\"> Table:</span> <br/> Customer<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/> ID, firstName, &amp; lastName<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/> Input:<br/> $1(LONGINT) - Listbox "+"ty"+"pe<br/> $2(POINTER) - Datasource<br/> $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/>  <span style=\"font-family:'Courier New';font-size:14pt;font-weight:normal\"><span style=\"color:#068C00;"+"font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)<br/> <span style=\"color:#0031FF\">$nCol</span>:=3 // 3 Columns</span><br/></span><span style=\"font-family:'Courier New';font-size:11pt\"><span style=\"color:#000088;font-style:i"+"talic;font-weight:bold\"> <span style=\"font-size:14pt\">LBX_DemoDynamic_02</span></span><span style=\"font-size:14pt\"> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span></span>"
		Else 
			$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"><span style=\"font-size:9pt;font-weight:normal\"><span style=\"font-size:12pt;font-weight:bold\"> Selection Based 1</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Querying a t"+"able that display four fields.<br/><br/><span style=\"font-weight:bold\"> Table:</span> <br/>  Customer<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/>  ID, firstName, &amp; lastName<br/><br/><span style=\"font-weight:bold\"> Usage:</span><b"+"r/"+">  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/></span><br/></span><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';fon"+"t-weight:normal\"><span style=\"color:#00B050;font-weight:bold\"> <span style=\"font-size:10.5pt;color:#000000;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)</span></span><span s"+"tyle=\"font-size:10.5pt\"><br/> <span style=\"color:#0031FF\">$nCol</span>:=3 // 3 Columns<br/></span></span></span><span style=\"font-family:'Courier New';font-size:10.5pt\"><span style=\"color:#000088;font-style:italic;font-weight:bold\"> generateListboxFor"+"mJSONDef</span> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span>"
		End if 
		demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
		
		
		OBJECT SET SUBFORM:C1138(*; "Subform"; $form)
End case 