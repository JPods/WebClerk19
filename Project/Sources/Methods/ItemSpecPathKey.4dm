//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemSpecPathKey
	//Date: 07/01/02
	//Who: Bill
	//Description: control path to images and specs on web
End if 
// ### bj ### 20191207_1256
// I think this should be eliminated
C_TEXT:C284($1; $theKey)
C_TEXT:C284($2; $0)
$theKey:=""
$addForList:=""
If (Count parameters:C259>0)
	$theKey:=$1
	If (Count parameters:C259>1)
		If ($2#"")
			$addForList:=$2
		End if 
	End if 
End if 
$0:=""
Case of 
	: (($addForList="/TN") & ([Item:4]imagePathTn:114#""))
		// ### bj ### 20190616_2205
		If (Test path name:C476([Item:4]imagePathTn:114)=1)  //document exists
			$0:=[Item:4]imagePathTn:114
		Else 
			$0:=""
		End if 
		
	: (($theKey#"") & ($addForList#""))
		$lenKey:=Length:C16($theKey)
		$theParent:=""
		$shortName:=""
		Repeat 
			Case of 
				: ($lenKey=0)
					$lenKey:=1
					$theParent:=$theKey
				: ($theKey[[$lenKey]]#"/")
					$shortName:=$theKey[[$lenKey]]+$shortName
					$lenKey:=$lenKey-1
				Else 
					$theParent:=Substring:C12($theKey; 1; $lenKey-1)
					$lenKey:=1
			End case 
		Until ($lenKey=1)
		If ($theParent#"")
			$0:=$theParent+$addForList+"/"+$shortName
			pvItemRelatedTN:=$theParent+$addForList+"/"
		Else 
			$0:=$1
			pvItemRelatedTN:=""
		End if 
	: ($theKey#"")
		$0:=$theKey
	: (([Item:4]mfrID:53#"") & ([Item:4]specid:62#"") & ([Item:4]typeid:26#""))
		$0:="/"+[Item:4]mfrID:53+"/"+[Item:4]typeid:26+$addForList+"/"+[Item:4]specid:62+".jpg"
	: (([Item:4]mfrID:53#"") & ([Item:4]specid:62#""))
		$0:="/"+[Item:4]mfrID:53+$addForList+"/"+[Item:4]specid:62+".jpg"
	: (([Item:4]mfrID:53#"") & ([Item:4]typeid:26#"") & ([Item:4]mfrItemNum:39#""))
		$0:="/"+[Item:4]mfrID:53+"/"+[Item:4]typeid:26+$addForList+"/"+[Item:4]mfrItemNum:39+".jpg"
		//
		//: (([Item]MfgID#"")&([Item]typeID#"")&([Item]BarCode#""))
		//$0:=[Item]MfgID+"/"+[Item]typeID+$addForList+"/"+[Item]BarCode
		
	: (([Item:4]mfrID:53#"") & ([Item:4]typeid:26#""))
		$0:="/"+[Item:4]mfrID:53+"/"+[Item:4]typeid:26+$addForList+"/"+[Item:4]itemNum:1+".jpg"
	: ([Item:4]specid:62#"")
		$0:="/"+$addForList+[Item:4]specid:62+".jpg"
	Else 
		$0:=$addForList+[Item:4]itemNum:1+".jpg"
End case 