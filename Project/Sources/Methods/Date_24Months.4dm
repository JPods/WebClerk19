//%attributes = {"publishedWeb":true}
//Procedure: Date_24Months
ARRAY DATE:C224(aDate1; 24)
ARRAY DATE:C224(aDate2; 24)
C_LONGINT:C283($1)
If (Count parameters:C259=1)
	vi1:=$1
Else 
	vi1:=Year of:C25(Current date:C33)
End if 
vi2:=vi1-1
If (<>vbDateByDDMMYY)
	aDate1{1}:=Date:C102("1/1/"+String:C10(vi1))
	aDate1{2}:=Date:C102("1/2/"+String:C10(vi1))
	aDate1{3}:=Date:C102("1/3/"+String:C10(vi1))
	aDate1{4}:=Date:C102("1/4/"+String:C10(vi1))
	aDate1{5}:=Date:C102("1/5/"+String:C10(vi1))
	aDate1{6}:=Date:C102("1/6/"+String:C10(vi1))
	aDate1{7}:=Date:C102("1/7/"+String:C10(vi1))
	aDate1{8}:=Date:C102("1/8/"+String:C10(vi1))
	aDate1{9}:=Date:C102("1/9/"+String:C10(vi1))
	aDate1{10}:=Date:C102("1/10/"+String:C10(vi1))
	aDate1{11}:=Date:C102("1/11/"+String:C10(vi1))
	aDate1{12}:=Date:C102("1/12/"+String:C10(vi1))
	aDate2{1}:=Date:C102("31/1/"+String:C10(vi1))
	aDate2{2}:=aDate1{3}-1
	aDate2{3}:=aDate1{4}-1
	aDate2{4}:=aDate1{5}-1
	aDate2{5}:=aDate1{6}-1
	aDate2{6}:=aDate1{7}-1
	aDate2{7}:=aDate1{8}-1
	aDate2{8}:=aDate1{9}-1
	aDate2{9}:=aDate1{10}-1
	aDate2{10}:=aDate1{11}-1
	aDate2{11}:=aDate1{12}-1
	//
	aDate1{13}:=Date:C102("1/1/"+String:C10(vi2))
	aDate2{12}:=aDate1{13}-1
	//
	aDate1{14}:=Date:C102("1/2/"+String:C10(vi2))
	aDate1{15}:=Date:C102("1/3/"+String:C10(vi2))
	aDate1{16}:=Date:C102("1/4/"+String:C10(vi2))
	aDate1{17}:=Date:C102("1/5/"+String:C10(vi2))
	aDate1{18}:=Date:C102("1/6/"+String:C10(vi2))
	aDate1{19}:=Date:C102("1/7/"+String:C10(vi2))
	aDate1{20}:=Date:C102("1/8/"+String:C10(vi2))
	aDate1{21}:=Date:C102("1/9/"+String:C10(vi2))
	aDate1{22}:=Date:C102("1/10/"+String:C10(vi2))
	aDate1{23}:=Date:C102("1/11/"+String:C10(vi2))
	aDate1{24}:=Date:C102("1/12/"+String:C10(vi2))
	aDate2{13}:=aDate1{14}-1
	aDate2{14}:=aDate1{15}-1
	aDate2{15}:=aDate1{16}-1
	aDate2{16}:=aDate1{17}-1
	aDate2{17}:=aDate1{18}-1
	aDate2{18}:=aDate1{19}-1
	aDate2{19}:=aDate1{20}-1
	aDate2{20}:=aDate1{21}-1
	aDate2{21}:=aDate1{22}-1
	aDate2{22}:=aDate1{23}-1
	aDate2{23}:=aDate1{24}-1
	aDate2{24}:=Date:C102("31/12/"+String:C10(vi2))
Else 
	aDate1{1}:=Date:C102("1/1/"+String:C10(vi1))
	aDate1{2}:=Date:C102("2/1/"+String:C10(vi1))
	aDate1{3}:=Date:C102("3/1/"+String:C10(vi1))
	aDate1{4}:=Date:C102("4/1/"+String:C10(vi1))
	aDate1{5}:=Date:C102("5/1/"+String:C10(vi1))
	aDate1{6}:=Date:C102("6/1/"+String:C10(vi1))
	aDate1{7}:=Date:C102("7/1/"+String:C10(vi1))
	aDate1{8}:=Date:C102("8/1/"+String:C10(vi1))
	aDate1{9}:=Date:C102("9/1/"+String:C10(vi1))
	aDate1{10}:=Date:C102("10/1/"+String:C10(vi1))
	aDate1{11}:=Date:C102("11/1/"+String:C10(vi1))
	aDate1{12}:=Date:C102("12/1/"+String:C10(vi1))
	aDate2{1}:=Date:C102("1/31/"+String:C10(vi1))
	aDate2{2}:=aDate1{3}-1
	aDate2{3}:=Date:C102("3/31/"+String:C10(vi1))
	aDate2{4}:=Date:C102("4/30/"+String:C10(vi1))
	aDate2{5}:=Date:C102("5/31/"+String:C10(vi1))
	aDate2{6}:=Date:C102("6/30/"+String:C10(vi1))
	aDate2{7}:=Date:C102("7/31/"+String:C10(vi1))
	aDate2{8}:=Date:C102("8/31/"+String:C10(vi1))
	aDate2{9}:=Date:C102("9/30/"+String:C10(vi1))
	aDate2{10}:=Date:C102("10/31/"+String:C10(vi1))
	aDate2{11}:=Date:C102("11/30/"+String:C10(vi1))
	aDate2{12}:=Date:C102("12/31/"+String:C10(vi1))
	//
	aDate1{13}:=Date:C102("1/1/"+String:C10(vi2))
	aDate1{14}:=Date:C102("2/1/"+String:C10(vi2))
	aDate1{15}:=Date:C102("3/1/"+String:C10(vi2))
	aDate1{16}:=Date:C102("4/1/"+String:C10(vi2))
	aDate1{17}:=Date:C102("5/1/"+String:C10(vi2))
	aDate1{18}:=Date:C102("6/1/"+String:C10(vi2))
	aDate1{19}:=Date:C102("7/1/"+String:C10(vi2))
	aDate1{20}:=Date:C102("8/1/"+String:C10(vi2))
	aDate1{21}:=Date:C102("9/1/"+String:C10(vi2))
	aDate1{22}:=Date:C102("10/1/"+String:C10(vi2))
	aDate1{23}:=Date:C102("11/1/"+String:C10(vi2))
	aDate1{24}:=Date:C102("12/1/"+String:C10(vi2))
	aDate2{13}:=Date:C102("1/31/"+String:C10(vi2))
	aDate2{14}:=aDate1{15}-1
	aDate2{15}:=Date:C102("3/31/"+String:C10(vi2))
	aDate2{16}:=Date:C102("4/30/"+String:C10(vi2))
	aDate2{17}:=Date:C102("5/31/"+String:C10(vi2))
	aDate2{18}:=Date:C102("6/30/"+String:C10(vi2))
	aDate2{19}:=Date:C102("7/31/"+String:C10(vi2))
	aDate2{20}:=Date:C102("8/31/"+String:C10(vi2))
	aDate2{21}:=Date:C102("9/30/"+String:C10(vi2))
	aDate2{22}:=Date:C102("10/31/"+String:C10(vi2))
	aDate2{23}:=Date:C102("11/30/"+String:C10(vi2))
	aDate2{24}:=Date:C102("12/31/"+String:C10(vi2))
End if 

//ARRAY DATE(aText1;24)
//ARRAY DATE(aText2;24)
//vi1:=Year of(Current date)
//vi2:=vi1-1
//aText1{1}:="1/1/"+String(vi1)
//aText1{2}:="2/1/"+String(vi1)
//aText1{3}:="3/1/"+String(vi1)
//aText1{4}:="4/1/"+String(vi1)
//aText1{5}:="5/1/"+String(vi1)
//aText1{6}:="6/1/"+String(vi1)
//aText1{7}:="7/1/"+String(vi1)
//aText1{8}:="8/1/"+String(vi1)
//aText1{9}:="9/1/"+String(vi1)
//aText1{10}:="10/1/"+String(vi1)
//aText1{11}:="11/1/"+String(vi1)
//aText1{12}:="12/1/"+String(vi1)
//aText2{1}:="1/31/"+String(vi1)
//aText2{2}:=String(Date(aText1{3})-1)
//aText2{3}:="3/31/"+String(vi1)
//aText2{4}:="4/30/"+String(vi1)
//aText2{5}:="5/31/"+String(vi1)
//aText2{6}:="6/30/"+String(vi1)
//aText2{7}:="7/31/"+String(vi1)
//aText2{8}:="8/31/"+String(vi1)
//aText2{9}:="9/30/"+String(vi1)
//aText2{10}:="10/31/"+String(vi1)
//aText2{11}:="11/30/"+String(vi1)
//aText2{12}:="12/31/"+String(vi1)
////
//aText1{13}:="1/1/"+String(vi2)
//aText1{14}:="2/1/"+String(vi2)
//aText1{15}:="3/1/"+String(vi2)
//aText1{16}:="4/1/"+String(vi2)
//aText1{17}:="5/1/"+String(vi2)
//aText1{18}:="6/1/"+String(vi2)
//aText1{19}:="7/1/"+String(vi2)
//aText1{20}:="8/1/"+String(vi2)
//aText1{21}:="9/1/"+String(vi2)
//aText1{22}:="10/1/"+String(vi2)
//aText1{23}:="11/1/"+String(vi2)
//aText1{24}:="12/1/"+String(vi2)
//aText2{13}:="1/31/"+String(vi2)
//aText2{14}:=String(Date(aText1{15})-1)
//aText2{15}:="3/31/"+String(vi2)
//aText2{16}:="4/30/"+String(vi2)
//aText2{17}:="5/31/"+String(vi2)
//aText2{18}:="6/30/"+String(vi2)
//aText2{19}:="7/31/"+String(vi2)
//aText2{20}:="8/31/"+String(vi2)
//aText2{21}:="9/30/"+String(vi2)
//aText2{22}:="10/31/"+String(vi2)
//aText2{23}:="11/30/"+String(vi2)
//aText2{24}:="12/31/"+String(vi2)//