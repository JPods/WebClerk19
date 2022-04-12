//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/22/21, 22:03:24
// ----------------------------------------------------
// Method: camelCase_FixFieldName
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_COLLECTION:C1488($cIDs)
C_LONGINT:C283($w)
$cIDs:=New collection:C1472
$cIDs:=Split string:C1554("repID,customerID,vendorID,taskID,remoteRecordID,mfrID,nameID,"+\
"salesNameID,codeID,groupID,eventID,classID,mfrID,documentID,taxID,typeID,docID,"+\
"territoryID,termID,trackID,siteID,custVendID,salesNameID,webClerkID,linkID,"+\
"remoteUserID,transactionID,revisionID,typeID,contractDetail"; ",")
// change typeID sometime
//termsandconditions to contractTerm
//terms to termID
//salesNameID risky
//change custLeadID to customerID
$w:=$cIDs.indexOf("customerID")
$w:=$cIDs.indexOf("sdfsdfcustomerID")
C_TEXT:C284($1; $vtFieldName; $0; $vtCamelCase)
$vtFieldName:=$1
Case of 
	: ($vtFieldName="")
		$vtCamelCase:="ErrorEmptyField"
		
	: ($vtFieldName="UUIDKey")
		$vtCamelCase:="id"
	: ($vtFieldName="UUIDKeyForeign")
		$vtCamelCase:="idForeign"
		//  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName
	: ($vtFieldName="UUIDForeign")
		$vtCamelCase:="idForeign"
		//  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName
	: ($vtFieldName="id@")
		$vtCamelCase:="id"+Substring:C12($vtFieldName; 8)
		//  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName
	: ($vtFieldName="uUID@")
		$vtCamelCase:="id"+Substring:C12($vtFieldName; 5)
		
	: ($vtFieldName="UniqueID")
		$vtCamelCase:="idNum"
	: ($vtFieldName="UniqueID@")
		$vtCamelCase:="idNum"+Substring:C12($vtFieldName; 9)
		
		
	: ($vtFieldName="projectid")
		$vtCamelCase:="projectNum"
		
	: ($vtFieldName="tableID")
		$vtCamelCase:="tableNum"
	: ($vtFieldName="fieldID")
		$vtCamelCase:="fieldNum"
		
	: ($vtFieldName="dt@")
		$vtCamelCase:="dt"+Uppercase:C13($vtFieldName[[3]])+Substring:C12($vtFieldName; 4)
	: ($vtFieldName="WO@")
		$vtCamelCase:="wo"+Substring:C12($vtFieldName; 3)
		//  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName
		
		
	: ($vtFieldName="FirstName")
		$vtCamelCase:="nameFirst"
	: ($vtFieldName="LastName")
		$vtCamelCase:="nameLast"
	: ($vtFieldName="NickName")
		$vtCamelCase:="nameNick"
		
	: ($vtFieldName="manufacturerID")
		$vtCamelCase:="mfrID"
		
	: ($vtFieldName="salesid")
		$vtCamelCase:="salesNameID"
	: ($vtFieldName="actionNameid")
		$vtCamelCase:="actionBy"
	: ($vtFieldName="proposalLineID")
		$vtCamelCase:="idNum"
	: ($vtFieldName="pPLineid")
		$vtCamelCase:="idNum"
		
	: ($vtFieldName="poLineID")
		$vtCamelCase:="idNum"
	: ($vtFieldName="orderLineID")
		$vtCamelCase:="idNum"
	: ($vtFieldName="contactID")
		$vtCamelCase:="idNum"
		
	: ($vtFieldName="custVendID")
		$vtCamelCase:="customerID"
	: ($vtFieldName="custLeadid")
		$vtCamelCase:="customerID"
	: ($vtFieldName="salesRepid")
		$vtCamelCase:="repID"
		
	: ($vtFieldName="taxid")
		$vtCamelCase:="taxJuris"
		
		
		
	: ($vtFieldName="transActID")  // check the risks of an empty value
		$vtCamelCase:="zzzz"
		
		
		
	: ($vtFieldName="changeid")
		$vtCamelCase:="change"
		
		
		
	: ($vtFieldName="latlng")
		$vtCamelCase:="lat"
		
	: ($vtFieldName="FAX")
		$vtCamelCase:="fax"
	: ($vtFieldName="email")
		$vtCamelCase:="email"
	: ($vtFieldName="emailVerified")
		$vtCamelCase:="emailVerified"
	: ($vtFieldName="FOB")
		$vtCamelCase:="fob"
	: ($vtFieldName="UPS@")
		$vtCamelCase:="ups"+Substring:C12($vtFieldName; 4)
	: ($vtFieldName="MFR@")
		$vtCamelCase:="mfr"+Substring:C12($vtFieldName; 4)
	: ($vtFieldName="CC")
		$vtCamelCase:="cc"
	: ($vtFieldName="cC@")
		$vtCamelCase:="cc"+Substring:C12($vtFieldName; 3)
		//: ($vtFieldName="fieldID@")
		//$vtCamelCase:="idField"+Substring($vtFieldName; 8)
		////  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName
	: ($vtFieldName="HTML@")
		$vtCamelCase:="html"+Substring:C12($vtFieldName; 5)
	: ($vtFieldName="XML@")
		$vtCamelCase:="xml"+Substring:C12($vtFieldName; 4)
		//: ($vtFieldName="messageIMAPID")
		//$vtCamelCase:="messageImapId"
	: ($vtFieldName="mTD@")
		$vtCamelCase:="mtd"+Substring:C12($vtFieldName; 4)
	: ($vtFieldName="YTD@")
		$vtCamelCase:="ytd"+Substring:C12($vtFieldName; 4)
		//: ($vtFieldName="nameAR")
		//$vtCamelCase:="nameAr"
	: ($vtFieldName="nameIDAlt")
		$vtCamelCase:="idNameAlt"
		//  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName
		//: ($vtFieldName="nameIDTakenBy")
		//$vtCamelCase:="nameIdTakenBy"
		//: ($vtFieldName="noCODHand")
		//$vtCamelCase:="noCodHand"
		//: ($vtFieldName="order2POByBLQ")
		//$vtCamelCase:="order2PoByBLQ"
	: ($vtFieldName="seq@")
		$vtCamelCase:="seq"+Substring:C12($vtFieldName; 4)
	: ($vtFieldName="sku@")
		$vtCamelCase:="sku"+Substring:C12($vtFieldName; 4)
	: ($vtFieldName="ssl@")
		$vtCamelCase:="ssl"+Substring:C12($vtFieldName; 4)
	Else 
		$vtCamelCase:=Lowercase:C14($vtFieldName[[1]])+Substring:C12($vtFieldName; 2)
End case 

$viLastChar:=Length:C16($vtCamelCase)
If (($vtCamelCase[[$viLastChar-1]]="i") & ($vtCamelCase[[$viLastChar]]="d"))
	If ($cIDs.indexOf($vtCamelCase)>-1)
		$vtCamelCase[[$viLastChar-1]]:="I"
		$vtCamelCase[[$viLastChar]]:="D"
		// repID, customerID, vendorID, taskID, remoteRecordID, mfrID, nameID, salesNameID
	Else 
		If ($vtCamelCase#"id")
			
		End if 
	End if 
End if 
// watch this for risk to word ending in id that are not ID's
//  $vtReport:=$vtReport+"\r"+$vtCamelCase+"\t"+$vtFieldName

If ($vtCamelCase#$vtFieldName)
	
End if 
$0:=$vtCamelCase