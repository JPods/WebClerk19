
//<declarations>
//==================================
//  Type variables 
//==================================

// $lbName;$myDoc;obFormInfo;variables
C_TEXT:C284($vtDocPath; $vtWorking)

//==================================
//  Initialize variables 
//==================================

$vtDocPath:=""
$vtWorking:=""
//</declarations>

//<declarations>
//==================================
//  Type variables 
//==================================

// $lbName;$myDoc;obFormInfo
C_TEXT:C284($vtDocPath; $vtWorking)

//==================================
//  Initialize variables 
//==================================

$vtDocPath:=""
$vtWorking:=""
//</declarations>

C_TIME:C306($myDoc)
C_TEXT:C284($vtWorking; $vtDocPath; $lbName)
$lbName:="LB_Draft"
obFormInfo:=New object:C1471
obFormInfo:=LB_Draft

//OB GET PROPERTY NAMES
