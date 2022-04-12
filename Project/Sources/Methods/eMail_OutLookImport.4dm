//%attributes = {"publishedWeb":true}
//Method: eMail_OutLookImport
C_TEXT:C284($1; $thePath)
C_LONGINT:C283($myOK)
//
If (Count parameters:C259=0)
	myDocName:=""
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open Outlook File to Import"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
Else 
	myDoc:=Open document:C264($1)
	OK:=$myOK
End if 
ARRAY TEXT:C222(aText9; 87)
C_LONGINT:C283($i; $k)
If ($myOK=1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; aText9{1}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{2}; "\t")  //First Name
		RECEIVE PACKET:C104(myDoc; aText9{3}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{4}; "\t")  //Last Name
		RECEIVE PACKET:C104(myDoc; aText9{5}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{6}; "\t")  //Business Company
		RECEIVE PACKET:C104(myDoc; aText9{7}; "\t")  //Business Department
		RECEIVE PACKET:C104(myDoc; aText9{8}; "\t")  //Business Title
		RECEIVE PACKET:C104(myDoc; aText9{9}; "\t")  //Business Street Address
		RECEIVE PACKET:C104(myDoc; aText9{10}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{11}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{12}; "\t")  //Business City
		RECEIVE PACKET:C104(myDoc; aText9{13}; "\t")  //Business State
		RECEIVE PACKET:C104(myDoc; aText9{14}; "\t")  //Business Zip
		RECEIVE PACKET:C104(myDoc; aText9{15}; "\t")  //Business Country
		RECEIVE PACKET:C104(myDoc; aText9{16}; "\t")  //Home Street Address
		RECEIVE PACKET:C104(myDoc; aText9{17}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{18}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{19}; "\t")  //Home City
		RECEIVE PACKET:C104(myDoc; aText9{20}; "\t")  //Home State
		RECEIVE PACKET:C104(myDoc; aText9{21}; "\t")  //Home Zip
		RECEIVE PACKET:C104(myDoc; aText9{22}; "\t")  //Home Country
		RECEIVE PACKET:C104(myDoc; aText9{23}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{24}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{25}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{26}; "\t")  //Other Street Address
		RECEIVE PACKET:C104(myDoc; aText9{27}; "\t")  //Other City
		RECEIVE PACKET:C104(myDoc; aText9{28}; "\t")  //Other State
		RECEIVE PACKET:C104(myDoc; aText9{29}; "\t")  //Other Zip
		RECEIVE PACKET:C104(myDoc; aText9{30}; "\t")  //ISDN Phone 2
		RECEIVE PACKET:C104(myDoc; aText9{31}; "\t")  //Business Fax
		RECEIVE PACKET:C104(myDoc; aText9{32}; "\t")  //Business Phone
		RECEIVE PACKET:C104(myDoc; aText9{33}; "\t")  //Business Phone 2
		RECEIVE PACKET:C104(myDoc; aText9{34}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{35}; "\t")  //Car Phone
		RECEIVE PACKET:C104(myDoc; aText9{36}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{37}; "\t")  //Home Fax
		RECEIVE PACKET:C104(myDoc; aText9{38}; "\t")  //Home Phone
		RECEIVE PACKET:C104(myDoc; aText9{39}; "\t")  //Home Phone 2
		RECEIVE PACKET:C104(myDoc; aText9{40}; "\t")  //Business Phone 2
		RECEIVE PACKET:C104(myDoc; aText9{41}; "\t")  //Home Cellular
		RECEIVE PACKET:C104(myDoc; aText9{42}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{43}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{44}; "\t")  //Business Pager
		RECEIVE PACKET:C104(myDoc; aText9{45}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{46}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{47}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{48}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{49}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{50}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{51}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{52}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{53}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{54}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{55}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{56}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{57}; "\t")  //E-mail Address 1
		RECEIVE PACKET:C104(myDoc; aText9{58}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{59}; "\t")  //E-mail Address 2
		RECEIVE PACKET:C104(myDoc; aText9{60}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{61}; "\t")  //E-mail Address 3
		RECEIVE PACKET:C104(myDoc; aText9{62}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{63}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{64}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{65}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{66}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{67}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{68}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{69}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{70}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{71}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{72}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{73}; "\t")  //Notes
		RECEIVE PACKET:C104(myDoc; aText9{74}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{75}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{76}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{77}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{78}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{79}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{80}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{81}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{82}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{83}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{84}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{85}; "\t")  //Reserved
		RECEIVE PACKET:C104(myDoc; aText9{86}; "\t")  //Home Web Page
		RECEIVE PACKET:C104(myDoc; aText9{87}; "\r")  //Business Web Page  
		If (OK=1)
			$w:=Size of array:C274(aTmpLong2)+1
			INSERT IN ARRAY:C227(aTmpLong2; $w; 1)
			INSERT IN ARRAY:C227(aTmpLong1; $w; 1)
			INSERT IN ARRAY:C227(aTmp80Str1; $w; 1)
			INSERT IN ARRAY:C227(aText2; $w; 1)
			INSERT IN ARRAY:C227(aText3; $w; 1)
			INSERT IN ARRAY:C227(aText4; $w; 1)
			INSERT IN ARRAY:C227(aText5; $w; 1)
			aTmpLong2{$w}:=-1
			If (aText9{57}#"")
				aTmp80Str1{$w}:=aText9{57}
			Else 
				If (aText9{59}#"")
					aTmp80Str1{$w}:=aText9{59}
				Else 
					If (aText9{61}#"")
						aTmp80Str1{$w}:=aText9{61}
					End if 
				End if 
			End if   //
			//      
			aText2{$w}:=aText9{2}
			aText3{$w}:=aText9{4}
			aText4{$w}:=aText9{6}
			aText5{$w}:=""
			aTmpLong1{$w}:=-1
			//
			aText5{$w}:=aText9{7}+"!_Business Department_!"+aText9{8}+"!_Business Title_!"+aText9{9}+"!_Business Street Address_!"
			aText5{$w}:=aText5{$w}+aText9{12}+"!_Business City_!"+aText9{13}+"!_Business State_!"+aText9{14}+"!_Business Zip_!"
			aText5{$w}:=aText5{$w}+aText9{15}+"!_Business Country_!"+aText9{16}+"!_Home Street Address_!"+aText9{19}+"!_Home City_!"
			aText5{$w}:=aText5{$w}+aText9{20}+"!_Home State_!"+aText9{21}+"!_Home Zip_!"+aText9{22}+"!_Home Country_!"
			aText5{$w}:=aText5{$w}+aText9{26}+"!_Other Street Address_!"+aText9{27}+"!_Other City_!"+aText9{28}+"!_Other State_!"
			aText5{$w}:=aText5{$w}+aText9{29}+"!_Other Zip_!"+aText9{30}+"!_ISDN Phone 2_!"+aText9{31}+"!_Business Fax_!"
			aText5{$w}:=aText5{$w}+aText9{32}+"!_Business Phone_!"+aText9{33}+"!_Business Phone 2_!"+aText9{35}+"!_Car Phone_!"
			aText5{$w}:=aText5{$w}+aText9{37}+"!_Home Fax_!"+aText9{38}+"!_Home Phone_!"+aText9{39}+"!_Home Phone 2_!"
			aText5{$w}:=aText5{$w}+aText9{40}+"!_Business Phone 2_!"+aText9{41}+"!_Home Cellular_!"+aText9{44}+"!_Business Pager_!"
			aText5{$w}:=aText5{$w}+aText9{57}+"!_E-mail Address 1_!"+aText9{59}+"!_E-mail Address 2_!"+aText9{61}+"!_E-mail Address 3_!"
			aText5{$w}:=aText5{$w}+aText9{73}+"!_Notes_!"+aText9{86}+"!_Home Web Page_!"+aText9{87}+"!_Business Web Page_!"
			
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
End if 
//ArraySort (aTmp80Str1;">";aText4;">";aTmpLong1;">";aTmpLong2;">";aText2;"="
//;aText3;"=";aText5;"=")
If (eFixDups>0)
	//  --  CHOPPED  AL_UpdateArrays(eFixDups; -2)
End if 



//If (aTmp80Str1{57}#"")
//aTmp80Str1{57}:=EMail_In (->aTmp80Str1{57})
//QUERY([Contact];[Contact]Email=aTmp80Str1{57})
//$k:=Records in selection([Contact])
//Case of 
//: ($k>1)
//ADD TO SET([Contact];"Multiples")
//: ($k=1)
//Case of 
//: (([Contact]FirstName=aTmp80Str1{2})&([Contact]LastName
//=aTmp80Str1{4})&([Contact]Company=aTmp80Str1{6}))
//ADD TO SET([Contact];"Updated")
//: (([Contact]FirstName=aTmp80Str1{2})&([Contact]LastName
//=aTmp80Str1{4})&(([Contact]Company="")|(aTmp80Str1{6}="")))
//ADD TO SET([Contact];"CheckCompany")
//: ((([Contact]FirstName#aTmp80Str1{2})&([Contact]FirstName
//#"")&(aTmp80Str1{2}#""))|([Contact]LastName#aTmp80Str1{4})&(([Cont
//]Company="")|(aTmp80Str1{6}="")))
//ADD TO SET([Contact];"CheckCompany")
//
//: (([Contact]FirstName=aTmp80Str1{2})&(([Contact]LastName=""
//)|(aTmp80Str1{4}="")))
//ADD TO SET([Contact];"CheckNames")
//
//: (([Contact]FirstName=aTmp80Str1{2})&([Contact]LastName
//=aTmp80Str1{4})&([Contact]Company=aTmp80Str1{6}))
//ADD TO SET([Contact];"Updated")
//
//End case 
//End if 
//End if 
//End if 