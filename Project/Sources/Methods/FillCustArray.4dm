//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i; $cntRecs)
$k:=Records in selection:C76([Vendor:38])+Records in selection:C76([Customer:2])+Records in selection:C76()+Records in selection:C76([Contact:13])
initCustArrays(0)
Temp_RayInit
//
If ($k>0)
	If (Records in selection:C76([Customer:2])>$k)
		REDUCE SELECTION:C351([Customer:2]; $k)
	End if 
	$cntRecs:=Records in selection:C76([Customer:2])
	If ($cntRecs>0)
		SELECTION TO ARRAY:C260([Customer:2]; aTmpLong1; [Customer:2]company:2; aQueryFieldNames; [Customer:2]city:6; aTmp40Str2; [Customer:2]zip:8; aTmp12Str1; [Customer:2]phone:13; aTmp20Str1; [Customer:2]customerID:1; aTmp10Str1; [Customer:2]repID:58; aTmp25Str1; [Customer:2]salesNameID:59; aTmp25Str2; [Customer:2]nameLast:23; aTmp35Str1; [Customer:2]nameFirst:73; aTmp20Str3)
		ARRAY TEXT:C222(aTmp2Str1; $cntRecs)
		ARRAY TEXT:C222(aTmpText1; $cntRecs)
		For ($i; 1; $cntRecs)
			aTmp2Str1{$i}:="C"
			aTmpText1{$i}:=aTmp20Str3{$i}+" "+aTmp35Str1{$i}
		End for 
		FindFillRayElem
		$k:=$k-$cntRecs
	End if 
	//  
	Case of 
		: ($k<1)
			REDUCE SELECTION:C351([Contact:13]; $k)
		: (Records in selection:C76([Contact:13])>$k)
			REDUCE SELECTION:C351([Contact:13]; $k)
	End case 
	$cntRecs:=Records in selection:C76([Contact:13])
	If ($cntRecs>0)
		SELECTION TO ARRAY:C260([Contact:13]; aTmpLong1; [Contact:13]company:23; aQueryFieldNames; [Contact:13]city:8; aTmp40Str2; [Contact:13]zip:11; aTmp12Str1; [Contact:13]phone:30; aTmp20Str1; [Contact:13]repID:45; aTmp25Str1; [Contact:13]salesNameID:39; aTmp25Str2; [Contact:13]nameLast:4; aTmp35Str1; [Contact:13]nameFirst:2; aTmp20Str3; [Contact:13]idNum:28; aTmpLong2)
		ARRAY TEXT:C222(aTmp10Str1; $cntRecs)
		ARRAY TEXT:C222(aTmpText1; $cntRecs)
		ARRAY TEXT:C222(aTmp2Str1; $cntRecs)
		For ($i; 1; $cntRecs)
			aTmp10Str1{$i}:=String:C10(aTmpLong2{$i})
			aTmp2Str1{$i}:="i"
			aTmpText1{$i}:=aTmp20Str3{$i}+" "+aTmp35Str1{$i}
		End for 
		ARRAY LONGINT:C221(aTmpLong2; 0)
		FindFillRayElem
		$k:=$k-$cntRecs
	End if 
	//
	//
	Case of 
		: ($k<1)
			REDUCE SELECTION:C351([Vendor:38]; $k)
		: (Records in selection:C76([Vendor:38])>$k)
			REDUCE SELECTION:C351([Vendor:38]; $k)
	End case 
	$cntRecs:=Records in selection:C76([Vendor:38])
	ARRAY TEXT:C222(aTmpText1; $cntRecs)
	If ($cntRecs>0)
		SELECTION TO ARRAY:C260([Vendor:38]; aTmpLong1; [Vendor:38]company:2; aQueryFieldNames; [Vendor:38]city:6; aTmp40Str2; [Vendor:38]zip:8; aTmp12Str1; [Vendor:38]phone:10; aTmp20Str1; [Vendor:38]vendorID:1; aTmp10Str1; [Vendor:38]buyer:56; aTmp25Str1; [Vendor:38]attention:55; aTmp35Str1)
		ARRAY TEXT:C222(aTmp2Str1; $cntRecs)
		ARRAY TEXT:C222(aTmp25Str2; $cntRecs)
		For ($i; 1; $cntRecs)
			aTmp25Str2{$i}:=""
			aTmp2Str1{$i}:="V"
			aTmpText1{$i}:=aTmp35Str1{$i}
		End for 
		FindFillRayElem
	End if 
	//
	Temp_RayInit
	//
	$cntRecs:=Size of array:C274(aCustPhone)
	For ($i; 1; $cntRecs)
		Case of 
			: (Length:C16(aCustPhone{$i})<5)
				//   
			: (Length:C16(aCustPhone{$i})=7)
				aCustPhone{$i}:=Substring:C12(aCustPhone{$i}; 1; 3)+"-"+Substring:C12(aCustPhone{$i}; 4; 4)
			: (Length:C16(aCustPhone{$i})=10)
				aCustPhone{$i}:=Substring:C12(aCustPhone{$i}; 1; 3)+" "+Substring:C12(aCustPhone{$i}; 4; 3)+"-"+Substring:C12(aCustPhone{$i}; 7; 12)
			Else 
				aCustPhone{$i}:=Substring:C12(aCustPhone{$i}; 1; 4)+"."+Substring:C12(aCustPhone{$i}; 5; 4)+"."+Substring:C12(aCustPhone{$i}; 9; 11)
		End case 
	End for 
Else 
	Case of 
		: (doSearch=1)
			GOTO OBJECT:C206(srZip)
		: (doSearch=2)
			GOTO OBJECT:C206(srAcct)
		: (doSearch=3)
			GOTO OBJECT:C206(srCustomer)
		: (doSearch=4)
			GOTO OBJECT:C206(srPhone)
	End case 
End if 
viRecordsInSelection:=Size of array:C274(aRecNum)