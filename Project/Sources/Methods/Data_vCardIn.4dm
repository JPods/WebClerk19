//%attributes = {}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: Data_vCardIn
// Description 
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $path; $line; $script; $customersSet; $duplicateSet)
C_TEXT:C284($email1; $phone; $cell; $email2)
C_TEXT:C284($delim)
C_TEXT:C284($groupName)
C_LONGINT:C283($w; $p; $k; $i)
C_BOOLEAN:C305($makeCustomer)
$delim:=Storage:C1525.char.crlf
If (Count parameters:C259>0)
	$path:=$1
	If (Count parameters:C259>1)
		$script:=$2
		If (Count parameters:C259>2)
			$customersSet:=$3
			If (Count parameters:C259>3)
				$duplicateSet:=$4
				If (Count parameters:C259>5)
					$groupName:=$5
				End if 
			End if 
		End if 
	End if 
Else 
	$path:=Get_FileName("Select Document"; "")
	$groupName:=Request:C163("Enter Group Name")
	
End if 
If ((Not:C34(Is compiled mode:C492)) & ($path=""))
	$path:=Get_FileName("Select Document"; "")
	//  $arrayPath:=Select document("")  //;"*";"Select a vCard")
End if 

If ($groupName="")
	// ### bj ### 20181221_1417
	// if(allowAlerts_boo)
	// $groupName:=Request("Enter Group Name")
	//Else 
	$groupName:=String:C10(Current date:C33)
	// End if 
End if 
ARRAY TEXT:C222($aCardRay; 0)
ARRAY TEXT:C222($aDataAll; 0)
ARRAY TEXT:C222($aFieldAll; 0)
C_BOOLEAN:C305($endLoop)
$endLoop:=False:C215
C_LONGINT:C283($lastFound)
C_TIME:C306($myDoc)
$myDoc:=Open document:C264($path)
If (Ok=1)
	Repeat 
		RECEIVE PACKET:C104($myDoc; $line; $delim)
		If (OK=1)
			$p:=Position:C15(":"; $line)
			If ($p>0)
				If (Length:C16($line)<350)
					APPEND TO ARRAY:C911($aFieldAll; Substring:C12($line; 1; $p-1))
					APPEND TO ARRAY:C911($aDataAll; Substring:C12($line; $p+1))
				Else 
					//learn how to extract the images
				End if 
			End if 
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267($myDoc)
End if 
If (Size of array:C274($aFieldAll)>0)
	$lastFound:=0
	Repeat 
		C_LONGINT:C283($findBegin; $findEnd)
		$findBegin:=Find in array:C230($aFieldAll; "BEGIN"; $lastFound)
		$findEnd:=Find in array:C230($aFieldAll; "END"; $findBegin)
		$lastFound:=$findEnd
		If ($findBegin>0)
			ARRAY TEXT:C222($aData; 0)
			ARRAY TEXT:C222($aField; 0)
			For ($i; $findBegin; $findEnd)
				APPEND TO ARRAY:C911($aData; $aDataAll{$i})
				APPEND TO ARRAY:C911($aField; $aFieldAll{$i})
			End for 
		End if 
		If (($findEnd+3>Size of array:C274($aFieldAll)) | ($findBegin<1))
			$endLoop:=True:C214
		End if 
		$email1:=""
		$email2:=""
		$phone:=""
		$cell:=""
		$w:=Find in array:C230($aField; "Email@")
		If ($w>0)
			$email1:=$aData{$w}
		End if 
		$w:=Find in array:C230($aField; "Email@"; $w+1)
		If ($w>0)
			$email2:=$aData{$w}
		End if 
		$w:=Find in array:C230($aField; "Tel;@")
		If ($w>0)
			ParsePhone($aData{$w}; ->$phone; <>tcLocalArea)
		End if 
		$w:=Find in array:C230($aField; "Tel;@"; $w+1)
		If ($w>0)
			ParsePhone($aData{$w}; ->$cell; <>tcLocalArea)
		End if 
		
		$makeCustomer:=False:C215
		If ($email1#"")
			QUERY:C277([Customer:2]; [Customer:2]email:81=$email1)
		End if 
		If (Records in selection:C76([Customer:2])=0)
			If ($email2#"")
				QUERY:C277([Customer:2];  | [Customer:2]email:81=$email2)
			End if 
		End if 
		If (Records in selection:C76([Customer:2])=0)
			If ($phone#"")
				QUERY:C277([Customer:2]; [Customer:2]phone:13=$phone; *)
				QUERY:C277([Customer:2];  | [Customer:2]phoneCell:99=$phone)
			End if 
			If (Records in selection:C76([Customer:2])=0)
				If ($cell#"")
					QUERY:C277([Customer:2]; [Customer:2]phone:13=$cell; *)
					QUERY:C277([Customer:2];  | [Customer:2]phoneCell:99=$cell)
				End if 
				If (Records in selection:C76([Customer:2])=0)
					$makeCustomer:=True:C214
				Else 
				End if 
			End if 
		End if 
		If ($makeCustomer)
			CREATE RECORD:C68([Customer:2])
			DB_InitCustomer
			[Customer:2]profile1:26:=$groupName
			[Customer:2]profile5:30:="vCard"
			$w:=Find in array:C230($aField; "Tel;type=CELL@")
			If ($w>0)
				ParsePhone($aData{$w}; ->$cell; <>tcLocalArea)
				[Customer:2]phoneCell:99:=$cell
			End if 
			$w:=Find in array:C230($aField; "Tel;type=Work@")
			If ($w>0)
				ParsePhone($aData{$w}; ->$cell; <>tcLocalArea)
				[Customer:2]phone:13:=$cell
			End if 
			If ($email1#"")
				[Customer:2]email:81:=$email1
			Else 
				If ($email2#"")
					[Customer:2]email:81:=$email2
				End if 
			End if 
			
			$w:=Find in array:C230($aField; "FN")
			If ($w>0)
				$p:=Position:C15("\\"; $aData{$w})
				If ($p>1)
					$p:=$p-1
				Else 
					$p:=Length:C16($aData{$w})
				End if 
				[Customer:2]nameLast:23:=Substring:C12($aData{$w}; 1; $p)
				Parse_UnWanted(process_o.entry_o.nameLast)
			Else 
				$w:=Find in array:C230($aField; "N")
				If ($w>0)
					$line:=Substring:C12($aData{$w}; 3)
					$p:=Position:C15(";"; $line)
					[Customer:2]nameLast:23:=Substring:C12($line; 1; $p-1)
					$line:=Substring:C12($line; $p+1)
					$p:=Position:C15(";"; $line)
					If ($p>0)
						[Customer:2]nameFirst:73:=Substring:C12($line; 1; $p-1)
					Else 
						[Customer:2]nameFirst:73:=Substring:C12($line; 1)
					End if 
				End if 
			End if 
			$w:=Find in array:C230($aField; "TITLE@")
			If ($w>0)
				[Customer:2]title:3:=$aData{$w}
			End if 
			$w:=Find in array:C230($aField; "@URL@")
			If ($w>0)
				[Customer:2]domain:90:=$aData{$w}
			End if 
			$w:=Find in array:C230($aField; "ORG@")
			var $c : Collection
			If ($w>0)
				$c:=Split string:C1554($aData{$w}; ";")
				COLLECTION TO ARRAY:C1562($c; aText1)
				[Customer:2]company:2:=aText1{1}
			Else 
				[Customer:2]company:2:=[Customer:2]nameLast:23+(", "*Num:C11([Customer:2]nameLast:23#""))+[Customer:2]nameFirst:73
			End if 
			$w:=Find in array:C230($aField; "@ADR;@")
			If ($w>0)
				$c:=Split string:C1554($aData{$w}; ";")
				COLLECTION TO ARRAY:C1562($c; aText1)
				$k:=Size of array:C274(aText1)
				Case of 
					: ($k=5)
						[Customer:2]country:9:=aText1{5}
						[Customer:2]zip:8:=aText1{4}
						[Customer:2]state:7:=aText1{3}
						[Customer:2]city:6:=aText1{2}
						[Customer:2]address1:4:=aText1{1}
					: ($k=6)
						[Customer:2]country:9:=aText1{6}
						[Customer:2]zip:8:=aText1{5}
						[Customer:2]state:7:=aText1{4}
						[Customer:2]city:6:=aText1{3}
						[Customer:2]address2:5:=aText1{2}
						[Customer:2]address1:4:=aText1{1}
					Else 
						If ($k>0)
							[Customer:2]country:9:=aText1{$k}
							$k:=$k-1
						End if 
						If ($k>0)
							[Customer:2]zip:8:=aText1{$k}
							$k:=$k-1
						End if 
						If ($k>0)
							[Customer:2]city:6:=aText1{$k}
							$k:=$k-1
						End if 
						If ($k>1)
							[Customer:2]address2:5:=aText1{$k}
							[Customer:2]address1:4:=aText1{1}
						Else 
							If ($k=1)
								[Customer:2]address1:4:=aText1{1}
							End if 
						End if 
				End case 
			End if 
			$w:=Find in array:C230($aField; "NOTE:@")
			If ($w>0)
				[Customer:2]comment:15:=$aData{$w}+"\r"+"\r"
				DELETE FROM ARRAY:C228($aData; $w; 1)
				DELETE FROM ARRAY:C228($aField; $w; 1)
			End if 
			$k:=Size of array:C274($aData)
			For ($i; 1; $k)
				[Customer:2]comment:15:=[Customer:2]comment:15+$aField{$i}+":"+$aData{$i}+"\r"
			End for 
			ExecuteText(0; $script)
			SAVE RECORD:C53([Customer:2])
			If ($customersSet#"")
				ADD TO SET:C119([Customer:2]; $customersSet)
			End if 
		Else 
			If ($duplicateSet#"")
				ADD TO SET:C119([Customer:2]; $duplicateSet)
			End if 
		End if 
	Until ($endLoop)
End if 