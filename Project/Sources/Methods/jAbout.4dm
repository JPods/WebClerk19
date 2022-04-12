//%attributes = {"publishedWeb":true}

//IGLLINXVersion 

C_TEXT:C284(vDataStored; vAppStored)
<>vDataStored:=Data file:C490
<>vAppStored:=Structure file:C489
GOTO RECORD:C242([DefaultAccount:32]; 0)
vi1:=[DefaultAccount:32]rs1t:68  //Serial Number
vi2:=[DefaultAccount:32]rs2t:69  //Registration Number
UNLOAD RECORD:C212([DefaultAccount:32])
jCenterWindow(570; 414; 1)
DIALOG:C40([Control:1]; "jAbout")
CLOSE WINDOW:C154
<>vDataStored:=""
<>vAppStored:=""
