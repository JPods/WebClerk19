//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/28/02
	//Who: Dan Bentson, Arkware
	//Description: sped up code to look in arrays instead of requerying when possible
	
	//Date: 03/05/02
	//Who: Dan Bentson, Arkware
	//Description: added calc of qty on hand and tally
	VERSION_960
End if 

C_LONGINT:C283($w)
C_TEXT:C284($1; $5)
C_REAL:C285($2)
C_DATE:C307($3)
C_TEXT:C284($4)
C_TEXT:C284($6)
C_LONGINT:C283($7; $8)
C_POINTER:C301($9)
$w:=Size of array:C274(aFCRecNum)+1
FC_FillRay(-3; $w; 1)
aFCItem{$w}:=$1  //item number
aFCBomCnt{$w}:=$2  //total quantity  
aFCActionDt{$w}:=$3  //date needed
aFCBomLevel{$w}:=$4  //level, root, intermediate, primary
aFCParent{$w}:=$5  //parent part
aFCTypeTran{$w}:=$6  //type of transaction (SO, PO, WO)
aFCDocID{$w}:=$7  //Sales Orders  
aFCRecNum{$w}:=$8  //record number
aFCWho{$w}:=$9->  //Who

// try to find qty and usage from a previous record.  If not then add it
//C_Longint($fia)
//$fia:=Find in array(aFCShortItem;$1)
//If ($fia#-1)
//aFCBaseQty{$w}:=aFCShortBaseQty{$fia}
//aFCTallyYTD{$w}:=aFCShortTallyYTD{$fia}
//aFCTallyLess1Year{$w}:=aFCShortTallyLess1Year{$fia}
//aFCTallyLess2Year{$w}:=aFCShortTallyLess2Year{$fia}
//Else 
//C_DATE($ytdDate;$ytdDateLess1;$ytdDateLess2)
//CREATE SET([Item];"Current")// save selection
//QUERY([Item];[Item]ItemNum=$1)
//aFCBaseQty{$w}:=[Item]QtyOnHand
//USE SET("Current")
//$ytdDate:=Date_ThisYear (Current date;0)
//$ytdDateLess1:=Date_ThisYear ($ytdDate-1;0)
//$ytdDateLess2:=Date_ThisYear ($ytdDateLess1-1;0)
//aFCTallyYTD{$w}:=FC_SumYear ($1;$ytdDate)
//aFCTallyLess1Year{$w}:=FC_SumYear ($1;$ytdDateLess1)
//aFCTallyLess2Year{$w}:=FC_SumYear ($1;$ytdDateLess2)

//INSERT ELEMENT(aFCShortItem;1)
//INSERT ELEMENT(aFCShortBaseQty;1)
//INSERT ELEMENT(aFCShortTallyYTD;1)
//INSERT ELEMENT(aFCShortTallyLess1Year;1)
//INSERT ELEMENT(aFCShortTallyLess2Year;1)
//aFCShortItem{1}:=aFCItem{$w}
//aFCShortBaseQty{1}:=aFCBaseQty{$w}
//aFCShortTallyYTD{1}:=aFCTallyYTD{$w}
//aFCShortTallyLess1Year{1}:=aFCTallyLess1Year{$w}
//aFCShortTallyLess2Year{1}:=aFCTallyLess2Year{$w}
//End if 






