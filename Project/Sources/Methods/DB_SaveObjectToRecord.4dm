//%attributes = {}

// Modified by: Bill James (2022-06-28T05:00:00Z)
// Method: DB_SaveObjectToRecord
// Description 
// Parameters
// ----------------------------------------------------


#DECLARE($myObj : Object; $myRec : Object; $purpose : Text)
// #DECLARE (myObj : Object; myRec : Object; $purpose : Text)
var $dataClassName : Text

// $record:=$line.fromObject()
// fromObject only works if there is a match. It will not skip added properties

$o:=$myRec.getDataClass()
$dataClassName:=$myRec.getDataClass().getInfo().name

For each ($property; $myObj)
	If ($myRec[$property]#Null:C1517)
		Case of 
			: (($property="id@") | ($property="customerID") | ($property="vendorID"))
				
			: ($property="Parent@")
				// wipes out the values
			: ($property="Child@")
				//: ($myRec[$property]["__KEY"]#Null)
				// wipes out the values  -- must test yet
			: ($property="__KEY@")
				
			: ($property="@_KEY@")
				
			Else 
				$myRec[$property]:=$myObj[$property]
		End case 
	End if 
End for each 
If ($myRec.obGeneral=Null:C1517)
	$myRec.obGeneral:=Init_obGeneral
End if 
If ($myRec.obGeneral.history=Null:C1517)
	$myRec.obGeneral.history:=New object:C1471("revision"; 0; "dt"; New collection:C1472)
End if 
$myRec.obGeneral.history.revision:=$myRec.obGeneral.history.revision+1
// not sure I want this
//$myRec.obGeneral.history.dt.push(DateTime_DTTo)
var $tmRec : Object
If ($purpose="")
	$tmRec:=ds:C1482.TallyMaster.query("tableName = :1 AND purpose = :2"; $dataClassName; "save_general").first()
Else 
	$tmRec:=ds:C1482.TallyMaster.query("tableName = :1 AND purpose = :2"; $dataClassName; $purpose).first()
End if 
If ($tmRec.id#Null:C1517)
	myObj:=$myObj
	myRec:=$myRec
	ExecuteText($tmRec.script)
	myRec.save()
Else 
	$myRec.save()
End if 

