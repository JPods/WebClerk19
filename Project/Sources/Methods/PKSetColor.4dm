//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:16:10
// ----------------------------------------------------
// Method: PKSetColor
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k; $1)
//$1 is arrar list
//$2 is aOItemNum or similar array(
If ($1>0)
	$k:=Size of array:C274($2->)
	For ($i; 1; $k)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->{$i})
		
		
		If (False:C215)
			
			//preferred method sets only fore ground or back ground
			Case of   //background color empty string does not change color
				: ([Item:4]backOrder:24=True:C214)
					// -- AL_SetRowRGBColor($1; $i; -1; -1; -1; 0x00DD; 0x00DD; 0x00DD)  //light gray background
				: ([Item:4]retired:64=True:C214)
					// -- AL_SetRowRGBColor($1; $i; -1; -1; -1; 0x00FF; 0x00FF; 0x0099)  //light yellow background
				: ((aOQtyBL{$i}<0) | (aOQtyOrder{$i}<0))
					// -- AL_SetRowRGBColor($1; $i; -1; -1; -1; 0x00FF; 0x00BB; 0x00BB)  //light red background
				Else 
					// -- AL_SetRowRGBColor($1; $i; -1; -1; -1; 0x00FF; 0x00FF; 0x00FF)  //white background
			End case 
			Case of   //text color
				: (aOQtyBL{$i}=0)
					// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; -1; -1; -1)  //gray text
				: ([Item:4]qtyOnHand:14<=0)
					// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; -1; -1; -1)  //red text
				Else 
					// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; -1; -1; -1)  //black text
			End case 
			
		End if 
		
		//previous method sets both at the same time requires more definitions
		//one definiton for each possible combination of foreground and background
		
		If (True:C214)
			Case of 
					
				: (([Item:4]backOrder:24=True:C214) & (aOQtyBL{$i}=0))
					//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00DD; 0x00DD; 0x00DD)  //gray on light gray
					
				: (([Item:4]retired:64=True:C214) & (aOQtyBL{$i}=0))
					//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00FF; 0x00FF; 0x0099)  //gray on yellow
					
				: ((aOQtyBL{$i}=0) & (aOQtyOrder{$i}<0))
					//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00FF; 0x00BB; 0x00BB)  //gray on red
					
				: ((aOQtyBL{$i}=0) & (aOQtyOrder{1}>=0))
					//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0099; 0x0099; 0x0099; 0x00FF; 0x00FF; 0x00FF)  //light gray on white
					
				: ((aOQtyBL{$i}<0) & ([Item:4]qtyOnHand:14>0))  //credit
					//// -- AL_SetRowColor (eOrdList;$i;"red";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00FF; 0x00BB; 0x00BB)  //black on red
					
				: ((aOQtyBL{$i}<0) & ([Item:4]qtyOnHand:14<=0))  //credit
					//// -- AL_SetRowColor (eOrdList;$i;"red";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00BB; 0x00BB)  //red on red
					
				: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14<=0))
					//// -- AL_SetRowColor ($1;$i;"red";0;"yellow";0)
					// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x0099)  //red on yellow
					
					//// -- AL_SetRowStyle ($1;$i;1;"")//bold
				: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14>0))
					//// -- AL_SetRowColor ($1;$i;"black";0;"yellow";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x0099)  //black on yellow
					
					//// -- AL_SetRowStyle ($1;$i;0;"")//plain
				: (([Item:4]backOrder:24=True:C214) & ([Item:4]qtyOnHand:14<=0))  //(aLsDocType{$i}="*")
					//// -- AL_SetRowColor ($1;$i;"red";0;"light gray";0)
					// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  //red on light gray
					
					//// -- AL_SetRowStyle ($1;$i;1;"")//bold
				: (([Item:4]backOrder:24=True:C214) & ([Item:4]qtyOnHand:14>0))  //(aLsDocType{$i}="*")
					//// -- AL_SetRowColor ($1;$i;"black";0;"light gray";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  //black on light gray
					
					//// -- AL_SetRowStyle ($1;$i;0;"")//plain
				: ([Item:4]qtyOnHand:14<=0)  //(aLsQtyOH{$i}<0)//
					//// -- AL_SetRowColor ($1;$i;"red";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x00FF)  //red on white
					
					//// -- AL_SetRowStyle ($1;$i;1;"")//bold
					//Old color code
				: ([Item:4]backOrder:24)
					//// -- AL_SetRowColor (eOrdList;$i;"red";0;"light gray";0)
					// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  //red on light gray
					
				: (aoPrintThis{$I}=1)
					// -- AL_SetRowRGBColor($1; $i; 0x00FF; 0x00FF; 0x00FF; 0x00AA; 0x00AA; 0x00AA)  //white on gray
					
				Else 
					//// -- AL_SetRowColor ($1;$i;"black";0;"white";0)
					// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x00FF)  //black on white
			End case 
		End if 
	End for 
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
	//###_jwm_### 20100414 end
End if 