//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/10/19, 22:46:04
// ----------------------------------------------------
// Method: RP_TextToObject
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($vobData)
C_TIME:C306($myDoc)
C_LONGINT:C283($viEoF)
C_TEXT:C284($pageIn)
$myDoc:=Open document:C264("Beldin:Users:williamjames:Downloads:ForBill2.txt"; Read mode:K24:5)
If (OK=1)
	$viEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
	RECEIVE PACKET:C104($myDoc; $pageIn; $viEoF)
	If (OK=1)
		CLOSE DOCUMENT:C267($myDoc)
		ARRAY OBJECT:C1221($aObRecord; 0)
		ARRAY TEXT:C222($atLines; 0)
		ARRAY TEXT:C222($atHeader; 0)
		ARRAY TEXT:C222($atFields; 0)
		CREATE EMPTY SET:C140([Customer:2]; "Current")
		TextToArray($pageIn; ->$atLines; "\r"; True:C214)
		C_LONGINT:C283($incRay; $cntRay)
		C_LONGINT:C283($incHead; $cntHead)
		$cntRay:=Size of array:C274($atLines)
		If ($cntRay>0)
			TextToArray($atLines{1}; ->$atHeader; "\t"; True:C214)
			$cntHead:=Size of array:C274($atHeader)
			If ($cntHead>0)
				Storage:C1525.default.idPrefix:="o-"
				C_BOOLEAN:C305($foundFirst)
				$foundFirst:=False:C215  // ignore until the first record is found
				For ($incRay; 2; $cntRay)
					
					ARRAY TEXT:C222($atFields; 0)
					TextToArray($atLines{$incRay}; ->$atFields; "\t"; True:C214)
					If (Size of array:C274($atFields)>0)
						Case of 
							: ($atFields{1}="Orig")
								If ($foundFirst=False:C215)
									$foundFirst:=True:C214
								Else 
									If (Size of array:C274($aObRecord)>0)
										APPEND TO ARRAY:C911($aObRecord; $vobData)
										C_OBJECT:C1216($obBuild)
										OB SET ARRAY:C1227($obBuild; "lines"; $aObRecord)  // build name:pointer to field into template
										[Customer:2]obGeneral:136:=$obBuild
										SAVE RECORD:C53([Customer:2])
										ADD TO SET:C119([Customer:2]; "Current")
										ARRAY OBJECT:C1221($aObRecord; 0)
									End if 
								End if 
								
								$vobData:=New object:C1471
								CREATE RECORD:C68([Customer:2])
								DBCustomer_init
								For ($incHead; 1; $cntHead)
									OB SET:C1220($vobData; $atHeader{$incHead}; $atFields{$incHead})  // build name:pointer to field into template
								End for 
								REDUCE SELECTION:C351([Contact:13]; 0)
								[Customer:2]dateOpened:14:=Current date:C33
								[Customer:2]dateConverted:125:=Date:C102($atFields{2})  //DATE
								[Customer:2]repID:58:=$atFields{3}  // CONSULTANT
								[Customer:2]email:81:=$atFields{4}  // EMAIL
								[Customer:2]phone:13:=$atFields{5}  // PHONE
								[Customer:2]company:2:=$atFields{6}  // PROJECT
								[Customer:2]sector:124:=$atFields{7}  // INDUSTRY
								[Customer:2]nameLast:23:=$atFields{8}  // CLIENT
								[Customer:2]address1:4:=$atFields{9}  // ADDRESS
								[Customer:2]title:3:=$atFields{10}  // TITLE
								[Customer:2]territoryid:120:=$atFields{11}  // EMAIL
								If ($atFields{11}#"")
									CREATE RECORD:C68([Contact:13])
									[Contact:13]customerID:1:=[Customer:2]customerID:1
									[Contact:13]email:35:=$atFields{11}
									SAVE RECORD:C53([Contact:13])
								End if 
								[Customer:2]phoneCell:99:=$atFields{12}  // PHONE
								[Customer:2]need:21:=$atFields{13}  // CAPITAL
								[Customer:2]actionDate:61:=Date:C102($atFields{14})  // DR COLON 
								
								[Customer:2]comment:15:=$atHeader{14}+": "+$atFields{14}+"\r"+[Customer:2]comment:15  // DR COLON 
								
								[Customer:2]comment:15:=$atHeader{15}+": "+$atFields{15}+"\r"+[Customer:2]comment:15  // NDA DATE
								
								[Customer:2]profile2:27:=$atFields{16}  // CONS FEE
								[Customer:2]terms:33:=$atFields{17}  // CASH %
								[Customer:2]typeSale:18:=$atFields{18}  // EQUITY
								[Customer:2]profile3:28:=$atFields{19}  // RETAINER
								[Customer:2]profile4:29:=$atFields{20}  // DEBT OR 
								[Customer:2]profile2:27:=$atFields{21}  // EST BUSINESS
								[Customer:2]profile2:27:=$atFields{22}  // 10% EQUITY
								[Customer:2]profile2:27:=$atFields{23}  // SUBMIT FOR 
								[Customer:2]profile2:27:=$atFields{24}  // Name  
								[Customer:2]profile2:27:=$atFields{25}  // Name 
								[Customer:2]profile2:27:=$atFields{26}  // INVESTOR CALL
								[Customer:2]comment:15:=$atHeader{15}+": "+$atFields{15}+"\r"+[Customer:2]comment:15  // NDA DATE
								
								C_LONGINT:C283($incField; $cntField)
								$cntField:=Get last field number:C255(Table:C252(->[Customer:2]))
								C_POINTER:C301($ptField)
								C_LONGINT:C283($viType)
								For ($incField; 1; $cntField)
									Field:C253(2; $incField)->:=Parse_UnWanted(Field:C253(2; $incField)->)
								End for 
								SAVE RECORD:C53([Customer:2])
								
							: ($foundFirst=False:C215)
								// not found first record
							Else 
								APPEND TO ARRAY:C911($aObRecord; $vobData)
								$vobData:=New object:C1471
								For ($incHead; 1; $cntHead)
									OB SET:C1220($vobData; $atHeader{$incHead}; $atFields{$incHead})  // build name:pointer to field into template
								End for 
								If ($atFields{9}#"")
									Case of 
										: ([Customer:2]address2:5="")
											[Customer:2]address2:5:=$atFields{9}
											[Customer:2]address2:5:=Parse_UnWanted([Customer:2]address2:5)
										: ([Customer:2]city:6="")
											[Customer:2]city:6:=$atFields{9}
											[Customer:2]city:6:=Parse_UnWanted([Customer:2]city:6)
										: ([Customer:2]state:7="")
											[Customer:2]state:7:=$atFields{9}
											[Customer:2]state:7:=Parse_UnWanted([Customer:2]state:7)
										: ([Customer:2]zip:8="")
											[Customer:2]zip:8:=$atFields{9}
											[Customer:2]zip:8:=Parse_UnWanted([Customer:2]zip:8)
									End case 
								End if 
						End case 
					End if 
				End for 
			End if 
		End if 
		
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		ProcessTableOpen(Table:C252(->[Customer:2]))
	End if 
End if 