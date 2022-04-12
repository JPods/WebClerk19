//%attributes = {"publishedWeb":true}
//(P) jGetFileDiaMess
C_POINTER:C301($1)
vDiaCom:=$1->
Open window:C153(41; 26; 403; 247; 2)  //for type 1; 50;30;395;247
DIALOG:C40([Control:1]; "diaDiaMessage")
vDiaCom:=""
//follow with open or create document and Close window