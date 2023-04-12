//%attributes = {}

// Modified by: Bill James (2022-05-27T05:00:00Z)
// Method: LBX_FormDynamicSetup
// Description 
// Parameters
// ----------------------------------------------------

// From: DynamicListBoxFormDemo


Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($demoSpanText)
		C_OBJECT:C1216($form)
		C_LONGINT:C283($nCol; $i)
		
		Case of 
			: (PDDLDISP=1)
				ALL RECORDS:C47([Customer:2])
				$nCol:=3
				$form:=LBX_FromJSONDefinition(1; ->[Customer:2]; ->$nCol)  // Selection based
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				
				If (Folder separator:K24:12=":")
					$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt\"><span style=\"font-weight:bold\"> Selection Based 1</span><br/></span><br/><span style=\"font-weight:bold\"> Description: </span><br/> Querying a table that display three fields.<br/><"+"br/><span style=\"font-weight:bold\"> Table:</span> <br/> People<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/> ID, firstName, &amp; nameLast<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/> Input:<br/> $1(LONGINT) - Listbox ty"+"pe<br/> $2(POINTER) - Datasource<br/> $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/>  <span style=\"font-family:'Courier New';font-size:14pt;font-weight:normal\"><span style=\"color:#068C00;"+"font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)<br/> <span style=\"color:#0031FF\">$nCol</span>:=3 // 3 Columns</span><br/></span><span style=\"font-family:'Courier New';font-size:11pt\"><span style=\"color:#000088;font-style:i"+"talic;font-weight:bold\"> <span style=\"font-size:14pt\">LBX_FromJSONDefinition</span></span><span style=\"font-size:14pt\"> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span></span>"
				Else 
					$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"><span style=\"font-size:9pt;font-weight:normal\"><span style=\"font-size:12pt;font-weight:bold\"> Selection Based 1</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Querying a t"+"able that display three fields.<br/><br/><span style=\"font-weight:bold\"> Table:</span> <br/>  People<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/>  ID, firstName, &amp; nameLast<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br"+"/"+">  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/></span><br/></span><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';fon"+"t-weight:normal\"><span style=\"color:#00B050;font-weight:bold\"> <span style=\"font-size:10.5pt;color:#000000;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)</span></span><span s"+"tyle=\"font-size:10.5pt\"><br/> <span style=\"color:#0031FF\">$nCol</span>:=3 // 3 Columns<br/></span></span></span><span style=\"font-family:'Courier New';font-size:10.5pt\"><span style=\"color:#000088;font-style:italic;font-weight:bold\"> generateListboxFor"+"mJSONDef</span> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span>"
				End if 
				
				demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
				
			: (PDDLDISP=2)
				ALL RECORDS:C47([Customer:2])
				$nCol:=4
				$form:=LBX_FromJSONDefinition(1; ->[Customer:2]; ->$nCol)  // Selection based
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				
				If (Folder separator:K24:12=":")
					$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt\"><span style=\"font-weight:bold\"> Selection Based 2</span><br/></span><br/><span style=\"font-weight:bold\"> Description: </span><br/> Querying a table that display four fields.<br/><b"+"r/><span style=\"font-weight:bold\"> Table:</span> <br/> People<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/> ID, firstName, nameLast, &amp; DOB<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/> Input:<br/> $1(LONGINT) - Listbo"+"x type<br/> $2(POINTER) - Datasource<br/> $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/>  <span style=\"font-family:'Courier New';font-size:14pt;font-weight:normal\"><span style=\"color:#068"+"C00;font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)<br/> <span style=\"color:#0031FF\">$nCol</span>:=4 // 4 Columns</span><br/></span><span style=\"font-family:'Courier New';font-size:11pt\"><span style=\"color:#000088;font-sty"+"le:italic;font-weight:bold\"> <span style=\"font-size:14pt\">LBX_FromJSONDefinition</span></span><span style=\"font-size:14pt\"> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span></span>"
				Else 
					$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"><span style=\"font-size:9pt;font-weight:normal\"><span style=\"font-size:12pt;font-weight:bold\"> Selection Based 2</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Querying a t"+"able that display four fields.<br/><br/><span style=\"font-weight:bold\"> Table:</span> <br/>  People<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/>  ID, firstName, nameLast, &amp; age<br/><br/><span style=\"font-weight:bold\"> Usage:</span"+"><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/></span><br/></span><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New"+"';font-weight:normal\"><span style=\"color:#00B050;font-weight:bold\"> <span style=\"font-size:10.5pt;color:#000000;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)</span></span><s"+"pan style=\"font-size:10.5pt\"><br/> <span style=\"color:#0031FF\">$nCol</span>:=4 // 4 Columns<br/></span></span></span><span style=\"font-family:'Courier New';font-size:10.5pt\"><span style=\"color:#000088;font-style:italic;font-weight:bold\"> generateListb"+"oxFormJSONDef</span> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span>"
				End if 
				demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
				
			: (PDDLDISP=3)
				ARRAY TEXT:C222(arrNames; 0)
				ARRAY TEXT:C222(PDDL; 0)
				ARRAY TEXT:C222(PDDL1; 0)
				
				APPEND TO ARRAY:C911(arrNames; "PDDL")
				APPEND TO ARRAY:C911(arrNames; "PDDL1")
				
				For ($i; 1; 19)
					APPEND TO ARRAY:C911(PDDL; String:C10($i))
					APPEND TO ARRAY:C911(PDDL1; Char:C90($i+65))
				End for 
				
				$form:=LBX_FromJSONDefinition(2; ->arrNames)  // Array based
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				
				If (Folder separator:K24:12=":")
					$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt;font-weight:bold\"> Array Based</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display two arrays.<br/><br/><span style=\"font-weight:bold\"> Array:</span> "+"<br/>  PDDL &amp; PDDL1<br/><br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><br/><span style=\""+"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-size:14pt;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> ARRAY TEXT</span>(<span style=\"color:#0000FF\">arrNames</span>;0)<br/><span style=\"color:#068C00;font"+"-weight:bold\"><span style=\"color:#000000;font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"color:#000000;font-weight:normal\"> </span>APP"+"END TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL1\")<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> LBX_FromJSONDefinition</span> (2;-&gt;<span style=\"color:#0000FF\">arrNames</span>)</span></span></span>"
				Else 
					$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\">Array Based</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display two arrays.<br/><br/><span style=\"font-weight:bold\"> Array:</span> <br/>  PDDL &amp; PDDL1<br/><br/><br/"+"><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:</span"+"><br/><span style=\"font-family:'Courier New';font-size:11pt;color:#000088;font-style:italic;font-weight:bold\"> <span style=\"font-size:10.5pt;color:#000000;font-style:normal;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\">ARRAY TEXT</s"+"pan>(<span style=\"color:#0000FF\">arrNames</span>;0)<br/> <span style=\"color:#068C00;font-weight:bold\">APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"color:#00000"+"0;font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL1\")<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> LBX_FromJSONDefinition</span> (2;-&gt;<span style=\"color:#0000FF\">arrName"+"s</span>)</span></span></span>"
				End if 
				
				demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
				
			: (PDDLDISP=4)
				ARRAY TEXT:C222(colNames0; 0)
				CLEAR VARIABLE:C89(colNames0)
				APPEND TO ARRAY:C911(colNames0; "This.fname")
				APPEND TO ARRAY:C911(colNames0; "This.lname")
				APPEND TO ARRAY:C911(colNames0; "This.age")
				
				C_COLLECTION:C1488(colLB1)
				
				colLB1:=New collection:C1472(New object:C1471("fname"; "Bob"; "lname"; "James"; "age"; 39); New object:C1471("fname"; "Vinn"; "lname"; "Michaels"; "age"; 38))
				$form:=LBX_FromJSONDefinition(3; ->colLB1; ->colNames0)  // Collection
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				
				If (Folder separator:K24:12=":")
					$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt\"><span style=\"font-weight:bold\"> Collection Based</span><br/></span><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display a collection.<br/><br/><span style=\"font-"+"weight:bold\"> Collection:</span> <br/>  colLB1<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><span style=\"font-weight:"+"bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-size:11pt;font-weight:normal\"><span style=\"font-size:9pt\"><span style=\"font-size:14pt;color:#068C00;font-weight:bold\"> <span style=\"font-size:12pt\">C_COLLECTION</span></span><span style=\"f"+"ont-size:12pt\">(<span style=\"color:#0000FF\">colLB1</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames0</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"> CLEAR VARIABLE</span>(<spa"+"n style=\"color:#0000FF\">colNames0</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames0</span>;\"This.fname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<spa"+"n style=\"color:#0000FF\">colNames0</span>;\"This.lname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames0</span>;\"This.age\") </span></span><span style=\"font-size:12pt\"><br/></span></span></sp"+"an><span style=\"font-family:'Courier New';font-size:12pt\"> <br/><span style=\"color:#0000FF\"> colLB1</span>:=<span style=\"color:#068C00;font-weight:bold\">New collection</span>(<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Bob\""+"; \\<br/> \"lname\";\"James\";\"age\";39);<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Vinn\";\\<br/> \"lname\";\"Michaels\";\"age\";38))<br/><br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> LBX_FromJSONDefinition</"+"span> (3;-&gt;<span style=\"color:#0000FF\">colLB1;-&gt;colNames0</span>)</span></span>"
				Else 
					$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"> Collection Based</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display a collection.<br/><br/><span style=\"font-weight:bold\"> Collection:</span> <br/>  colLB1<br/><br/><"+"span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New'"+";font-size:11pt;font-weight:normal\"><span style=\"font-size:9pt\"><span style=\"color:#068C00;font-weight:bold\"> C_COLLECTION</span>(<span style=\"color:#0000FF\">colLB1</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> ARRAY TEXT</span>(<span styl"+"e=\"color:#0000FF\">colNames0</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"> CLEAR VARIABLE</span>(<span style=\"color:#0000FF\">colNames0</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#00"+"00FF\">colNames0</span>;\"This.fname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames0</span>;\"This.lname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span sty"+"le=\"color:#0000FF\">colNames0</span>;\"This.age\") </span><br/></span></span><span style=\"font-family:'Courier New';font-size:11pt\"> <br/><span style=\"font-size:9pt\"><span style=\"color:#0000FF\"> colLB1</span>:=<span style=\"color:#068C00;font-weight:bold\""+">New collection</span>(<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Bob\"; \\<br/> \"lname\";\"James\";\"age\";39);<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Vinn\";\\<br/> \"lname\";\"Michaels\";\"age\";38))</s"+"pan><br/><br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> <span style=\"font-size:9pt\">LBX_FromJSONDefinition</span></span><span style=\"font-size:9pt\"> (3;-&gt;<span style=\"color:#0000FF\">colLB1;-&gt;colNames0</span>)</span></sp"+"an></span>"
				End if 
				
				demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
				
			: (PDDLDISP=5)
				C_OBJECT:C1216(eSel)
				ARRAY TEXT:C222(colNames1; 0)
				APPEND TO ARRAY:C911(colNames1; "This.nameFirst")
				APPEND TO ARRAY:C911(colNames1; "This.nameLast")
				
				eSel:=ds:C1482.People.all()
				$form:=LBX_FromJSONDefinition(4; ->eSel; ->colNames1)  // Entity Collection #1
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				
				If (Folder separator:K24:12=":")
					$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt;font-weight:bold\"> Entity Selection Based 1</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Using ORDA to display records with Entity Selection.<br/><br/>"+"<span style=\"font-weight:bold\"> Object:</span> <br/>  eSel<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br"+"/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-size:11pt;font-weight:normal\"><span style=\"font-size:14pt;color:#068C00;font-weight:bold\"> C_OBJECT</span><span style=\"font-size:14pt\">(<span style=\"color:#"+"0000FF\">eSel</span>)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"color:#000000;font-weight:normal\"> </span>ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames1</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"><span style"+"=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames1</span>;\"This.nameFirst\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#00"+"00FF\">colNames1</span>;\"This.nameLast\")<br/><br/><span style=\"color:#0000FF\"> eSel</span>:=<span style=\"color:#068C00;font-weight:bold\">ds</span><span style=\"color:#532300\">.People</span>.<span style=\"color:#5F8E5E;font-style:italic\">all</span>()<br/>"+"<span style=\"color:#000088;font-style:italic;font-weight:bold\"><span style=\"font-weight:normal\"> </span>LBX_FromJSONDefinition</span> (4;-&gt;<span style=\"color:#0000FF\">eSel</span>;-&gt;<span style=\"color:#0000FF\">colNames1</span>)</span></span><"+"/span></span>"
				Else 
					$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"> Entity Selection Based 1</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Using ORDA to display records with Entity Selection.<br/><br/><span style=\"font-weight:bold\"> Obje"+"ct:</span> <br/>  eSel<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><span style=\"font-weight"+":bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-size:10.5pt;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> C_OBJECT</span>(<span style=\"color:#0000FF\">eSel</span>)<br/><span style=\"color:#068C00;font-weight:bold\"><sp"+"an style=\"color:#000000;font-weight:normal\"> </span>ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames1</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#"+"0000FF\">colNames1</span>;\"This.nameFirst\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames1</span>;\"This.nameLast\")<br/><br/><span style=\"color:#0000"+"FF\"> eSel</span>:=<span style=\"color:#068C00;font-weight:bold\">ds</span><span style=\"color:#532300\">.People</span>.<span style=\"color:#5F8E5E;font-style:italic\">all</span>()<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"><span styl"+"e=\"font-weight:normal\"> </span>LBX_FromJSONDefinition</span> (4;-&gt;<span style=\"color:#0000FF\">eSel</span>;-&gt;<span style=\"color:#0000FF\">colNames1</span>)</span></span></span>"
				End if 
				
				demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
				
			: (PDDLDISP=6)
				C_OBJECT:C1216(eSel1)
				ARRAY TEXT:C222(colNames2; 0)
				APPEND TO ARRAY:C911(colNames2; "This.id")
				APPEND TO ARRAY:C911(colNames2; "This.nameFirst")
				APPEND TO ARRAY:C911(colNames2; "This.nameLast")
				
				eSel1:=ds:C1482.People.all()
				$form:=LBX_FromJSONDefinition(4; ->eSel1; ->colNames2)  // Entity Collection #2
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				
				If (Folder separator:K24:12=":")
					$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt;font-weight:bold\"> Entity Selection Based 2</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Using ORDA to display records with Entity Selection.<br/><br/>"+"<span style=\"font-weight:bold\"> Object:</span> <br/>  eSel1<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><s"+"pan style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> <span style=\"font-size:14pt\">C_OBJECT</span></span><span style=\"font-size:14pt\">(<span style=\"color:#000"+"0FF\">eSel1</span>)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames2</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:no"+"rmal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.id\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;"+"\"This.nameFirst\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.nameLast\")<br/><br/><span style=\"color:#0000FF\"> eSel1</span>:=<span "+"style=\"color:#068C00;font-weight:bold\">ds</span><span style=\"color:#532300\">.People</span>.<span style=\"color:#5F8E5E;font-style:italic\">all</span>()<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"><span style=\"font-weight:normal\"> "+"</span>LBX_FromJSONDefinition</span> (4;-&gt;<span style=\"color:#0000FF\">eSel1</span>;-&gt;<span style=\"color:#0000FF\">colNames2</span>)</span></span></span></span>"
				Else 
					$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"> Entity Selection Based 2</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Using ORDA to display records with Entity Selection.<br/><br/><span style=\"font-weight:bold\"> Obje"+"ct:</span> <br/>  eSel1<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><span style=\"font-weight:bol"+"d\"> Sample:<br/><span style=\"font-family:'Courier New';font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> <span style=\"font-size:10.5pt\">C_OBJECT</span></span><span style=\"font-size:10.5pt\">(<span style=\"color:#0000FF\">eSel1</span>)<br/"+"><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames2</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND T"+"O ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.id\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.nameFirst\")<br/>"+"<span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.nameLast\")<br/><br/><span style=\"color:#0000FF\"> eSel1</span>:=<span style=\"color:#068C00;f"+"ont-weight:bold\">ds</span><span style=\"color:#532300\">.People</span>.<span style=\"color:#5F8E5E;font-style:italic\">all</span>()<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"><span style=\"font-weight:normal\"> </span>generateListbox"+"FormJSONDef</span> (4;-&gt;<span style=\"color:#0000FF\">eSel1</span>;-&gt;<span style=\"color:#0000FF\">colNames2</span>)</span></span></span></span>"
				End if 
				
				demoText:=Replace string:C233($demoSpanText; "\\\""; "\"")
		End case 
		
		OBJECT SET SUBFORM:C1138(*; "Subform"; $form)
End case 