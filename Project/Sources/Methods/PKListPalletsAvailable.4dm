//%attributes = {"publishedWeb":true}
//PKListPalletsAvailable  ([Order]customerID)
C_TEXT:C284($1)

QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26=2; *)  //pallets only
QUERY:C277([LoadTag:88];  & [LoadTag:88]completeid:36<2; *)
QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=$1)

ARRAY TEXT:C222(aPalletsAvailable; 0)
ARRAY LONGINT:C221(aPalletsUniqueID; 0)
//
C_LONGINT:C283($k; $i; $w)
$k:=Records in selection:C76([LoadTag:88])
If ($k>0)
	FIRST RECORD:C50([LoadTag:88])
	$w:=Size of array:C274(aPalletsAvailable)
	For ($i; 1; $k)
		APPEND TO ARRAY:C911(aPalletsUniqueID; [LoadTag:88]idNum:1)
		APPEND TO ARRAY:C911(aPalletsAvailable; "Pallet: "+String:C10([LoadTag:88]idNum:1)+", Original Order: "+String:C10([LoadTag:88]documentid:17)+", Comment: "+[LoadTag:88]comment:22)
		NEXT RECORD:C51([LoadTag:88])
	End for 
	UNLOAD RECORD:C212([LoadTag:88])
End if 
//
SORT ARRAY:C229(aPalletsAvailable; aPalletsUniqueID)

// ### jwm ### 20180511_1640 Title Set in Form Method
//
//INSERT IN ARRAY(aPalletsAvailable;1;1)
//INSERT IN ARRAY(aPalletsUniqueID;1;1)
//aPalletsAvailable{1}:="Pallets"
//aPalletsUniqueID{1}:=-1
//aPalletsAvailable:=1
//