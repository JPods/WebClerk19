//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/28/18, 13:07:40
// ----------------------------------------------------
// Method: SelectSortFormat
// Description
// 
//
// Parameters
// ----------------------------------------------------

//SelectSortFormat($vtField;$vtObjectName;$vpField)

//<declarations>
//==================================
//  Type variables 
//==================================

// $1;$2;$3;variable;variables
C_LONGINT:C283($viTable)
C_TEXT:C284($vtCode; $vtField; $vtFieldName; $vtInvisibleButton; $vtNumber; $vtObjectName)
C_TEXT:C284($vtPath; $tableName; $vtVariable; $1; $2)
C_POINTER:C301($vpField; $vpVariable; $3)

//==================================
//  Initialize variables 
//==================================

$vtField:=$1  // Field Name "OrderNum"
$vtObjectName:=$2
$vpField:=$3
$viTable:=Table:C252($vpField)
$tableName:=Table name:C256($viTable)
$vtFieldName:=Field name:C257($vpField)
//</declarations>

//Set default button Sort Method
//$vtNumber:=String(Num($vtObjectName))
//$vtInvisibleButton:="InvisibleButton_"+$vtNumber
//$vtPath:="[tableForm]/"+$tableName+"/Output/"+$vtInvisibleButton
//$vtCode:="\rSortButton\r"
//METHOD SET CODE($vtPath;$vtCode)  // code of a single method

Case of 
	: (Type:C295($vpField->)=Is longint:K8:6)
		
		Case of 
			: (($vtField="OrderNum") | ($vtField="InvoiceNum") | ($vtField="ProposalNum") | ($vtField="PONum"))  //| ($vtField="idNum")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align center:K42:3)
				OBJECT SET FORMAT:C236(*; $vtObjectName; "0000-0000")
				
			: ($vtField="DT@")
				
				// change source of form object to variable
				$vtVariable:="vt"+$vtField
				$vpVariable:=Get pointer:C304($vtVariable)
				OBJECT SET DATA SOURCE:C1264(*; $vtObjectName; $vpVariable)
				
				// set object method for variable to convert DT variable
				//$vtPath:="[tableForm]/"+$tableName+"/Output/"+$vtObjectName
				//$vtCode:="C_TEXT("+$vtVariable+")\r"
				//$vtCode:=$vtCode+$vtVariable+":=jDateTimeRBoth (["+$tableName+"]"+$vtFieldName+")\r"
				//METHOD SET CODE($vtPath;$vtCode)  // code of a single method
				
				// set Object method of Invisible button to sort by formula
				//$vtNumber:=String(Num($vtObjectName))
				//$vtInvisibleButton:="InvisibleButton_"+$vtNumber
				//$vtPath:="[tableForm]/"+$tableName+"/Output/"+$vtInvisibleButton
				//$vtCode:="SortButton (\"["+$tableName+"]"+$vtFieldName+"\")\r"
				//METHOD SET CODE($vtPath;$vtCode)  // code of a single method
				
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
				OBJECT SET FORMAT:C236(*; $vtObjectName; "")
				
			Else 
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
				OBJECT SET FORMAT:C236(*; $vtObjectName; "###,###,###,##0")
		End case 
		
	: (Type:C295($vpField->)=Is real:K8:4)
		
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
		Case of 
			: (($vtField="@Price@"))
				OBJECT SET FORMAT:C236(*; $vtObjectName; "###,###,###,##0.00")  // whole numbers in output layout
				
			: (($vtField="@Cost@"))
				OBJECT SET FORMAT:C236(*; $vtObjectName; "###,###,###,##0.000")  // whole numbers in output layout
				
			: (($vtField="@Percent@"))
				OBJECT SET FORMAT:C236(*; $vtObjectName; "###,###,###,##0.000 %")  // whole numbers in output layout
				
			Else 
				
				OBJECT SET FORMAT:C236(*; $vtObjectName; "###,###,###,##0.###")  // whole numbers in output layout
				
		End case 
		
	: (Type:C295($vpField->)=_o_Is float:K8:26)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
		OBJECT SET FORMAT:C236(*; $vtObjectName; "###,###,###,##0")  // whole numbers in output layout
		
	: (Type:C295($vpField->)=Is alpha field:K8:1)
		//OBJECT SET FORMAT(*;$vtObjectName;"")
		If (($vtField="@phone@") | ($vtField="@fax@") | ($vtField="@Cell@"))
			//  Put  the formating in the form  jFormatPhone($vpField)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align center:K42:3)
		Else 
			OBJECT SET FORMAT:C236(*; $vtObjectName; "")
			OBJECT SET TITLE:C194(*; $vtObjectName; "")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
			
		End if 
		
	: (Type:C295($vpField->)=Is text:K8:3)
		OBJECT SET FORMAT:C236(*; $vtObjectName; "@")
		// fax should be Alpha
		If (($vtField="@phone@") | ($vtField="@fax@") | ($vtField="@Cell@"))
			//  Put  the formating in the form  jFormatPhone($vpField)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align center:K42:3)
		Else 
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
			OBJECT SET FORMAT:C236(*; $vtObjectName; "")
		End if 
		
	: (Type:C295($vpField->)=Is date:K8:7)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $vtObjectName; Char:C90(Internal date short:K1:7))
		
	: (Type:C295($vpField->)=Is time:K8:8)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $vtObjectName; Char:C90(HH MM SS:K7:1))
		
	: (Type:C295($vpField->)=Is boolean:K8:9)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $vtObjectName; $vtField)
		OBJECT SET TITLE:C194(*; $vtObjectName; $vtField)
		
	Else 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
		OBJECT SET FORMAT:C236(*; $vtObjectName; "")
		OBJECT SET TITLE:C194(*; $vtObjectName; "")
		
End case 
