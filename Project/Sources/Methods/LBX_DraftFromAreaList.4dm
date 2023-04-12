//%attributes = {}
C_LONGINT:C283($1; $2)

var $working_t : Text
var $lines_c; $polished_c; $values_c : Collection
var $column_o; $final_o : Object
var $p : Integer
$final_o:=New object:C1471("LB_NameThis"; New object:C1471("type"; "listbox"; \
"left"; 88; \
"top"; 459; \
"width"; 1298; \
"height"; 363; \
"alternateFill"; "#FFFCCC"; \
"movableRows"; False:C215; \
"listboxType"; "collection"; \
"dataSource"; "LB_NameThis_sel"; \
"currentItemSource"; "Form;C1466.LB_NameThis_cur"; \
"currentItemPositionSource"; "Form;C1466.LB_NameThis_pos"; \
"selectedItemsSource"; "Form;C1466.LB_NameThis_sel"; \
"method"; ""; \
"events"; New collection:C1472("onClick"; "onHeaderClick"; "onDataChange"; "onSelectionChange"); \
"columns"; New collection:C1472))


// MustFixQQQZZZ: Bill James (2022-01-09T06:00:00Z)

var $inc; $cnt; $stdWidth : Integer
var $arrays_c; $widths_c; $names_c : Collection
var $stdName : Text

$polished_c:=New collection:C1472
$lines_c:=Split string:C1554(Get text from pasteboard:C524; "\r")
For each ($working_t; lines_c)
	$p:=Position:C15("AL_Set"; $working_t)
	$working_t:=Replace string:C233($working_t; "; "; "")
	$working_t:=Replace string:C233($working_t; "\""; "")
	
	Case of 
		: (Position:C15("AL_SetArrayNam"; $working_t)>0)
			$arrays_c:=Split string:C1554(Substring:C12($working_t; $p+10); ";")
		: (Position:C15("AL_SetWidths"; $working_t)>0)
			$widths_c:=Split string:C1554(Substring:C12($working_t; $p+10); ";")
		: (Position:C15("AL_SetHeaders"; $working_t)>0)
			$names_c:=Split string:C1554(Substring:C12($working_t; $p+10); ";")
		Else 
	End case 
End for each 

$cnt:=$arrays_c.length-1
For ($inc; 3; $cnt)  // account for the zeroth element
	If ($names_c[$inc]=Null:C1517)
		$stdName:="NA"+String:C10($inc+1)
	Else 
		$stdName:=$names_c[$inc]
	End if 
	If ($widths_c[$inc]=Null:C1517)
		$stdWidth:=70
	Else 
		$stdWidth:=$widths_c[$inc]
	End if 
	
	$column_o:=New object:C1471("header"; New object:C1471("name"; "header_LB_Name_"+$arrays_c[$inc]; "text"; $stdName); \
		"footer"; New object:C1471("name"; "Footer_LB_Name_"+$arrays_c[$inc]))
	
End for 

