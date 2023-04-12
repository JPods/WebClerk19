//%attributes = {}

// Modified by: Bill James (2022-12-31T06:00:00Z)
// Method: LBX_ColumnImportName
// Description 
// Parameters
// ----------------------------------------------------

// changed from LBName to dataClassName so they can be more easily used in multiple Listboxes
#DECLARE($fieldName_t : Text; $columnAdder_t : Text)->$column_o : Object
$column_o:=New object:C1471
$column_o.name:="Column_Import_"+$fieldName_t+"_"+$columnAdder_t
$column_o.dataSource:="This."+$fieldName_t
$column_o.fieldType:=Value type:C1509($fieldName_t)

$column_o.header:=New object:C1471("name"; "Header_Import_"+$fieldName_t+"_"+$columnAdder_t; \
"text"; $fieldName_t)

$column_o.footer:=New object:C1471("name"; "Footer_Import_"+$fieldName_t+"_"+$columnAdder_t)

$column_o.width:=100
$column_o.alignment:=Align left:K42:2
$column_o.alignment:=Align left:K42:2

Case of 
	: ($column_o.fieldType=Is time:K8:8)
		$column_o.width:=70
		$column_o.alignment:=Align center:K42:3
		$column_o.format:=HH MM AM PM:K7:5
		//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
	: (($column_o.fieldType=Is alpha field:K8:1) | ($column_o.fieldType=Is text:K8:3) | ($column_o.fieldType=Is string var:K8:2))
		Case of 
			: ($fieldName_t="@phone@")
				$column_o.width:=100
				$column_o.alignment:=Align left:K42:2
				$column_o.format:="(###) ###-#### #### ####"
			: ($fieldName_t="@creditcardnum@")
				$column_o.alignment:=Align left:K42:2
				$column_o.format:="xxxx-xxxx-xxxx-####"
			: ($fieldName_t="@zip@")
				$column_o.width:=70
			: ($fieldName_t="state")
				$column_o.width:=60
			: ($fieldName_t="@description@")
				$column_o.width:=220
		End case 
		
	: ($column_o.fieldType=Is date:K8:7)
		$column_o.width:=70
		$column_o.alignment:=Align center:K42:3
		$column_o.format:=System date short:K1:1
		
		
	: ($column_o.fieldType=Is boolean:K8:9)
		$column_o.width:=40
		$align:=Align center:K42:3
		$column_o.format:=" "
		//LISTBOX SET COLUMN WIDTH(*; $vtColumnName; 40)
		//OBJECT SET HORIZONTAL ALIGNMENT(*; $vtColumnName; Align center)
		
		
	: ($column_o.fieldType=Is real:K8:4)
		$column_o.width:=100
		Case of 
			: (($fieldName_t="@cost@") | ($fieldName_t="@price@"))
				$column_o.format:="###,###,###,###,##0.00"
				
			: (($fieldName_t="@rate@") | ($fieldName_t="discount"))
				$column_o.format:="###,###,##0.0"
				
			: ($fieldName_t="@wt@")
				$column_o.width:=60
				$column_o.format:="###,###,##0.0"
				
			: ($fieldName_t="@tax@")
				$column_o.width:=70
				$column_o.format:="###,###,###,###,##0.00"
			Else 
				
		End case 
		
	: ($column_o.fieldType=Is integer:K8:5)
		$column_o.width:=100
		$column_o.alignment:=Align right:K42:4
		Case of 
			: ($fieldName_t="DT@")
				
				
				
		End case 
End case 


/*
"resizable": false,
"resizable": true,

"enterable": true
"enterable": false

"truncateMode": "withEllipsis",
"truncateMode": "none",

"wordwrap" : "normal", 
"wordwrap": "none",

"visibility": "hidden",
"visibility": "visible",

"textFormat" : {
"$ref" : "/SOURCES/filters.json#/Phone _"
},
"textFormat": {
"$ref": "/SOURCES/filters.json#/##/##/####"
},


"entryFilter": {
"$ref": "/SOURCES/filters.json#/##/##/####"
},



"requiredList": {
"$ref": "/SOURCES/lists.json#/FieldsNames"
},
"excludedList": {
"$ref": "/SOURCES/lists.json#/FontList"
}


{
"header": {
"text": "Header1",
"name": "Header1"
},
"name": "Column1",
"footer": {
"name": "Footer1"
},

"fontFamily": "Adobe Caslon Pro",
"fontSize": 18,
"fontWeight": "bold",
"fontStyle": "italic",
"textDecoration": "underline",
"stroke": "#ff6347",
"textAlign": "center",
"verticalAlign": "top",
"styledText": true
}

*/

