//%attributes = {}
//Method:  BOM_Export_fdi
//Author:  James W. Medlen
//Created: July 22, 2009
//Purpose: Custom BOM Export to FDI Server
// ### jwm ### 20150514_0932 set path for Mac and PC
// ### jwm ### 20160713_1619 remove illegal characters


C_LONGINT:C283($i; $k; $sameLevel; $levelCnt; $result; $1)
C_REAL:C285($lnTotal)
ARRAY REAL:C219(aReal3; 0)
C_TEXT:C284($strAtLevel)
optKey:=0
C_TEXT:C284($myDocName; $itemName; $vtYear; $vtMonth; $vtDate; $vtTime; $pathName; $file)
Path_Set(Storage:C1525.folder.jitExportsF)

//save Date Time of BOM Export
[Item:4]dtReviewed:85:=(Current date:C33-!1990-01-01!)*86400+Current time:C178
SAVE RECORD:C53([Item:4])
jDateTimeRecov([Item:4]dtReviewed:85; ->iLoDate8)

$vtYear:=String:C10(Year of:C25(Current date:C33); "0000")
$vtMonth:=String:C10(Month of:C24(Current date:C33); "00")
$vtDay:=String:C10(Day of:C23(Current date:C33); "00")
$vtDate:=$vtYear+$vtMonth+$vtDay
$vtTime:=String:C10(Current time:C178)
$vtTime:=Replace string:C233($vtTime; ":"; "")
$itemName:=[Item:4]itemNum:1+"_"+$vtDate+"_"+$vtTime+".txt"
// ### jwm ### 20150514_0932 set path for Mac and PC
If (Is macOS:C1572)
	$pathName:="FDI:BOMs:"
Else 
	$pathName:="\\\\FDI-NAS\\FDI\\BOMs\\"
	$itemName:=Preg Replace("[\\/\\:\\\\|?\\*<>\"]"; "_"; $itemName; Regex Multi Line+Regex Ignore Case)  // ### jwm ### 20160713_1619 remove illegal characters
End if 
//$pathName:="FDI:BOMs:"
//$pathName:="FDI:CIS:Temp:"
$file:=$pathName+$itemName
myDoc:=Create document:C266($file)


If (False:C215)
	$temName:="BOM - "+[Item:4]itemNum:1+" - "+String:C10(Current date:C33)+".txt"
	//$myDocName:=TC_PutFilename("Name BOM Document";$temName;Storage.folder.jitExportsF)
	
	If ($myDocName#"")
		myDoc:=Create document:C266($myDocName)
	Else 
		OK:=0
	End if 
End if 

If (OK=1)
	If (Size of array:C274(aBomRecs)=0)
		Bom_CostItems
	End if 
	For ($i; 1; Size of array:C274(aBOMLevel))
		$levelCnt:=MaxValueReturn(aBOMLevel{$i}; $levelCnt)
	End for 
	ARRAY REAL:C219(aReal3; $levelCnt)
	//  ARRAY TEXT(aText1;10+$levelCnt)//should be 9, 1 added just for debug
	$levelCnt:=$levelCnt+2  //add two tabs to all actions with this
	SEND PACKET:C103(myDoc; [Item:4]itemNum:1+"\t"+"\t"+"Exported By:"+"\t"+Current user:C182+"\t"+String:C10(Current date:C33)+"\t"+String:C10(Current time:C178)+"\r"+"\r")
	SEND PACKET:C103(myDoc; "New Build"+"\t"+"Unit Cost"+"\t"+"On Hand"+"\t"+"On SO"+"\t"+"On PO"+"\r")  //+vTab+"On WO")
	SEND PACKET:C103(myDoc; String:C10(vR1; <>tcFormatUC)+"\t"+String:C10([Item:4]costAverage:13*Num:C11([Item:4]profile4:38#"Expensed"))+"\t"+String:C10([Item:4]qtyOnHand:14)+"\t"+String:C10([Item:4]qtyOnSalesOrder:16)+"\t"+String:C10([Item:4]qtyOnPo:20)+"\r"+"\r")  //+vTab+""
	SEND PACKET:C103(myDoc; "Seq #"+"\t"+"Level"+"\t"+"Ext'd Qty"+"\t"+"Unit Cost"+"\t"+"Cost at Level"+"\t"+"Sub Qty"+"\t"+"Item Number"+"\t"+"Description"+"\r")  //###jwm### 20090721 added Description
	$k:=Size of array:C274(aRptPartNum)
	$sameLevel:=1
	//  $MastTotal:=0
	$lnTotal:=0
	//  
	For ($i; 1; $k)
		Case of 
			: ($i=$k)
				aReal3{$sameLevel}:=aReal3{$sameLevel}+(aQtyPlan{$i}*aCosts{$i})
				$strAtLevel:=String:C10(aReal3{aBOMLevel{$i}})
			: (aBOMLevel{($i+1)}<aBOMLevel{$i})
				aReal3{$sameLevel}:=aReal3{$sameLevel}+(aQtyPlan{$i}*aCosts{$i})
				$strAtLevel:=String:C10(aReal3{$sameLevel})
				aReal3{$sameLevel}:=0
				$sameLevel:=aBOMLevel{$i+1}
			: (aBOMLevel{($i+1)}>aBOMLevel{$i})
				aReal3{$sameLevel}:=aReal3{$sameLevel}+(aQtyPlan{$i}*aCosts{$i})
				$sameLevel:=aBOMLevel{$i+1}
			Else   //      : (aBOMLevel{($i+1)}=aBOMLevel{$i})
				aReal3{$sameLevel}:=aReal3{$sameLevel}+(aQtyPlan{$i}*aCosts{$i})
				$strAtLevel:=""
		End case 
		//    
		//SEND PACKET(myDoc;String(aBOMPlace{$i})+"\t"+String(aBOMLevel{$i})+"\t"+String(aQtyAct{$i})+"\t"+String(aCosts{$i})+"\t"+$strAtLevel+(aBOMLevel{$i}*"\t")+String(aQtyPlan{$i})+"\t"+aRptPartNum{$i}+"\t"+aRptPartDsc{$i}+(($levelCnt-aBOMLevel{$i})*"\t")+"\r")
		//Romove Indenting by BOM Level ###jwm### 20090721
		SEND PACKET:C103(myDoc; String:C10(aBOMPlace{$i})+"\t"+String:C10(aBOMLevel{$i})+"\t"+String:C10(aQtyAct{$i})+"\t"+String:C10(aCosts{$i})+"\t"+$strAtLevel+"\t"+String:C10(aQtyPlan{$i})+"\t"+aRptPartNum{$i}+"\t"+aRptPartDsc{$i}+"\r")
		
	End for 
	SEND PACKET:C103(myDoc; (3*"\t")+"Level 1"+"\t"+String:C10(aReal3{1})+"\r")
	ARRAY LONGINT:C221(aSOs; Size of array:C274(aRptPartNum))
	BOM_SortbyPar
	SORT ARRAY:C229(aStr35; a80Str1; aReal1; aReal2; aLongInt1)
	$k:=Size of array:C274(aStr35)
	//  SEND PACKET(myDoc;vCR+vCR+"BOM Cost"+vTab+String($MastTotal))
	SEND PACKET:C103(myDoc; "\r"+"\r"+"Summary By Item Num"+"\r"+"\r")
	//SEND PACKET(myDoc;"Item Number"+"\t"+"Description"+"\t"+"Total Qty"+"\t"+"Unit Cost"+"\r"+"\r")
	
	SEND PACKET:C103(myDoc; "Item Number"+"\t"+"Total Qty"+"\t"+"Unit Cost"+"\t"+"Description"+"\r")
	
	PUSH RECORD:C176([Item:4])
	For ($i; 1; $k)
		//SEND PACKET(myDoc;aStr35{$i}+"\t"+a80Str1{$i}+"\t"+String(aReal2{$i})+"\t"+String(aReal1{$i})+"\r")
		//moved description to last column for readability
		SEND PACKET:C103(myDoc; aStr35{$i}+"\t"+String:C10(aReal2{$i})+"\t"+String:C10(aReal1{$i})+"\t"+a80Str1{$i}+"\r")
		
	End for 
	POP RECORD:C177([Item:4])
	CLOSE DOCUMENT:C267(myDoc)
	tkSpreadSheet:=1
	//If ($1=1)
	//spWind:=0
	//spWind:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know
	// if the module is here
	//SP OPEN DOCUMENT (spWind;$myDocName)
	//End if 
End if 
ARRAY TEXT:C222(aText1; 0)
ARRAY REAL:C219(aReal1; 0)
ARRAY REAL:C219(aReal2; 0)
ARRAY TEXT:C222(aStr35; 0)
ARRAY LONGINT:C221(aLongInt1; 0)
ARRAY REAL:C219(aReal3; 0)
ARRAY TEXT:C222(a80Str1; 0)
ARRAY LONGINT:C221(aSOs; 0)

ALERT:C41("BOM Saved To: "+"\r"+"\r"+$file)

