//%attributes = {"publishedWeb":true}
//Procedure: Ord_PrntWorkOrd




//KeyModifierCurrent 
//If (OptKey=1)
//vText1:="0--Date; SO Num; Seq"
//vText1:=vText1+"1--TakenBy;Date;Order Number;Seq"+"\r"
//vText1:=vText1+"2--TakenBy; CustID; Date; Order Num; Seq"+"\r"
//vText1:=vText1+"3--CustID; Date; Order Num; Seq"+"\r"
//vText1:=vText1+"4--ActionBy; Date; Order Number; Seq"+"\r"
//vText1:=vText1+"5--Activity; ActionBy; Date; Order Number; Seq"+"\r"
//vText1:=vText1+"6--Activity; Date; ActionBy; Order Number; Seq"+"\r"
//vText1:=vText1+"7--Activity; Date; Order Number; Seq; ActionBy"+"\r"
//vText1:=vText1+"8--WoCode; ActionBy; Date; Order Number; Seq"
//vText1:=vText1+"9--Order Number; Seq"+"\r"
//SET TEXT TO CLIPBOARD(vText1)
//End if 
//C_LONGINT($1;$sortSeq)
//C_LONGINT($cntOrd;$cntWO;$indexOrd;$indexWO;$w)
//If (Count parameters=1)
//$sortSeq:=$1
//Else 
//$sortSeq:=0
//End if 
//$cntOrd:=Records in selection([Order])
//If ($cntOrd>0)
//$indexOrd:=0
//Temp_RayInit 
//ARRAY TEXT(aText1;0)
//ARRAY TEXT(aText2;0)
//ARRAY TEXT(aText3;0)
//ARRAY REAL(aReal1;0)
//ARRAY LONGINT($aWoNum;0)
//array TEXT($aWoActivity;0)
//array TEXT($aWoActionBy;0)
//ARRAY LONGINT($aWoSeq;0)
//ARRAY LONGINT($aWoCode;0)
////
//ARRAY LONGINT($aOrdRec;0)
//ARRAY DATE($aOrdNeedD;0)
//ARRAY LONGINT($aOrdNum;0)
//array TEXT($aOrdTakeBy;0)
//array TEXT($aOrdCustID;0)
//
//SELECTION TO ARRAY([Order];$aOrdRec;[Order]DateNeeded;$aOrdNeedD;
//[Order]OrderNum;$aOrdNum;[Order]TakenBy;$aOrdTakeBy;[Order]customerID
//;$aOrdCustID)
//For ($indexOrd;1;$cntOrd)
//QUERY([WorkOrder];[WorkOrder]SaleOrderNum=$aOrdNum{$indexOrd})
//$cntWO:=Records in selection([WorkOrder])
//If ($cntWO>0)
//SELECTION TO ARRAY([WorkOrder];$aWoNum;[WorkOrder]Activity
//;$aWoActivity;[WorkOrder]ActionBy;$aWoActionBy;[WorkOrder]Sequence
//;$aWoSeq;[WorkOrder]codeID;$aWoCode)
//For ($indexWO;1;$cntWO)
//$w:=Size of array(aTmpLong1)+1
//INSERT ELEMENT(aTmpLong1;$w;1)//Ord Rec
//INSERT ELEMENT(aTmpDate1;$w;1)//Date Needed
//INSERT ELEMENT(aTmpLong2;$w;1)//OrderNum
//INSERT ELEMENT(aTmp25Str1;$w;1)//nameID
//INSERT ELEMENT(aTmp10Str1;$w;1)//CustID
//aTmpLong1{$w}:=$aOrdRec{$indexOrd}//Ord Rec
//aTmpDate1{$w}:=$aOrdNeedD{$indexOrd}//Date Needed
//aTmpLong2{$w}:=$aOrdNum{$indexOrd}//OrderNum
//aTmp25Str1{$w}:=$aOrdTakeBy{$indexOrd}//nameID
//aTmp10Str1{$w}:=$aOrdCustID{$indexOrd}//CustID        
//INSERT ELEMENT(aTmpLong3;$w;1)//WO Rec Num
//INSERT ELEMENT(aTmpInt1;$w;1)//WO Seq Num
//INSERT ELEMENT(aText1;$w;1)//WO Activity
//INSERT ELEMENT(aText2;$w;1)//WO Action By
//INSERT ELEMENT(aText3;$w;1)//WO Action By
//INSERT ELEMENT(aReal1;$w;1)//WO Order ID      
//aTmpLong3{$w}:=$aWoNum{$indexWO}
//aText1{$w}:=$aWoActivity{$indexWO}
//aText2{$w}:=$aWoActionBy{$indexWO}
//aText3{$w}:=Substring($aWoActivity{$indexWO};1;2)
//aTmpInt1{$w}:=$aWoSeq{$indexWO}
//aReal1{$w}:=$aWoCode{$indexWO}
//End for 
//Else 
//$w:=Size of array(aTmpLong1)+1
//INSERT ELEMENT(aTmpLong1;$w;1)//Ord Rec
//INSERT ELEMENT(aTmpDate1;$w;1)//Date Needed
//INSERT ELEMENT(aTmpLong2;$w;1)//OrderNum
//INSERT ELEMENT(aTmp25Str1;$w;1)//nameID
//INSERT ELEMENT(aTmp10Str1;$w;1)//CustID
//aTmpLong1{$w}:=$aOrdRec{$indexOrd}//Ord Rec
//aTmpDate1{$w}:=$aOrdNeedD{$indexOrd}//Date Needed
//aTmpLong2{$w}:=$aOrdNum{$indexOrd}//OrderNum
//aTmp25Str1{$w}:=$aOrdTakeBy{$indexOrd}//nameID
//aTmp10Str1{$w}:=$aOrdCustID{$indexOrd}//CustID        
//INSERT ELEMENT(aTmpLong3;$w;1)//WO Rec Num
//INSERT ELEMENT(aTmpInt1;$w;1)//WO Seq Num
//INSERT ELEMENT(aText1;$w;1)//WO Activity
//INSERT ELEMENT(aText2;$w;1)//WO Action By
//INSERT ELEMENT(aText3;$w;1)//WO Action By
//INSERT ELEMENT(aReal1;$w;1)//WO Order ID   
//aTmpLong3{$w}:=0
//aText1{$w}:="--"
//aText2{$w}:="--"
//aText3{$w}:="--"
//aTmpInt1{$w}:=0
//aReal1{$w}:=0
//End if 
//
//End for 
//Case of 
//: ($sortSeq=1)//      TakenBy; Date; Order Number; Seq
//ArraySort(aTmp25Str1;">";aTmpDate1;">";aTmpLong2;">";aTmpInt1;">"
//;aTmp10Str1;"=";aTmpLong1;">";aReal1;">";aText1;">";aText2;">";aTmpLong3;">
//";"*")
//ArraySort (aText3;">")
////Date Needed; nameID; OrderNum; CustID; Ord Rec; WO Seq; WO Code;
// Activity;   
//
//: ($sortSeq=2)//      TakenBy; CustID; Date; Order Num; Seq
//ArraySort (aTmp25Str1;">";aTmp10Str1;">";aTmpDate1;">";aTmpLong2;">"
//;aTmpInt1;">";aTmpLong1;"=";aReal1;">";aText1;">";aText2;">";aTmpLong3;">";
//"*")
//ArraySort (aText3;">")
////Date Needed; nameID; CustID; OrderNum; Ord Rec; WO Seq; WO Code;
// Activity;      
//
//: ($sortSeq=3)//      CustID; Date; Order Num; Seq
//ArraySort (aTmp10Str1;">";aTmpDate1;">";aTmpLong2;">";aTmpInt1;">"
//;aTmp25Str1;"=";aTmpLong1;">";aReal1;">";aText1;">";aText2;">";aTmpLong3;">
//";"*")
//ArraySort (aText3;">")
////CustID; Date Needed; OrderNum; nameID; Ord Rec; WO Seq; WO Code;
// Activity;
//
//: ($sortSeq=4)//      ActionBy; Date; Order Number; Seq
//ArraySort (aText2;">";aTmpDate1;">";aTmpLong2;">";aTmpInt1;">"
//;aTmp25Str1;"=";aTmp10Str1;">";aTmpLong1;">";aReal1;">";aText1;">"
//;aTmpLong3;">";"*")
//ArraySort (aText3;">")
////Date Needed; OrderNum; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;
//
//: ($sortSeq=5)//Activity; ActionBy; Date; Order Number; Seq
//ArraySort (aText3;">";aText2;">";aTmpDate1;">";aTmpLong2;">"
//;aTmpInt1;">";aTmp25Str1;"=";aTmp10Str1;">";aTmpLong1;">";aReal1;">";aText1
//;">";"*")
//ArraySort (aTmpLong3;">")
////Date Needed; OrderNum; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;      
//
//: ($sortSeq=6)//Activity; Date; ActionBy; Order Number; Seq
//ArraySort (aText3;">";aTmpDate1;">";aText2;">";aTmpLong2;">"
//;aTmpInt1;">";aTmp25Str1;"=";aTmp10Str1;">";aTmpLong1;">";aReal1;">";aText1
//;">";"*")
//ArraySort (aTmpLong3;">")
////Date Needed; OrderNum; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;      
//
//: ($sortSeq=7)//Activity; Date; Order Number; Seq; ActionBy
//ArraySort (aText3;">";aTmpDate1;">";aTmpLong2;">";aTmpInt1;">"
//;aText2;"=";aTmp25Str1;"=";aTmp10Str1;">";aTmpLong1;">";aReal1;">";aText1;
//">";"*")
//ArraySort (aTmpLong3;">")
////Date Needed; OrderNum; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;      
//
//: ($sortSeq=8)//WoCode; ActionBy; Date; Order Number; Seq
//ArraySort (aReal1;">";aText3;">";aTmpDate1;">";aTmpLong2;">"
//;aTmpInt1;">";aText1;">";aTmp25Str1;"=";aTmp10Str1;">";aTmpLong1;">";aText2
//;">";"*")
//ArraySort (aTmpLong3;">")
////Date Needed; OrderNum; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;      
//
//: ($sortSeq=9)//      Order Number; Seq
//ArraySort (aTmpLong2;">";aTmpInt1;">";aTmpDate1;"=";aTmp25Str1;">"
//;aTmp10Str1;"=";aTmpLong1;">";aReal1;">";aText1;">";aText2;">";aTmpLong3;">
//";"*")
//ArraySort (aText3;">")
////OrderNum; Date Needed; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;
//
//Else //      Date; SO Num; Seq
//ArraySort (aTmpDate1;">";aTmpLong2;">";aTmpInt1;">";aTmp25Str1;"="
//;aTmp10Str1;">";aTmpLong1;">";aReal1;">";aText1;">";aText2;">";aTmpLong3;">
//";"*")
//ArraySort (aText3;">")
////Date Needed; OrderNum; nameID; CustID; Ord Rec; WO Seq; WO Code;
// Activity;
//
//End case 
//End if //