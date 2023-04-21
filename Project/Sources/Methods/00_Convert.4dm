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
		//$ln_o:=New object(\
			"seq"; $cnt; \
			"lineNum"; $cnt; \
			"date"; New object(\
			"document"; !00-00-00!; \
			"dateProcessed"; !00-00-00!"; "+\
			""dateRequired"; !00-00-00!"; \
			"dateShipOn"; !00-00-00!"; "+\
			""dateShipped"; !00-00-00!"; \
			"source"; New object(\
			"vendor"; New object(\
			"id"; $rec_ol["vendorID"]; \
			"itemNum"; $rec_ol["itemNumAlt"]); \
			"mfr"; New object(\
			"id"; $rec_ol["mfrID"]; \
			"itemNum"; $rec_ol["itemNumAlt"])); \
			"location"; New object("num"; 0; "bin"; ""; \
			"latlng"; Null; "warehouse"; ""; \
			"siteID"; "siteID"); \
			"po"; Null; \
			"proposal"; Null; \
			"serial"; Null; \
			"history"; Null; \\
			"profile"; New object("type"; $rec_ol.typeItem; \
			"class"; $rec_ol.class); \
			"tax"; New object("juris"; $rec_ol.taxJuris))
		
		
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



