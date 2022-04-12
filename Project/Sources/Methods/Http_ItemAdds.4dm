//%attributes = {"publishedWeb":true}
//Method: Http_ItemAdds
//must call after HTML_ParseLineExtends






// ### bj ### 20190101_1818  cannot take time to sort this out at this time
// this is antiquated




C_TEXT:C284($1; $2; vLineAdds)  //text to evaluate
C_REAL:C285($3)  //Quantity
C_LONGINT:C283($4)  //Longint
_Ad1_:=""
_Ad2_:=""
_Ad3_:=""
_Ad4_:=""
C_LONGINT:C283($pMore)
C_TEXT:C284($addDesc1; $addDesc2; $addDesc3; $addDesc4)


If ($2="Read Arrays")
	$baseItem:=pPartNum
	$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_Ad1_"; $foundLine; $foundNext)
	If ($nextValueElement>0)
		$addDesc1:=aParameterValue{$nextValueElement}
	End if 
	$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_Ad2_"; $foundLine; $foundNext)
	If ($nextValueElement>0)
		$addDesc2:=aParameterValue{$nextValueElement}
	End if 
	$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_Ad3_"; $foundLine; $foundNext)
	If ($nextValueElement>0)
		$addDesc3:=aParameterValue{$nextValueElement}
	End if 
	$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_Ad4_"; $foundLine; $foundNext)
	If ($nextValueElement>0)
		$addDesc4:=aParameterValue{$nextValueElement}
	End if 
	
Else 
	$pMore:=Position:C15("_Ad"; $2)
	If ($pMore>0)
		C_LONGINT:C283($pMore; $lenFound)
		C_TEXT:C284($commentTest)
		C_TEXT:C284(jitAddItem1; jitAddItem2; jitAddItem3; jitAddItem4; $baseItem)
		vText7:=$2
		//    
		$baseItem:=pPartNum
		$pMore:=Position:C15("_Ad1_"; vText7)
		If ($pMore>0)
			_Ad1_:=Http_ItemParseAdds(Substring:C12(vText7; $pMore; 43))
			$addDesc1:=Txt_UpToDelimiter(_Ad1_; "#")
			// If ($3>0)
			Http_ItemBuildAdds($baseItem; _Ad1_; $3; $4)
			// End if 
		End if 
		$pMore:=Position:C15("_Ad2_"; vText7)
		If ($pMore>0)
			_Ad2_:=Http_ItemParseAdds(Substring:C12(vText7; $pMore; 43))
			$addDesc2:=Txt_UpToDelimiter(_Ad2_; "#")
			//If ($3>0)
			Http_ItemBuildAdds($baseItem; _Ad2_; $3; $4)
			//End if 
		End if 
		$pMore:=Position:C15("_Ad3_"; vText7)
		If ($pMore>0)
			_Ad3_:=Http_ItemParseAdds(Substring:C12(vText7; $pMore; 43))
			$addDesc3:=Txt_UpToDelimiter(_Ad3_; "#")
			//If ($3>0)
			Http_ItemBuildAdds($baseItem; _Ad3_; $3; $4)
			//End if 
		End if 
		$pMore:=Position:C15("_Ad4_"; vText7)
		If ($pMore>0)
			_Ad4_:=Http_ItemParseAdds(Substring:C12(vText7; $pMore; 43))
			$addDesc4:=Txt_UpToDelimiter(_Ad4_; "#")
			//If ($3>0)
			Http_ItemBuildAdds($baseItem; _Ad4_; $3; $4)
			//End if 
		End if 
		vLineAdds:=vLineAdds+(("&_Ad1_="+_Ad1_)*Num:C11(_Ad1_#""))+(("&_Ad2_="+_Ad2_)*Num:C11(_Ad2_#""))+(("&_Ad3_="+_Ad3_)*Num:C11(_Ad3_#""))+(("&_Ad4_="+_Ad4_)*Num:C11(_Ad4_#""))
	End if 
	vLineAddsShow:=$addDesc1+("; "*Num:C11(_Ad2_#""))+$addDesc2+("; "*Num:C11(_Ad3_#""))+$addDesc3+("; "*Num:C11(_Ad4_#""))+$addDesc4
	vLineAdds:=vLineAdds+("&"*Num:C11(vLineAdds#""))
End if 

