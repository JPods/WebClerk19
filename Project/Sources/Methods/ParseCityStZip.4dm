//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-31T06:00:00Z)
// Method: ParseCityStZip
// Description
// Parameters
// ----------------------------------------------------

// MustFixQQQZZZ: Bill James (2022-02-01T06:00:00Z)
// test this and getting a better version working

//  https://stackoverflow.com/questions/9463471/is-there-a-library-for-parsing-us-addresses
// https://www.npmjs.com/package/parse-address-string
//    https://parserator.datamade.us/pricing/


var $1 : Text
var $0; $working_o : Object
var $myTemp_t; $rawData : Text
var $city; $state; $zip : Text
var $endLoop : Boolean
var $i; $k; $w : Integer
$rawData:=$1

var $cByc; $cBycr : Collection
$cByc:=Split string:C1554($1; ";")  // try to break it 
$cBycr:=Split string:C1554($1; Storage:C1525.char.cr)  // try to break it 

// contains @ email
// contains .com, .org, .net without @ web address

ARRAY TEXT:C222($aLastNamePrefix; 0)
ARRAY TEXT:C222($aStateCode; 0)
ARRAY TEXT:C222($aStateName; 0)
var $knowCities_c : Collection

$working_o:=New object:C1471("line1"; ""; \
"line2"; ""; \
"line3"; ""; \
"line4"; ""; \
"line5"; ""; \
"line6"; ""; \
"line7"; ""; \
"line8"; ""; \
"line9"; ""; \
"address"; New object:C1471(); \
"city"; ""; \
"state"; ""; \
"zip"; ""; \
"country"; ""; \
"original"; "")
$working_o.original:=$rawData
If (Position:C15(","; $rawData)>0)
	
	$k:=Length:C16($rawData)
	$i:=$k
	While ((($rawData[[$i]]=" ") | ($rawData[[$i]]=Char:C90(34))) & ($i>0))  //clean out trailing spaces
		$i:=$i-1
	End while 
	Repeat 
		If ($rawData[[$i]]#" ")
			$zip:=$rawData[[$i]]+$zip
		Else 
			$endLoop:=True:C214
		End if 
		$i:=$i-1
	Until (($i=0) | ($endLoop))
	While (($rawData[[$i]]=" ") & ($i>0))  //clean out trailing spaces
		$i:=$i-1
	End while 
	$endLoop:=False:C215
	Repeat 
		If ($rawData[[$i]]#",")
			$state:=$rawData[[$i]]+$state
		Else 
			$endLoop:=True:C214
		End if 
		$i:=$i-1
	Until (($i=0) | ($endLoop))
	
	$state:=Parse_UnWanted($state)
	$state:=$myTemp_t
	$myTemp_t:=Substring:C12($rawData; 1; $i)
	$myTemp_t:=Parse_UnWanted($myTemp_t)
	$city:=$myTemp_t
	$working_o.city:=$city
	$working_o.state:=$state
	$working_o.zip:=$zip
Else 
	
	TextToArray($rawData; ->aText5; " "; True:C214)
	$cnt:=Size of array:C274(aText5)
	For (vi8; $cnt; 1; -1)
		vi7:=Length:C16(aText5{vi8})
		Case of 
			: ((vi7=1) & (aText5{vi8}=" "))
				DELETE FROM ARRAY:C228(aText5; vi8; 1)
			: (aText5{vi8}="")
				DELETE FROM ARRAY:C228(aText5; vi8; 1)
		End case 
	End for 
	var $cnt
	$cnt:=Size of array:C274(aText5)
	Case of 
		: ($cnt<3)
			//[Customer]Profile5:="No Address Split"
		: ($cnt=3)
			// [Customer]Profile5:="3 Split"
			$working_o.city:=aText5{1}
			$working_o.state:=aText5{2}
			$working_o.zip:=aText5{3}
			
		: ($cnt=4)
			$working_o.city:=aText5{1}+" "+aText5{2}
			$working_o.state:=aText5{3}
			//$working_o.zip=aText5{4}
			//   [Customer]Profile5:="4 Split"
		: ($cnt=5)
			$working_o.city:=aText5{1}+" "+aText5{2}+" "+aText5{3}
			$working_o.state:=aText5{4}
			//$working_o.zip=aText5{5}
			//  [Customer]Profile5:="5 Split"
		: ($cnt=6)
			$working_o.city:=aText5{1}+" "+aText5{2}+" "+aText5{3}+" "+aText5{4}
			$working_o.state:=aText5{5}
			//$working_o.zip=aText5{6}
			//[Customer]Profile5:="6 Split"
		: ($cnt>6)
			// [Customer]Profile5:="no Split"
	End case 
End if 
$0:=$working_o


If (False:C215)
	
	// Modified by: Bill James (2022-02-01T06:00:00Z)
	// Method: PVars_SplitAddress
	// Description 
	// Parameters
	// ----------------------------------------------------
	
	
	// >> >usaddress.parse('Robie House, 5757 South Woodlawn Avenue, Chicago, IL 60637')
	//[('Robie', 'BuildingName'), 
	//('House,', 'BuildingName'), 
	//('5757', 'AddressNumber'), 
	//('South', 'StreetNamePreDirectional'), 
	//('Woodlawn', 'StreetName'), 
	//('Avenue,', 'StreetNamePostType'), 
	//('Chicago,', 'PlaceName'), 
	//('IL', 'StateName'), 
	//('60637', 'ZipCode')]
	
	C_LONGINT:C283($i; $k; $lenText; $lineCnt; $thePosition)
	C_BOOLEAN:C305($endLoop; $doSplit)
	C_TEXT:C284($tempData; $city; $state; $zip; $country)
	C_TEXT:C284($1; $working_t)
	If (Count parameters:C259=0)
		$working_t:=ShipAddress
	Else 
		$working_t:=$1
	End if 
	$lenText:=Length:C16($working_t)
	If ($lenText=0)
		BEEP:C151
		BEEP:C151
	Else 
		CONFIRM:C162("Read in address?")
		If (OK=1)
			$doSplit:=True:C214
			$i:=$lenText
			$wordCnt:=0
			$endLoop:=False:C215
			ARRAY TEXT:C222(aTmpText1; 0)
			// ### jwm ### 20171208_1057
			// convert line endings to carriage return   
			$working_t:=Replace string:C233($working_t; Storage:C1525.char.crlf; "\r")
			$working_t:=Replace string:C233($working_t; "\n"; "\r")
			Repeat 
				$thePosition:=Position:C15("\r"; $working_t)
				$k:=Size of array:C274(aTmpText1)+1
				INSERT IN ARRAY:C227(aTmpText1; $k; 1)
				If ($thePosition>0)
					aTmpText1{$k}:=Substring:C12($working_t; 1; ($thePosition-1))
				Else 
					aTmpText1{$k}:=$working_t
				End if 
				$working_t:=Substring:C12($working_t; ($thePosition+1))
			Until (($thePosition=0) | ($working_t=""))
			$lineCnt:=Size of array:C274(aTmpText1)
			Case of 
				: ($lineCnt=8)  // Complete address and email        
				: ($lineCnt=3)  //only one address line
					INSERT IN ARRAY:C227(aTmpText1; 1; 1)  //empty name
					INSERT IN ARRAY:C227(aTmpText1; 4; 1)  //empty addr2
					INSERT IN ARRAY:C227(aTmpText1; 6; 1)  //empty phone
					INSERT IN ARRAY:C227(aTmpText1; 7; 1)  //empty fax
					INSERT IN ARRAY:C227(aTmpText1; 8; 1)  //empty email        
				: ($lineCnt=4)  //only one address line
					INSERT IN ARRAY:C227(aTmpText1; 4; 1)  //empty addr2
					INSERT IN ARRAY:C227(aTmpText1; 6; 1)  //empty phone
					INSERT IN ARRAY:C227(aTmpText1; 7; 1)  //empty fax
					INSERT IN ARRAY:C227(aTmpText1; 8; 1)  //empty email
				: ($lineCnt=5)
					INSERT IN ARRAY:C227(aTmpText1; 6; 1)  //empty phone
					INSERT IN ARRAY:C227(aTmpText1; 7; 1)  //empty fax
					INSERT IN ARRAY:C227(aTmpText1; 8; 1)  //empty email   
				: ($lineCnt=6)
					INSERT IN ARRAY:C227(aTmpText1; 7; 1)  //empty fax
					INSERT IN ARRAY:C227(aTmpText1; 8; 1)  //empty email
				: ($lineCnt=7)
					INSERT IN ARRAY:C227(aTmpText1; 8; 1)  //empty email  
				Else 
					jAlertMessage(9214)
					$doSplit:=False:C215
			End case 
			//
			If ($doSplit)
				
				var $address_o : Object
				$address_o:=ParseCityStZip(aTmpText1{5})
				var $name_o : Object
				$name_o:=ParseName(aTmpText1{1})
				[Customer:2]nameFirst:73:=$name_o.first
				[Customer:2]nameLast:23:=$name_o.last
				[Customer:2]company:2:=aTmpText1{2}
				If ([Customer:2]company:2="")
					[Customer:2]individual:72:=True:C214
					[Customer:2]company:2:=[Customer:2]nameLast:23+", "+[Customer:2]nameFirst:73
				End if 
				[Customer:2]address1:4:=aTmpText1{3}
				[Customer:2]address2:5:=aTmpText1{4}
				[Customer:2]city:6:=vText1
				[Customer:2]state:7:=vText2
				[Customer:2]zip:8:=vText3
				ParsePhone(aTmpText1{6}; ->[Customer:2]phone:13; <>tcLocalArea)
				ParsePhone(aTmpText1{7}; ->[Customer:2]fax:66; <>tcLocalArea)
				[Customer:2]email:81:=aTmpText1{8}
				srVarLoad(Table:C252(->[Customer:2]))
				
			End if 
		End if 
	End if 
	ARRAY TEXT:C222(aTmpText1; 0)
	vText1:=""
	vText2:=""
	vText3:=""
	$working_t:=""
End if 