//%attributes = {"publishedWeb":true}
//C_LONGINT($k;$i)
//If ($1=0)
//$k:=0
//array TEXT(acShipCo;$k)
//array TEXT(acShipAddr1;$k)
//array TEXT(acShipCity;$k)
//array TEXT(acShipLast;$k)
//array TEXT(acShipFirst;$k)
//ARRAY LONGINT(acShipRec;$k)
//Else 
//SELECTION TO ARRAY([Contact];acShipRec;[Contact]Company;acShipCo;
//[Contact]Address1;acShipAddr1;[Contact]City;acShipCity;[Contacts
//]FirstName;acShipFirst;[Contact]LastName;acShipLast)
//End if //