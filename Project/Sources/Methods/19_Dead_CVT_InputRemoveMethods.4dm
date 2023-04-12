//%attributes = {}
////%attributes = {"publishedWeb":true}

//// ----------------------------------------------------
//// User name (OS): Bill James
//// Date and time: 2021-09-9=02, 13:32:33
//// ----------------------------------------------------
//// Method: 19CVT_InputRemoveMethods
//// Description
//// 
//// Parameters
//// ----------------------------------------------------

//// consolidated into FormDev19_RemoveMethods
//// HOWTO: Exchanges objects, change property

//If (False)

//var $1; $pathBase_t; $pathForm_t; $pathFolder_t; $pathSource_t; $pathDestination_t : Text

//If (Count parameters=1)
//$pathBase_t:=$1
//$pathForm_t:=$pathBase_t+"form.4DForm"
//Else 
//$pathBase_t:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/TableForms/3/Input/"
//$pathBase_t:="/Users/williamjames/Documents/CommerceExpert/_testing/"
//$pathBase_t:=Convert path POSIX to system($pathBase_t)
//$pathForm_t:=$pathBase_t+"form.4DForm"

//If (Test path name($pathFolder_t)=Is a folder)
//var $created : Boolean
//// Folder($pathFolder_t).delete(Delete with contents)
//DELETE FOLDER($pathFolder_t; Delete with contents)
//// $created:=Folder($pathFolder_t).create()
//CREATE FOLDER($pathFolder_t; *)
//End if 
//End if 
//If ($pathForm_t#"")
//If (Test path name($pathForm_t)#Is a document)
//ConsoleLog("Bad Path: "+$pathForm_t)
//Else 
//$pathSource_t:=Convert path POSIX to system("/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/TableForms/3/InputDS/ObjectMethods/")
//var $sourceSave_o; $sourcePrevious_o; $sourceNext_o; $sourceCancel_o; $sourcePage_o; $copied_o : Object

//$pathDestination_t:=$pathBase_t+"ObjectMethods"+Folder separator
//If (Test path name($pathDestination_t)=Is a folder)
//COPY DOCUMENT($pathSource_t+"PalletSave.4dm"; $pathDestination_t+"PalletSave.4dm"; *)
//COPY DOCUMENT($pathSource_t+"PalletPrevious.4dm"; $pathDestination_t+"PalletPrevious.4dm"; *)
//COPY DOCUMENT($pathSource_t+"PalletNext.4dm"; $pathDestination_t+"PalletNext.4dm"; *)
//COPY DOCUMENT($pathSource_t+"PalletCancel.4dm"; $pathDestination_t+"PalletCancel.4dm"; *)
//COPY DOCUMENT($pathSource_t+"PalletPage.4dm"; $pathDestination_t+"PalletPage.4dm"; *)
//End if 



//var $working_t; $reworked_t; $property_t; $fieldName_t; $tableName; $reNameProperty_t : Text
//var $asIS_o; $pageObjects_o; $field_o; $reworkedPage_o; $workingPage_o : Object
//var $pages_c; $pageArrange_c : Collection


//$working_t:=Document to text($pathForm_t)
////SET TEXT TO PASTEBOARD($working_t)
//$asis_o:=JSON Parse($working_t)
//$pages_c:=$asis_o.pages

//$pageCount_i:=$asis_o.pages.length

//var $pageCount_i : Integer
//$pageCount_i:=-1

//var $oTemp : Object
//var $replace_c : Collection


//For each ($workingPage_o; $asis_o.pages)
//$pageCount_i:=$pageCount_i+1

//$replace_c:=New collection  // reset for each page

//If ($workingPage_o#Null)
//$pageObjects_o:=$asis_o.pages[$pageCount_i].objects
//If ($pageObjects_o#Null)
//var $cnt_i : Integer
//$cnt_i:=-1
//For each ($property_t; $pageObjects_o)
//$cnt_i:=$cnt_i+1
//Case of 
//: ($pageObjects_o[$property_t].dataSource=Null)
//If ($pageObjects_o[$property_t].method#Null)
//OB REMOVE($pageObjects_o[$property_t]; "method")
////$pageObjects_o[$property_t].method:=""
//End if 
//If ($pageObjects_o[$property_t].events#Null)
////$pageObjects_o[$property_t].events:=New collection
//OB REMOVE($pageObjects_o[$property_t]; "events")
//End if 

//: ($pageObjects_o[$property_t].dataSource="bAccept")
//$pageObjects_o[$property_t].method:="ObjectMethods/PalletSave.4dm"
//$pageObjects_o[$property_t].events:=New collection("onClick")
////$pageObjects_o[$property_t]:="PalletAccept"  // this wipes out the whole object. 
////  perhaps copy the  object and replace it, build a collection
//$replace_c.push(New object("existing"; $property_t; "changeTo"; "PalletAccept"; "replace"; $pageObjects_o[$property_t]))

//: ($pageObjects_o[$property_t].dataSource="bPrevious")
//$pageObjects_o[$property_t].method:="ObjectMethods/PalletPrevious.4dm"
//$pageObjects_o[$property_t].events:=New collection("onClick")
////$pageObjects_o[$property_t]:="PalletPrevious"  // change its property last
//$replace_c.push(New object("existing"; $property_t; "changeTo"; "PalletPrevious"; "replace"; $pageObjects_o[$property_t]))

//: ($pageObjects_o[$property_t].dataSource="bNext")
//$pageObjects_o[$property_t].method:="ObjectMethods/PalletNext.4dm"
//$pageObjects_o[$property_t].events:=New collection("onClick")
////$pageObjects_o[$property_t]:="PalletNext"
//$replace_c.push(New object("existing"; $property_t; "changeTo"; "PalletNext"; "replace"; $pageObjects_o[$property_t]))

//: ($pageObjects_o[$property_t].dataSource="bCancel")
//$pageObjects_o[$property_t].method:="ObjectMethods/PalletCancel.4dm"
//$pageObjects_o[$property_t].events:=New collection("onClick")
////$pageObjects_o[$property_t]:="PalletCancel"
//$replace_c.push(New object("existing"; $property_t; "changeTo"; "PalletCancel"; "replace"; $pageObjects_o[$property_t]))

//: ($pageObjects_o[$property_t].dataSource="aPages")
//$pageObjects_o[$property_t].method:="ObjectMethods/PalletPage.4dm"
//$pageObjects_o[$property_t].events:=New collection("onClick")
////$pageObjects_o[$property_t]:="PalletPage"
//$replace_c.push(New object("existing"; $property_t; "changeTo"; "PalletPage"; "replace"; $pageObjects_o[$property_t]))

//Else 
//If ($pageObjects_o[$property_t].method#Null)
//OB REMOVE($pageObjects_o[$property_t]; "method")
////$pageObjects_o[$property_t].method:=""
//End if 
//If ($pageObjects_o[$property_t].events#Null)
////$pageObjects_o[$property_t].events:=New collection
//OB REMOVE($pageObjects_o[$property_t]; "events")
//End if 
//End case 
//End for each 


//If (True)
//For each ($oEach; $replace_c)
//$pageObjects_o:=19_Dead_Property_Rename($pageObjects_o; $oEach.existing; $oEach.changeTo)
//End for each 
//Else 
//// do this for each page, replace the existing object with the replace object
//var $oEach : Object
//For each ($oEach; $replace_c)
//OB REMOVE($pageObjects_o; $oEach.existing)
//OB SET($pageObjects_o; $oEach.changeTo; $oEach.replace)
//End for each 
//End if 

//End if 
//End if 
//End for each 
//$reworked_t:=JSON Stringify($asis_o)
////SET TEXT TO PASTEBOARD($reworked_t)
//TEXT TO DOCUMENT($pathForm_t; $reworked_t)
//End if 
//End if 

//End if 