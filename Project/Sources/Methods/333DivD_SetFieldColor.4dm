//%attributes = {"publishedWeb":true}
////Method: //  should we care -- //  CHOPPED DivD_SetFieldColor
//C_POINTER($1; $gui_ptr)
//$gui_ptr:=$1
//C_TEXT($2; $Div)
//If (Count parameters>=2)
//$Div:=$2
//Else 
//$Div:=Cust_GetDivision
//End if 
//C_BOOLEAN($3; $DoSearch)
//If (Count parameters>=3)
//$DoSearch:=$3
//Else 
//$DoSearch:=True
//End if 

//If (Not(Is nil pointer($gui_ptr)))
//If ($div#"")
//If ($DoSearch)
//If (([DivisionDefault]idNum#$Div) | (Record number([DivisionDefault])=-1))
//QUERY([DivisionDefault]; [DivisionDefault]idNum=$Div)
//End if 
//End if 
//If (Record number([DivisionDefault])>=0)
//If (Substring([DivisionDefault]alertColor; 1; 1)="0")
//OBJECT SET RGB COLORS($gui_ptr->; 0x0000; Num([DivisionDefault]alertColor))
//Else 
//C_LONGINT($color)
//Case of 
//: ([DivisionDefault]alertColor="White")
//$color:=White
//: ([DivisionDefault]alertColor="Yellow")
//$color:=Yellow
//: ([DivisionDefault]alertColor="Orange")
//$color:=Orange
//: ([DivisionDefault]alertColor="Red")
//$color:=Red
//: ([DivisionDefault]alertColor="Purple")
//$color:=Purple
//: ([DivisionDefault]alertColor="Dark Blue")
//$color:=Dark blue
//: ([DivisionDefault]alertColor="Blue")
//$color:=Blue
//: ([DivisionDefault]alertColor="Light Blue")
//$color:=Light blue
//: ([DivisionDefault]alertColor="Green")
//$color:=Green
//: ([DivisionDefault]alertColor="Dark Green")
//$color:=Dark green
//: ([DivisionDefault]alertColor="Dark Brown")
//$color:=Dark brown
//: ([DivisionDefault]alertColor="Dark grey")
//$color:=Dark grey
//: ([DivisionDefault]alertColor="Light grey")
//$color:=Light grey
//: ([DivisionDefault]alertColor="Brown")
//$color:=Brown
//: ([DivisionDefault]alertColor="Grey")
//$color:=Grey
//Else 
//$color:=White
//End case 
//_O_OBJECT SET COLOR($gui_ptr->; -(Black+(256*$color)))
//End if 
//End if 
//Else 
//If (Records in table([DivisionDefault])>0)  //only set colors if there are any [divdefault] otherwise don't touch
//_O_OBJECT SET COLOR($gui_ptr->; -(Black+(256*White)))
//End if 
//End if 
//End if 