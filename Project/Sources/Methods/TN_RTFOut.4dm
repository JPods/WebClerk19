//%attributes = {"publishedWeb":true}
//Method: TN_RTFOut
If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 
ALL RECORDS:C47([TechNote:58])
C_LONGINT:C283($1; $theTable; $2; $theField)
Case of 
	: (Count parameters:C259=0)
		$theTable:=Table:C252(->[TechNote:58])
		$theField:=Field:C253(->[TechNote:58]Objective:4)
	: (Count parameters:C259=2)
		$theTable:=$1
		$theField:=$2
	Else 
		ALERT:C41("You must specify the Table number and Field Number to post out.")
End case 
//ALL RECORDS([TechNote])
CONFIRM:C162("Send "+String:C10(Records in selection:C76(Table:C252($theTable)->))+" RTF documents?")
If (OK=1)
	C_LONGINT:C283($i; $k; $thePrint; $err)
	$k:=Records in table:C83(Table:C252($theTable)->)
	FIRST RECORD:C50(Table:C252($theTable)->)
	For ($i; 1; $k)
		//$offArea:=  //**WR New offscreen area 
		//**WR PICTURE TO AREA ($offArea;[TechNote]Body_)
		//$err:=  //**WR Replace ($offArea;"theCustomer";"CommerceExpert";//**WR partial match;//**WR ignore uppercase;//**WR replace all;//**WR whole document)
		//*[TechNote]Body_:=  //**WR Area to picture ($offArea)
		[TechNote:58]Summary:3:=Replace string:C233([TechNote:58]Summary:3; "theCustomer"; "CommerceExpert")
		[TechNote:58]Name:2:=Replace string:C233([TechNote:58]Name:2; "theCustomer"; "CommerceExpert")
		[TechNote:58]Subject:6:=Replace string:C233([TechNote:58]Subject:6; "theCustomer"; "CommerceExpert")
		ShipAddress:="TN_"+String:C10([TechNote:58]Chapter:14)+"_"+String:C10([TechNote:58]Section:15)+Substring:C12([TechNote:58]Name:2; 1; 15)+".rtf"
		SET TEXT TO PASTEBOARD:C523(ShipAddress)
		// //**WR EXECUTE COMMAND ($offArea;104)
		//**WR DELETE OFFSCREEN AREA ($offArea)
		SAVE RECORD:C53(Table:C252($theTable)->)
		NEXT RECORD:C51(Table:C252($theTable)->)
	End for 
End if 
UNLOAD RECORD:C212(Table:C252($theTable)->)
