//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/21/21, 12:18:51
// ----------------------------------------------------
// Method: 00_Convert
// Description
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	var obRec; obSel : Object
	obSel:=ds:C1482.RemoteUser.all()
	For each (obRec; obSel)
		obRec.tableNum:=STR_GetTableNumber(obRec.tableName)
		obRec.save()
	End for each 
End if 
// replace TableName with dataClassName

//
var $rec_o; $sel_o; $rec_ol; $sel_ol : Object
var $dc : Object
var $property : Text
var $cnt : Integer
$dc:=ds:C1482["OrderLine"]
$sel_o:=ds:C1482.Order.all()
For each ($rec_o; $sel_o)
	$sel_ol:=ds:C1482.OrderLine.query("idNumOrder = :1"; $rec_o.idNum).orderBy("seq")
	$rec_o.lines:=New object:C1471
	$cnt:=0
	For each ($rec_ol; $sel_ol)
		$cnt:=$cnt+1
		var $ln_o : Object
		$ln_o:=New object:C1471(\
			"seq"; $cnt; \
			"lineNum"; $cnt; \
			"date"; New object:C1471(\
			"document"; !00-00-00!; \
			[OrderLine:49]dateProcessed:59; !00-00-00!; \
			[OrderLine:49]dateRequired:23; !00-00-00!; \
			[OrderLine:49]dateShipOn:38; !00-00-00!; \
			[OrderLine:49]dateShipped:39; !00-00-00!; \
			"source"; New object:C1471(\
			"vendor"; New object:C1471(\
			"id"; $rec_ol["vendorID"]; \
			"itemNum"; $rec_ol["itemNumAlt"]); \
			"mfr"; New object:C1471(\
			"id"; $rec_ol["mfrID"]; \
			"itemNum"; $rec_ol["itemNumAlt"])); \
			"location"; New object:C1471("num"; 0; "bin"; ""; \
			"latlng"; Null:C1517; "warehouse"; ""; \
			"siteID"; "siteID"); \
			"po"; Null:C1517; \
			"proposal"; Null:C1517; \
			"serial"; Null:C1517; \
			"history"; Null:C1517; \\
			"profile"; New object:C1471("type"; $rec_ol.typeItem; \
			"class"; $rec_ol.class); \
			"tax"; New object:C1471("juris"; $rec_ol.taxJuris))
		
		
		For each ($property; $dc)
			Case of 
				: (($property="seq") || ($property="lineNum") || ($property="idNumOrder"))
					
				: (($property="vendorID") || ($property="itemNumAlt") || ($property="mfrID"))
					
					
				: ($property="loca@")
					
					
				: ($property="profil@")
					
				: ($property="ob@")
					
				: ($property="po@")
					
				Else 
					$ln_o[$property]:=$rec_ol[$property]
			End case 
		End for each 
		$rec_o.lines[String:C10($cnt)]:=$ln_o
	End for each 
	$rec_o.save()
End for each 



