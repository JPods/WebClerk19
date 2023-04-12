//%attributes = {"publishedWeb":true}
//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-07-03T00:00:00, 06:43:22
// ----------------------------------------------------
// Method: iSabrd
// Description
// Modified: 07/03/17
// 
// 
//
// Parameters
// ----------------------------------------------------

If (Storage:C1525.iSabrd=Null:C1517)
	$o:=New object:C1471
	$o.need:=""
	$o.need:=Request:C163("Define iSabrdGroup for this import")
	Storage_ToNew($o; "iSabrd")
End if 
If (Storage:C1525.iSabrd#Null:C1517)
	If (Storage:C1525.iSabrd.need#"")
		
		var $custNew_o; $custExisting_o : Object
		
		
		
		
		C_LONGINT:C283($p; $p2; $p3; $startPersonal; $startCompany; $p)
		C_TEXT:C284($foundText; $workingText; $blockPersonal; $blockEmployment; $vtValue; $viState; $vtZip; $vtCatChange; $vtStub)
		C_TEXT:C284($namegraduation; $name; $phonePerson; $phoneWork; $emailPersonal; $emailWork; $sex; $website; $seeking)
		C_BOOLEAN:C305($newRecord)
		//TRACE
		
		$workingText:=Get text from pasteboard:C524
		//Console_Log ("TEST: begin")
		$p:=Position:C15("Personal Information"; $workingText)
		
		If ($p>0)
			$custNew_o:=ds:C1482.Customer.new()
			$custNew_o.obGeneral:=New object:C1471
			$custNew_o.obGeneral.iSabrd:=New object:C1471
			$workingText:=Substring:C12($workingText; $p-1)
			$p:=Position:C15("Industry"; $workingText)
			C_TEXT:C284($vtFix; $vtIndustry)
			$vtFix:=Substring:C12($workingText; 1; $p-1)
			$workingText:=Substring:C12($workingText; $p)
			$p:=Position:C15("Occupation"; $workingText)
			$vtIndustry:=Substring:C12($workingText; 1; $p-1)
			$workingText:=Substring:C12($workingText; $p)
			$vtIndustry:=Replace string:C233($vtIndustry; "\n"; "")
			$vtIndustry:=Replace string:C233($vtIndustry; "\t"; "")
			$vtIndustry:=Replace string:C233($vtIndustry; ":"; ":\t")
			
			$workingText:=$vtFix+$vtIndustry+"\n"+$workingText
			
			TextToArray($workingText; ->aText1; "\n")
			$workingText:=Replace string:C233($workingText; "\n"; "\r")
			C_TEXT:C284($vtCatagory)
			C_OBJECT:C1216($obLine)
			C_LONGINT:C283($incRay; $cntRay)
			ARRAY OBJECT:C1221($aObWorking; 0)
			$vtCatagory:=""
			$cntRay:=Size of array:C274(aText1)
			
			For ($incRay; 1; $cntRay)
				TextToArray(aText1{$incRay}; ->aText2; "\t")
				$obLine:=New object:C1471
				Case of 
					: (aText2{1}="@publicly@")  // add :
						aText2{1}:="Ticker:"
					: (aText2{1}="@num of em@")
						aText2{1}:="EmployeeCount:"
					: (aText2{1}="@Org. Name@")
						aText2{1}:="Company:"
					: (aText2{1}="Actively seeking@")
						aText2{1}:="SeekingEmployment:"
						
					: (aText2{1}="State/Prov@")
						aText2{1}:="State"
					: (aText2{1}="@Preference@")
						aText2{1}:="ContactPreference"
				End case 
				Case of 
					: (Size of array:C274(aText2)=0)
					: (Size of array:C274(aText2)=1)
						Case of 
							: (aText2{1}="@Personal Information@")
								$vtCatChange:="Personal"
							: (aText2{1}="@Contact Information@")
								$vtCatChange:="Contact"
							: (aText2{1}="@Employment Information@")
								$vtCatChange:="Employment"
							: (aText2{1}="@Previous Employment@")
								$vtCatChange:="Previous"
							: (aText2{1}="@Graduate Schools@")
								$vtCatChange:="Graduate"
							: (aText2{1}="@Extended Bio@")
								$vtCatChange:="Extended"
								$vtValue:=""
								For ($incRay; $incRay+1; $cntRay)
									$vtValue:=$vtValue+aText1{$incRay}+"\r"
								End for 
								OB SET:C1220($custNew_o.obGeneral.iSabrd; $vtCatChange; $vtValue)
								$incRay:=$cntRay  // drop out
						End case 
						If ($vtCatChange#$vtCatagory)
							If (Size of array:C274($aObWorking)>0)
								OB SET ARRAY:C1227($custNew_o.obGeneral.iSabrd; $vtCatagory; $aObWorking)
								ARRAY OBJECT:C1221($aObWorking; 0)
							End if 
							$vtCatagory:=$vtCatChange
						Else 
							If (Position:C15(":"; aText2{1})>0)
								aText2{1}:=Replace string:C233(aText2{1}; ":"; "")
								aText2{1}:=Txt_TrimSpaces(aText2{1})
								OB SET:C1220($obLine; aText2{1}; "")
								APPEND TO ARRAY:C911($aObWorking; $obLine)
							End if 
						End if 
					: (Size of array:C274(aText2)>1)
						aText2{1}:=Replace string:C233(aText2{1}; ":"; "")
						aText2{1}:=Replace string:C233(aText2{1}; " "; "")
						aText2{1}:=Replace string:C233(aText2{1}; "/"; "")
						aText2{1}:=Replace string:C233(aText2{1}; "#"; "")
						If (aText2{1}="State@")
							$vtValue:=aText2{2}
							$p:=Position:C15("Postal"; $vtValue)
							If ($p>0)
								$viZip:=Substring:C12($vtValue; $p+13)
								$viZip:=Replace string:C233($viZip; ":"; "")
								$viZip:=Txt_TrimSpaces($viZip)
								OB SET:C1220($obLine; "Zip"; $viZip)
								APPEND TO ARRAY:C911($aObWorking; $obLine)
								$obLine:=New object:C1471
								$viState:=Substring:C12($vtValue; 1; $p-1)
								$viState:=Replace string:C233($viState; ":"; "")
								$viState:=Txt_TrimSpaces($viState)
								OB SET:C1220($obLine; "State"; $viState)
								APPEND TO ARRAY:C911($aObWorking; $obLine)
							Else 
								$vtValue:=aText2{2}
								$vtValue:=Replace string:C233($vtValue; ":"; "")
								$vtValue:=Txt_TrimSpaces($vtValue)
								OB SET:C1220($obLine; aText2{1}; $vtValue)
								APPEND TO ARRAY:C911($aObWorking; $obLine)
							End if 
						Else 
							$vtValue:=aText2{2}
							$vtValue:=Replace string:C233($vtValue; ":"; "")
							$vtValue:=Txt_TrimSpaces($vtValue)
							OB SET:C1220($obLine; aText2{1}; $vtValue)
							APPEND TO ARRAY:C911($aObWorking; $obLine)
						End if 
					Else 
						// ob set($obLine;aText2{1};"")
				End case 
				// APPEND TO ARRAY($aObWorking;$obLine)
			End for 
			
			If (False:C215)
				$vtObject:=JSON Stringify:C1217($custNew_o.obGeneral.iSabrd)
				SET TEXT TO PASTEBOARD:C523($vtObject)
			End if 
			
			$custNew_o.customerID:="iSabrd"+String:C10(CounterNew("Customer"))
			srAcct:=$custNew_o.customerID
			$namegraduation:=Util_FindInArrayParseFrom(->aText1; "Graduation Name :"; ":")
			$custNew_o.sICCode:=$namegraduation
			vText1:=$namegraduation
			var $oName : Object
			$oName:=ParseName(vText1)
			$custNew_o.nameFirst:=$oName.nameFirst
			$custNew_o.nameLast:=$oName.nameLast
			
			$custNew_o.company:=$custNew_o.nameLast+", "+$custNew_o.nameFirst
			srCustomer:=$custNew_o.company
			$custNew_o.dateOpened:=Current date:C33
			$custNew_o.adSource:="iSabrd"
			$custNew_o.action:="New"
			$custNew_o.actionDate:=Current date:C33
			$custNew_o.salesNameID:="Bill.James"
			
			$custNew_o.address1:=Util_FindInArrayParseFrom(->aText1; "Address :"; ":")
			$custNew_o.city:=Util_FindInArrayParseFrom(->aText1; "City :"; ":")
			$state:=Util_FindInArrayParseFrom(->aText1; "State/Prov :"; ":")
			$p:=Position:C15("Postal Code :"; $state)
			If ($p>0)
				$custNew_o.state:=Txt_TrimSpaces(Substring:C12($state; 1; $p-1))
				$custNew_o.zip:=Txt_TrimSpaces(Substring:C12($state; $p+13))
			End if 
			srZip:=$custNew_o.zip
			$custNew_o.country:=Util_FindInArrayParseFrom(->aText1; "Country :"; ":")
			// ### bj ### 20200915_1942
			$custNew_o.need:=Storage:C1525.iSabrd.need
			
			$custNew_o.phoneCell:=Util_FindInArrayParseFrom(->aText1; "Phone # :"; ":")
			//  Put  the formating in the form  jFormatPhone(->$custNew_o.phoneCell)
			$custNew_o.email:=Util_FindInArrayParseFrom(->aText1; "E-mail :"; ":")
			srDisplayEmail:=$custNew_o.email
			$custNew_o.profile3:=Util_FindInArrayParseFrom(->aText1; "Gender :"; ":")
			$custNew_o.domain:=Util_FindInArrayParseFrom(->aText1; "Web Site :"; ":")
			$p:=Find in array:C230(aText1; "Industry@")
			If ($p>0)
				$custNew_o.profile4:=aText1{$p+1}
			End if 
			$custNew_o.profile5:=Util_FindInArrayParseFrom(->aText1; "Occupation :"; ":"; $startCompany)
			
			$custNew_o.phone:=Util_FindInArrayParseFrom(->aText1; "Phone # :"; ":"; $startCompany)
			//  Put  the formating in the form  jFormatPhone($custNew_o.phone)
			srPhone:=$custNew_o.phone
			$seeking:=Util_FindInArrayParseFrom(->aText1; "Actively seeking employment :"; ":"; $startCompany)
			$custNew_o.sector:=Util_FindInArrayParseFrom(->aText1; "Org."; ":"; $startCompany)
			
			$custNew_o.repID:=Util_FindInArrayParseFrom(->aText1; "Preference :"; ":"; $startCompany)
			
			$custNew_o.comment:=String:C10(Current date:C33)+"\r"+Replace string:C233($workingText; "\t"; " ")
			
			KeyWordsMake($custNew_o)
			
			$custNew_o.save()
			
			// QQQ work duplicates with ORDA
			
			
		End if 
	End if 
End if 