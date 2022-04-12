//%attributes = {"publishedWeb":true}
//Method: HTML_ParseLineExtends
//must call before HTML_ParseLineAdds
C_TEXT:C284($1)
C_LONGINT:C283($2)  //1=In OrdPost, do extends; 0 in OrdPay, no extends


C_TEXT:C284(vLineAdds; vLineProfiles)

vLineAdds:=""
pvLnProfile1:=""
pvLnProfile2:=""
pvLnProfile3:=""
pvLnComment:=""
//
C_LONGINT:C283($pMore)
$pMore:=Position:C15("&pvLn"; $1)
//TRACE
If ($pMore>0)
	C_LONGINT:C283($pMore; $pItemNum)
	C_TEXT:C284($commentTest; vLineAdds)
	vText7:=$1
	pvLnProfile1:=PageParameterParse(vText7; "pvLnProfile1"; "")
	pvLnProfile2:=PageParameterParse(vText7; "pvLnProfile2"; "")
	pvLnProfile3:=PageParameterParse(vText7; "pvLnProfile3"; "")
	pvLnComment:=PageParameterParse(vText7; "pvLnComment"; "")
	vLineProfiles:=pvLnProfile1+("; "*Num:C11(pvLnProfile2#""))+pvLnProfile2+("; "*Num:C11(pvLnProfile3#""))+pvLnProfile3+("; "*Num:C11(pvLnProfile4#""))+pvLnProfile4+("; "*Num:C11(pvLnComment#""))+pvLnComment
	vLineAdds:=(("&pvLnProfile1="+pvLnProfile1)*Num:C11(pvLnProfile1#""))+(("&pvLnProfile2="+pvLnProfile2)*Num:C11(pvLnProfile2#""))+(("&pvLnProfile3="+pvLnProfile3)*Num:C11(pvLnProfile3#""))+(("&pvLnComment="+pvLnComment)*Num:C11(pvLnComment#""))
End if 
//
//
If ($2=1)  //&(<>vbItemExtender=1))
	$pExt:=Position:C15("&jitExtend"; $1)
	If ($pExt>0)
		vText7:=$1
		//        
		ARRAY TEXT:C222($myRay; 10)
		$myRay{1}:=PageParameterParse(vText7; "jitExtend1"; "")
		$myRay{2}:=PageParameterParse(vText7; "jitExtend2"; "")
		$myRay{3}:=PageParameterParse(vText7; "jitExtend3"; "")
		$myRay{4}:=PageParameterParse(vText7; "jitExtend4"; "")
		$myRay{5}:=PageParameterParse(vText7; "jitExtend5"; "")
		$myRay{6}:=PageParameterParse(vText7; "jitExtend6"; "")
		$myRay{7}:=PageParameterParse(vText7; "jitExtend7"; "")
		$myRay{8}:=PageParameterParse(vText7; "jitExtend8"; "")
		$myRay{9}:=PageParameterParse(vText7; "jitExtend9"; "")
		$myRay{10}:=PageParameterParse(vText7; "jitExtend10"; "")
		SORT ARRAY:C229($myRay)
		C_LONGINT:C283($incRay)
		For ($incRay; 1; 10)
			pvItemNum:=pvItemNum+$myRay{$incRay}
		End for 
	End if 
End if 
vText7:=""





//If (($pjitLn>0)&(($pjitLn<$p)|($p=0)))
//pvLnComment:=""
//pvLnProfile1:=""
//pvLnProfile2:=""
//pvLnProfile3:=""
//If ($p>0)
//$pEnd:=$p-1-$pjitLn
//Else 
//$pEnd:=Length($myText)
//End if 
//$myLnText:=Substring($myText;$pjitLn+9;$pEnd)//add 1 extra for Quote   
// 
//Repeat 
//Case of 
//: ($myLnText="pvLnProfile1@")
//$ptVar:=(->pvLnProfile1)
//: ($myLnText="pvLnProfile2@")
//$ptVar:=(->pvLnProfile2)
//: ($myLnText="pvLnProfile3@")
//$ptVar:=(->pvLnProfile3)
//Else // ($myLnText="Comment@")
//$ptVar:=(->pvLnComment)
//End case 
//$pValBeg:=Position("Value=";$myLnText)
//$myLnText:=Substring($myLnText;$pValBeg+7)//add 1 extra for Quote
//$pEnd:=Position(Char(34)+Char(32);$myLnText)
//$ptVar->:=Substring($myLnText;1;$pEnd-1)//add 1 extra for Quote
//$pjitLn:=Position("NAME="+Char(34)+"jitP";$myLnText)
//$myLnText:=Substring($myLnText;$pjitLn+11)//add 1 extra for Quote   
//Until ($pjitLn=0)
////If (<>vbItemExtender=1)
////ARRAY TEXT($myRay;3)
////$myRay{1}:=p_Profile1
////$myRay{2}:=p_Profile2
////$myRay{3}:=p_Profile3
////SORT ARRAY($myRay)
////pPartNum:=$myRay{1}+$myRay{2}+$myRay{3}
////End if 
//End if //